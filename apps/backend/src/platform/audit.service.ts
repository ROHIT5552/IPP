import { Injectable } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { PrismaService } from "../prisma/prisma.service";

@Injectable()
export class AuditService {
  constructor(private readonly prisma: PrismaService) {}

  log(entry: { entity: string; entityId: string; action: string; oldValue?: unknown; newValue?: unknown; userId?: string; requestId?: string }) {
    return this.prisma.auditLog.create({
      data: {
        entity: entry.entity,
        entityId: entry.entityId,
        action: entry.action,
        oldValue: entry.oldValue as Prisma.InputJsonValue,
        newValue: entry.newValue as Prisma.InputJsonValue,
        userId: entry.userId,
        requestId: entry.requestId,
      },
    });
  }
}
