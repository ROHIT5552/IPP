import { Injectable, Logger, OnModuleInit } from "@nestjs/common";
import * as bcrypt from "bcrypt";
import { DEMO_PASSWORD, ROLE_PERMISSIONS, USERS } from "../demo/catalog";
import { PrismaService } from "../prisma/prisma.service";

const PERMISSION_LABELS: Record<string, string> = {
  IPP_VIEW: "View IPP records",
  IPP_CREATE: "Create IPP records",
  IPP_EDIT: "Edit IPP records",
  GES_VIEW: "View GES accounts",
  GES_CREATE: "Create GES accounts",
  GES_EDIT: "Edit GES accounts",
  EVALUATION_VIEW: "View evaluations",
  EVALUATION_EDIT: "Edit evaluations",
  TECHNICAL_REVIEW: "Review technical inputs",
  FINANCIAL_REVIEW: "Review financial inputs",
  COMMERCIAL_REVIEW: "Review commercial terms",
  TARIFF_REVIEW: "Review tariffs",
  NEGOTIATION_CREATE: "Create negotiation offers",
  NEGOTIATION_APPROVE: "Approve negotiation offers",
  PSOA_VIEW: "View PSOA checklists",
  PSOA_CREATE: "Update PSOA checklists",
  DEALBOOK_VIEW: "View dealbooks",
  DEALBOOK_CREATE: "Create dealbooks",
  DOCUMENT_VIEW: "View documents",
  DOCUMENT_UPLOAD: "Upload documents",
  AUDIT_VIEW: "View the audit log",
  GES_PROFILE_EDIT: "Edit allowed GES profile fields",
  REQUIREMENT_VIEW: "View GES requirements",
  REQUIREMENT_EDIT: "Edit GES requirements",
  SELECTION_VIEW: "View GES IPP selections",
  SELECTION_CREATE: "Select an IPP for a GES requirement",
  COMMERCIAL_REQUIREMENT_VIEW: "View commercial requirements",
  COMMERCIAL_REQUIREMENT_CREATE: "Submit a commercial requirement",
};

const ROLE_COPY: Record<string, string> = {
  ADMIN: "NewRa Grids. Full platform access, including acting on behalf of a GES.",
  NEWRA_ADMIN: "NewRa operations. Creates GES accounts and global IPP records without owning an IPP.",
  EVALUATOR: "Runs evaluations and keeps GES and IPP inputs current.",
  COMMERCIAL_REVIEWER: "Reviews tariff, negotiation and commercial terms.",
  TECHNICAL_REVIEWER: "Reviews generation, BESS, EHV and engineering evidence.",
  FINANCE_REVIEWER: "Reviews CAPEX, financing and tariff sustainability.",
  VIEWER: "Read-only access to GES, IPP, evaluation and dealbook.",
  GES_ADMIN: "Own GES access for profile, requirement, IPP selection and commercial requirement.",
  GES_USER: "Own GES access for profile, requirement, IPP catalogue, selection and commercial requirement.",
};

@Injectable()
export class AccessBootstrap implements OnModuleInit {
  private readonly logger = new Logger(AccessBootstrap.name);

  constructor(private readonly prisma: PrismaService) {}

  async onModuleInit() {
    for (const [key, description] of Object.entries(PERMISSION_LABELS)) {
      await this.prisma.permission.upsert({
        where: { key: key as never },
        update: { description },
        create: { id: `perm_${key.toLowerCase()}`, key: key as never, description },
      });
    }
    for (const [role, permissions] of Object.entries(ROLE_PERMISSIONS)) {
      const row = await this.prisma.role.upsert({
        where: { name: role as never },
        update: { description: ROLE_COPY[role] ?? role },
        create: { id: `role_${role.toLowerCase()}`, name: role as never, description: ROLE_COPY[role] ?? role },
      });
      for (const permission of permissions) {
        await this.prisma.rolePermission.upsert({
          where: { roleId_permissionId: { roleId: row.id, permissionId: `perm_${permission.toLowerCase()}` } },
          update: {},
          create: { roleId: row.id, permissionId: `perm_${permission.toLowerCase()}` },
        });
      }
    }
    const passwordHash = await bcrypt.hash(DEMO_PASSWORD, 10);
    for (const user of USERS) {
      if (user.role === "ADMIN") continue;
      const existing = await this.prisma.user.findUnique({ where: { email: user.email } });
      if (existing) continue;
      const role = await this.prisma.role.findUnique({ where: { name: user.role as never } });
      if (!role) continue;
      const gesId = "gesId" in user && user.gesId ? user.gesId : null;
      if (gesId && !(await this.prisma.gES.findUnique({ where: { id: gesId }, select: { id: true } }))) {
        this.logger.warn(`Skipped demo user ${user.email} because GES ${gesId} is not in this database`);
        continue;
      }
      await this.prisma.user.create({
        data: {
          id: user.id,
          email: user.email,
          name: user.name,
          title: user.title,
          passwordHash,
          gesId,
          roles: { create: [{ roleId: role.id }] },
        },
      });
      this.logger.log(`Created demo user ${user.email}`);
    }
    await this.ensureSuperAdmin();
  }

  private async ensureSuperAdmin() {
    const email = process.env.SUPERADMIN_EMAIL?.trim() || "admin@example.com";
    const role = await this.prisma.role.findUnique({ where: { name: "ADMIN" } });
    if (!role) return;
    const passwordHash = await bcrypt.hash("newra#2026", 10);
    const others = await this.prisma.user.findMany({
      where: { email: { not: email }, roles: { some: { roleId: role.id } } },
      select: { id: true, email: true },
    });
    for (const other of others) {
      await this.prisma.userRole.deleteMany({ where: { userId: other.id, roleId: role.id } });
      await this.prisma.user.update({ where: { id: other.id }, data: { active: false } });
      await this.prisma.refreshToken.updateMany({
        where: { userId: other.id, revokedAt: null },
        data: { revokedAt: new Date() },
      });
      this.logger.log(`Removed superadmin login ${other.email}`);
    }
    const existing = await this.prisma.user.findUnique({ where: { email } });
    const profile = {
      name: "NewRa Grids",
      title: "NewRa Grids",
      passwordHash,
      active: true,
      accessStatus: "APPROVED" as const,
      gesId: null,
    };
    const user = existing
      ? await this.prisma.user.update({ where: { id: existing.id }, data: profile })
      : await this.prisma.user.create({
          data: { id: "usr_newra_grids", email, ...profile, roles: { create: [{ roleId: role.id }] } },
        });
    if (existing) {
      await this.prisma.userRole.deleteMany({ where: { userId: user.id, roleId: { not: role.id } } });
      await this.prisma.userRole.upsert({
        where: { userId_roleId: { userId: user.id, roleId: role.id } },
        update: {},
        create: { userId: user.id, roleId: role.id },
      });
    }
  }
}
