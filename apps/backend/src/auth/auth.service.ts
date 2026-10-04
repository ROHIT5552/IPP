import { Injectable, UnauthorizedException } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import { createHash, randomBytes } from "crypto";
import * as bcrypt from "bcrypt";
import { Response } from "express";
import { PrismaService } from "../prisma/prisma.service";

function hashToken(token: string) {
  return createHash("sha256").update(token).digest("hex");
}

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
  ) {}

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
}
