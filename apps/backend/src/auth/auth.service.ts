import { BadRequestException, ForbiddenException, HttpException, Injectable, NotFoundException, UnauthorizedException } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import { createHash, randomBytes, randomInt, timingSafeEqual } from "crypto";
import * as bcrypt from "bcrypt";
import { Response } from "express";
import { PrismaService } from "../prisma/prisma.service";
import { MailService } from "./mail.service";

const OTP_TTL_MS = 5 * 60 * 1000;
const OTP_RESEND_MS = 30 * 1000;
const GES_ROLES = ["GES_ADMIN", "GES_USER"] as const;

function hashToken(token: string) {
  return createHash("sha256").update(token).digest("hex");
}

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly mail: MailService,
  ) {}

  async gesProfiles() {
    const users = await this.prisma.user.findMany({
      where: {
        active: true,
        gesId: { not: null },
        roles: { some: { role: { name: { in: [...GES_ROLES] } } } },
      },
      include: { ges: true },
      orderBy: { name: "asc" },
    });
    const covered = new Set(users.map((user) => user.gesId));
    const accounts = await this.prisma.gES.findMany({
      where: { id: { notIn: [...covered].filter((id): id is string => Boolean(id)) } },
      orderBy: { name: "asc" },
    });
    const people = users
      .filter((user) => user.ges)
      .map((user) => ({
        id: user.id,
        gesId: user.gesId,
        name: user.name,
        gesName: user.ges?.name ?? user.title,
        initials: initials(user.name),
      }));
    const contacts = accounts
      .filter((account) => account.contactEmail.trim().includes("@"))
      .map((account) => ({
        id: `ges:${account.id}`,
        gesId: account.id,
        name: account.contactName.trim() || account.name,
        gesName: account.name,
        initials: initials(account.contactName.trim() || account.name),
      }));
    return [...people, ...contacts];
  }

  async requestGesOtp(profileId: string) {
    const user = await this.resolveGesUser(profileId);
    if (!user.email.includes("@")) throw new BadRequestException("This GES profile has no email address");
    const pending = await this.prisma.loginOtp.findFirst({
      where: { userId: user.id, consumedAt: null },
      orderBy: { createdAt: "desc" },
    });
    if (pending && pending.resendAt.getTime() > Date.now()) {
      const wait = Math.ceil((pending.resendAt.getTime() - Date.now()) / 1000);
      throw new HttpException(`Wait ${wait} seconds before requesting another code.`, 429);
    }
    const code = randomInt(0, 10000).toString().padStart(4, "0");
    const ges = user.gesId
      ? await this.prisma.gES.findUnique({ where: { id: user.gesId }, select: { name: true } })
      : null;
    const requestedAt = new Date();
    const delivery = await this.mail.sendSignInCode({
      to: user.email,
      name: user.name,
      gesName: ges?.name ?? user.title,
      code,
      requestedAt,
      expiresAt: new Date(requestedAt.getTime() + OTP_TTL_MS),
      resendSeconds: OTP_RESEND_MS / 1000,
      reason: "signin",
    });
    await this.prisma.loginOtp.deleteMany({ where: { userId: user.id, consumedAt: null } });
    const now = Date.now();
    await this.prisma.loginOtp.create({
      data: {
        userId: user.id,
        codeHash: this.hashCode(code),
        expiresAt: new Date(now + OTP_TTL_MS),
        resendAt: new Date(now + OTP_RESEND_MS),
      },
    });
    return {
      profileId,
      maskedEmail: maskEmail(user.email),
      resendInSeconds: OTP_RESEND_MS / 1000,
      expiresInSeconds: OTP_TTL_MS / 1000,
      delivery: delivery.delivery,
      ...(delivery.delivery === "logged" && process.env.NODE_ENV !== "production" ? { devCode: code } : {}),
    };
  }

  async verifyGesOtp(profileId: string, code: string, response: Response) {
    const user = await this.resolveGesUser(profileId);
    await this.consumeOtp(user.id, code);
    return this.issue(user.id, response);
  }

  async requestGesOtpByEmail(email: string) {
    const user = await this.prisma.user.findUnique({
      where: { email: email.toLowerCase().trim() },
      include: { roles: { include: { role: true } } },
    });
    const customer = user?.roles.some((item) => item.role.name === "GES_ADMIN" || item.role.name === "GES_USER");
    if (user && customer && user.gesId && user.accessStatus === "PENDING") {
      throw new ForbiddenException("Your account is saved, but NewRa Grids has not accepted it yet. You can sign in after they accept.");
    }
    if (user && customer && user.gesId && user.accessStatus === "REJECTED") {
      throw new ForbiddenException("NewRa Grids has not given this account access.");
    }
    if (!user?.active || !user.gesId || !customer) {
      throw new NotFoundException("This email is not registered. Create an account first. You can sign in only after NewRa Grids accepts you.");
    }
    return this.requestGesOtp(user.id);
  }

  async startSignup(input: { name: string; email: string; gesName: string; phone: string }) {
    const email = input.email.toLowerCase().trim();
    const name = input.name.trim();
    const gesName = input.gesName.trim();
    const phone = cleanPhone(input.phone);
    if (name.length < 2 || gesName.length < 2) throw new BadRequestException("Enter your name and organisation");
    const existing = await this.prisma.user.findUnique({
      where: { email },
      include: { roles: { include: { role: true } } },
    });
    if (existing?.active) throw new BadRequestException("This email already has a profile. Sign in instead.");
    if (existing && !existing.roles.some((item) => item.role.name === "GES_ADMIN" || item.role.name === "GES_USER")) {
      throw new BadRequestException("This email is already used by a NewRa account");
    }
    const user = existing ?? await this.createSignupUser(name, email, gesName, phone);
    if (existing) {
      await this.prisma.user.update({
        where: { id: existing.id },
        data: { name, title: gesName, phone, accessStatus: "PENDING", active: false },
      });
      if (existing.gesId) {
        await this.prisma.gES.update({
          where: { id: existing.gesId },
          data: { name: gesName, legalName: gesName, contactName: name, contactEmail: email, contactPhone: phone },
        });
      }
    }
    const challenge = await this.sendCode(user.id, "signup");
    return challenge;
  }

  async verifySignup(email: string, code: string) {
    const user = await this.prisma.user.findUnique({ where: { email: email.toLowerCase().trim() } });
    if (!user || user.active || !user.gesId) throw new UnauthorizedException("Create a profile before entering this code.");
    await this.consumeOtp(user.id, code);
    await this.prisma.user.update({ where: { id: user.id }, data: { active: false, accessStatus: "PENDING" } });
    const emailSent = await this.notifySuperAdmin(user.id);
    return { pending: true as const, emailSent };
  }

  async household(actor: { gesId?: string | null }) {
    if (!actor.gesId) return { gesId: null, gesName: "", profiles: [] };
    return this.profilesFor(actor.gesId);
  }

  async addProfile(actor: { gesId?: string | null }, input: { name: string; email: string; phone: string }) {
    if (!actor.gesId) throw new ForbiddenException("Sign in to a GES profile before adding another");
    const email = input.email.toLowerCase().trim();
    const name = input.name.trim();
    const phone = cleanPhone(input.phone);
    if (name.length < 2) throw new BadRequestException("Enter the profile name");
    const ges = await this.prisma.gES.findUnique({ where: { id: actor.gesId } });
    if (!ges) throw new NotFoundException("GES account was not found");
    const existing = await this.prisma.user.findUnique({ where: { email } });
    if (existing?.active) throw new BadRequestException("That email already has a profile");
    if (existing && existing.gesId && existing.gesId !== ges.id) {
      throw new BadRequestException("That email is already used by another account");
    }
    const user = existing
      ? await this.prisma.user.update({ where: { id: existing.id }, data: { name, phone, title: ges.name, gesId: ges.id, active: false, accessStatus: "PENDING" } })
      : await this.createProfileUser(name, email, phone, ges.id, ges.name);
    return this.sendCode(user.id, "profile");
  }

  async verifyAddedProfile(email: string, code: string) {
    const user = await this.prisma.user.findUnique({ where: { email: email.toLowerCase().trim() } });
    if (!user || user.active || !user.gesId) throw new UnauthorizedException("That profile is not waiting for a code.");
    await this.consumeOtp(user.id, code);
    await this.prisma.user.update({ where: { id: user.id }, data: { active: false, accessStatus: "PENDING" } });
    const emailSent = await this.notifySuperAdmin(user.id);
    return { pending: true as const, emailSent };
  }

  async listGesAccess(actor: { roles?: string[] }) {
    this.assertSuperAdmin(actor);
    const users = await this.prisma.user.findMany({
      where: {
        accessStatus: { not: "REJECTED" },
        roles: { some: { role: { name: { in: [...GES_ROLES] } } } },
      },
      include: { ges: true, roles: { include: { role: true } } },
      orderBy: { createdAt: "desc" },
    });
    return users.map((user) => ({
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      gesId: user.gesId,
      gesName: user.ges?.name ?? user.title,
      role: user.roles[0]?.role.name ?? "GES_USER",
      accessStatus: user.accessStatus,
      active: user.active,
    }));
  }

  async addGesUser(actor: { roles?: string[] }, input: { name: string; email: string; phone: string; gesId: string }) {
    this.assertSuperAdmin(actor);
    const email = input.email.toLowerCase().trim();
    const name = input.name.trim();
    const phone = cleanPhone(input.phone);
    if (name.length < 2) throw new BadRequestException("Enter the user name");
    const ges = await this.prisma.gES.findUnique({ where: { id: input.gesId } });
    if (!ges) throw new NotFoundException("GES account was not found");
    const existing = await this.prisma.user.findUnique({
      where: { email },
      include: { roles: { include: { role: true } } },
    });
    const roleNames = existing?.roles.map((item) => item.role.name) ?? [];
    const customer = roleNames.some((role) => role === "GES_ADMIN" || role === "GES_USER");
    if (existing && roleNames.length > 0 && !customer) {
      throw new BadRequestException("That email belongs to a NewRa staff account");
    }
    if (existing?.active && existing.accessStatus === "APPROVED") {
      throw new BadRequestException("That email already has access");
    }
    const role = await this.prisma.role.findUnique({ where: { name: "GES_USER" } });
    if (!role) throw new BadRequestException("GES access is not ready yet");
    const user = existing
      ? await this.prisma.user.update({
          where: { id: existing.id },
          data: { name, phone, title: ges.name, gesId: ges.id, active: true, accessStatus: "APPROVED" },
        })
      : await this.prisma.user.create({
          data: {
            id: `usr_${ges.id}_${Date.now()}`,
            email,
            name,
            phone,
            title: ges.name,
            passwordHash: await bcrypt.hash(randomBytes(24).toString("hex"), 10),
            gesId: ges.id,
            active: true,
            accessStatus: "APPROVED",
            roles: { create: { roleId: role.id } },
          },
        });
    await this.mail.sendAccessDecision(user.email, user.name, ges.name, true).catch(() => undefined);
    return { id: user.id, accessStatus: "APPROVED" as const };
  }

  async decideGesAccess(actor: { roles?: string[] }, userId: string, accept: boolean) {
    this.assertSuperAdmin(actor);
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      include: { ges: true, roles: { include: { role: true } } },
    });
    const customer = user?.roles.some((item) => item.role.name === "GES_ADMIN" || item.role.name === "GES_USER");
    if (!user || !customer) throw new NotFoundException("GES user was not found");
    const saved = await this.prisma.user.update({
      where: { id: user.id },
      data: { active: accept, accessStatus: accept ? "APPROVED" : "REJECTED" },
    });
    if (!accept) {
      await this.prisma.refreshToken.updateMany({
        where: { userId: user.id, revokedAt: null },
        data: { revokedAt: new Date() },
      });
    }
    await this.mail.sendAccessDecision(saved.email, saved.name, user.ges?.name ?? saved.title, accept).catch(() => undefined);
    return { id: saved.id, accessStatus: saved.accessStatus };
  }

  async login(email: string, password: string, response: Response) {
    const user = await this.prisma.user.findUnique({ where: { email: email.toLowerCase().trim() } });
    if (!user || !user.active || !(await bcrypt.compare(password, user.passwordHash))) {
      throw new UnauthorizedException("Email or password is incorrect");
    }
    return this.issue(user.id, response);
  }

  async refresh(token: string | undefined, response: Response) {
    if (!token) throw new UnauthorizedException("Refresh token missing");
    const stored = await this.prisma.refreshToken.findFirst({
      where: { tokenHash: hashToken(token), revokedAt: null, expiresAt: { gt: new Date() } },
    });
    if (!stored) throw new UnauthorizedException("Refresh token is no longer valid");
    await this.prisma.refreshToken.update({ where: { id: stored.id }, data: { revokedAt: new Date() } });
    return this.issue(stored.userId, response);
  }

  async logout(token: string | undefined, response: Response) {
    if (token) {
      await this.prisma.refreshToken.updateMany({
        where: { tokenHash: hashToken(token), revokedAt: null },
        data: { revokedAt: new Date() },
      });
    }
    this.clear(response);
    return { signedOut: true };
  }

  private async issue(userId: string, response: Response) {
    const accessToken = await this.jwt.signAsync({ sub: userId }, { expiresIn: process.env.JWT_ACCESS_TTL || "15m" });
    const refreshToken = randomBytes(48).toString("hex");
    await this.prisma.refreshToken.create({
      data: {
        userId,
        tokenHash: hashToken(refreshToken),
        expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
      },
    });
    const secure = process.env.NODE_ENV === "production";
    response.cookie("newra_access", accessToken, { httpOnly: true, sameSite: "lax", secure, path: "/" });
    response.cookie("newra_refresh", refreshToken, { httpOnly: true, sameSite: "lax", secure, path: "/api/auth" });
    const user = await this.prisma.user.findUniqueOrThrow({
      where: { id: userId },
      include: { roles: { include: { role: { include: { permissions: { include: { permission: true } } } } } } },
    });
    const permissions = [...new Set(user.roles.flatMap((role) => role.role.permissions.map((item) => item.permission.key)))];
    return {
      accessToken,
      user: {
        id: user.id,
        email: user.email,
        name: user.name,
        title: user.title,
        role: user.roles[0]?.role.name ?? "VIEWER",
        roles: user.roles.map((role) => role.role.name),
        permissions,
        gesId: user.gesId,
      },
    };
  }

  private clear(response: Response) {
    response.clearCookie("newra_access", { path: "/" });
    response.clearCookie("newra_refresh", { path: "/api/auth" });
  }

  private async consumeOtp(userId: string, code: string) {
    const pending = await this.prisma.loginOtp.findFirst({
      where: { userId, consumedAt: null },
      orderBy: { createdAt: "desc" },
    });
    if (!pending || pending.expiresAt.getTime() <= Date.now()) {
      throw new UnauthorizedException("That code has expired. Request a new one.");
    }
    if (pending.attempts >= 5) throw new UnauthorizedException("Too many attempts. Request a new code.");
    const expected = Buffer.from(pending.codeHash);
    const actual = Buffer.from(this.hashCode(code));
    const matches = expected.length === actual.length && timingSafeEqual(expected, actual);
    if (!matches) {
      await this.prisma.loginOtp.update({ where: { id: pending.id }, data: { attempts: { increment: 1 } } });
      throw new UnauthorizedException("That code is incorrect.");
    }
    await this.prisma.loginOtp.update({ where: { id: pending.id }, data: { consumedAt: new Date() } });
  }

  private async sendCode(userId: string, reason: "signin" | "signup" | "profile") {
    const user = await this.prisma.user.findUniqueOrThrow({ where: { id: userId } });
    const pending = await this.prisma.loginOtp.findFirst({
      where: { userId, consumedAt: null },
      orderBy: { createdAt: "desc" },
    });
    if (pending && pending.resendAt.getTime() > Date.now()) {
      const wait = Math.ceil((pending.resendAt.getTime() - Date.now()) / 1000);
      throw new HttpException(`Wait ${wait} seconds before requesting another code.`, 429);
    }
    const code = randomInt(0, 10000).toString().padStart(4, "0");
    const ges = user.gesId
      ? await this.prisma.gES.findUnique({ where: { id: user.gesId }, select: { name: true } })
      : null;
    const requestedAt = new Date();
    const delivery = await this.mail.sendSignInCode({
      to: user.email,
      name: user.name,
      gesName: ges?.name ?? user.title,
      code,
      requestedAt,
      expiresAt: new Date(requestedAt.getTime() + OTP_TTL_MS),
      resendSeconds: OTP_RESEND_MS / 1000,
      reason,
    });
    await this.prisma.loginOtp.deleteMany({ where: { userId, consumedAt: null } });
    await this.prisma.loginOtp.create({
      data: {
        userId,
        codeHash: this.hashCode(code),
        expiresAt: new Date(requestedAt.getTime() + OTP_TTL_MS),
        resendAt: new Date(requestedAt.getTime() + OTP_RESEND_MS),
      },
    });
    return {
      profileId: user.id,
      maskedEmail: maskEmail(user.email),
      resendInSeconds: OTP_RESEND_MS / 1000,
      expiresInSeconds: OTP_TTL_MS / 1000,
      delivery: delivery.delivery,
      ...(delivery.delivery === "logged" && process.env.NODE_ENV !== "production" ? { devCode: code } : {}),
    };
  }

  private async notifySuperAdmin(userId: string) {
    const user = await this.prisma.user.findUnique({ where: { id: userId }, include: { ges: true } });
    if (!user) return false;
    const result = await this.mail.sendAccessRequest({
      name: user.name,
      email: user.email,
      phone: user.phone || "Not provided",
      gesName: user.ges?.name ?? user.title,
      requestedAt: new Date(),
    }).catch(() => ({ delivery: "logged" as const }));
    return result.delivery === "sent";
  }

  private assertSuperAdmin(actor: { roles?: string[] }) {
    if (!actor.roles?.includes("ADMIN")) throw new ForbiddenException("Only NewRa Grids can manage GES access");
  }

  private async createSignupUser(name: string, email: string, gesName: string, phone: string) {
    const taken = await this.prisma.gES.findFirst({ where: { name: gesName } });
    if (taken) throw new BadRequestException("An organisation with that name already exists. Sign in instead.");
    const gesId = `ges_${Date.now()}`;
    const role = await this.prisma.role.findUnique({ where: { name: "GES_ADMIN" } });
    if (!role) throw new BadRequestException("GES access is not ready yet");
    await this.prisma.gES.create({
      data: {
        id: gesId,
        name: gesName,
        legalName: gesName,
        businessType: "",
        location: "",
        state: "",
        discom: "",
        consumerNumbers: "",
        contractDemandMw: 0,
        billedDemandMw: 0,
        existingRooftopMw: 0,
        existingRenewableGwh: 0,
        annualConsumptionGwh: 0,
        notes: "",
        contactName: name,
        contactEmail: email,
        contactPhone: phone,
        illustrative: false,
        crmStage: "CLIENT_DISCOVERY",
        evaluationStage: "IPP_EVALUATION",
        requirement: {
          create: {
            id: `req_${gesId}`,
            annualEnergyGwh: 0,
            peakDemandMw: 0,
            requiredCapacityGw: 0,
            targetCodYear: new Date().getFullYear() + 1,
            preferredTechnologies: [],
            bessPreference: "OPTIONAL",
            notes: "",
            dataQuality: "MISSING",
          },
        },
      },
    });
    return this.prisma.user.create({
      data: {
        id: `usr_${gesId}_admin`,
        email,
        name,
        phone,
        title: gesName,
        passwordHash: await bcrypt.hash(randomBytes(24).toString("hex"), 10),
        gesId,
        active: false,
        accessStatus: "PENDING",
        roles: { create: { roleId: role.id } },
      },
    });
  }

  private async createProfileUser(name: string, email: string, phone: string, gesId: string, gesName: string) {
    const role = await this.prisma.role.findUnique({ where: { name: "GES_USER" } });
    if (!role) throw new BadRequestException("GES access is not ready yet");
    return this.prisma.user.create({
      data: {
        id: `usr_${gesId}_${Date.now()}`,
        email,
        name,
        phone,
        title: gesName,
        passwordHash: await bcrypt.hash(randomBytes(24).toString("hex"), 10),
        gesId,
        active: false,
        accessStatus: "PENDING",
        roles: { create: { roleId: role.id } },
      },
    });
  }

  private async profilesFor(gesId: string) {
    const ges = await this.prisma.gES.findUnique({ where: { id: gesId }, select: { id: true, name: true } });
    const users = await this.prisma.user.findMany({
      where: {
        gesId,
        active: true,
        roles: { some: { role: { name: { in: [...GES_ROLES] } } } },
      },
      orderBy: { name: "asc" },
    });
    return {
      gesId,
      gesName: ges?.name ?? "",
      profiles: users.map((user) => ({
        id: user.id,
        gesId: user.gesId,
        name: user.name,
        gesName: ges?.name ?? user.title,
        initials: initials(user.name),
      })),
    };
  }

  private hashCode(code: string) {
    const secret = process.env.JWT_ACCESS_SECRET || "newra-comparator-access-demo-secret-change-me";
    return createHash("sha256").update(`${secret}:${code}`).digest("hex");
  }

  private async resolveGesUser(profileId: string) {
    if (profileId.startsWith("ges:")) {
      const gesId = profileId.slice(4);
      const ges = await this.prisma.gES.findUnique({ where: { id: gesId } });
      if (!ges || !ges.contactEmail.trim().includes("@")) {
        throw new NotFoundException("Choose a GES profile to continue.");
      }
      return this.ensureContactUser(ges);
    }
    const user = await this.prisma.user.findFirst({
      where: {
        id: profileId,
        active: true,
        gesId: { not: null },
        roles: { some: { role: { name: { in: [...GES_ROLES] } } } },
      },
    });
    if (!user) throw new NotFoundException("Choose a GES profile to continue.");
    return user;
  }

  private async ensureContactUser(ges: { id: string; name: string; contactName: string; contactEmail: string }) {
    const email = ges.contactEmail.trim().toLowerCase();
    const existing = await this.prisma.user.findUnique({
      where: { email },
      include: { roles: { include: { role: true } } },
    });
    if (existing) {
      const names = existing.roles.map((item) => item.role.name);
      const customer = names.some((name) => name === "GES_ADMIN" || name === "GES_USER");
      if (!customer || (existing.gesId && existing.gesId !== ges.id)) {
        throw new BadRequestException("This GES email is already used by another account");
      }
      if (!existing.gesId) {
        return this.prisma.user.update({ where: { id: existing.id }, data: { gesId: ges.id } });
      }
      return existing;
    }
    const role = await this.prisma.role.findUnique({ where: { name: "GES_USER" } });
    if (!role) throw new BadRequestException("GES access is not ready yet");
    return this.prisma.user.create({
      data: {
        id: `usr_${ges.id}_contact`,
        email,
        name: ges.contactName.trim() || ges.name,
        title: ges.name,
        passwordHash: await bcrypt.hash(randomBytes(24).toString("hex"), 10),
        gesId: ges.id,
        roles: { create: { roleId: role.id } },
      },
    });
  }
}

function initials(name: string) {
  const parts = name.trim().split(/\s+/).filter(Boolean);
  const letters = (parts.length > 1 ? `${parts[0][0]}${parts[parts.length - 1][0]}` : parts[0]?.slice(0, 2) ?? "G");
  return letters.toUpperCase();
}

function cleanPhone(value: string) {
  const phone = value.trim();
  const digits = phone.replace(/\D/g, "");
  if (digits.length < 10) throw new BadRequestException("Enter a phone number with at least 10 digits");
  return phone;
}

function maskEmail(email: string) {
  const [local, domain] = email.split("@");
  if (!domain) return "your email";
  return `${local.slice(0, 1)}•••@${domain}`;
}
