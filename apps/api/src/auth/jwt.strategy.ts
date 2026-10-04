import { Injectable, UnauthorizedException } from "@nestjs/common";
import { PassportStrategy } from "@nestjs/passport";
import { Request } from "express";
import { ExtractJwt, Strategy } from "passport-jwt";
import { PrismaService } from "../prisma/prisma.service";

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly prisma: PrismaService) {
    super({
      jwtFromRequest: ExtractJwt.fromExtractors([
        (request: Request) => request?.cookies?.newra_access ?? null,
        ExtractJwt.fromAuthHeaderAsBearerToken(),
      ]),
      ignoreExpiration: false,
      secretOrKey: process.env.JWT_ACCESS_SECRET || "newra-comparator-access-demo-secret-change-me",
    });
  }

  async validate(payload: { sub: string }) {
    const user = await this.prisma.user.findUnique({
      where: { id: payload.sub },
      include: { roles: { include: { role: { include: { permissions: { include: { permission: true } } } } } } },
    });
    if (!user || !user.active) throw new UnauthorizedException("Sign in required");
    const permissions = [...new Set(user.roles.flatMap((role) => role.role.permissions.map((item) => item.permission.key)))];
    const roles = user.roles.map((role) => role.role.name);
    return {
      id: user.id,
      email: user.email,
      name: user.name,
      title: user.title,
      role: roles[0] ?? "VIEWER",
      roles,
      permissions,
      gesId: user.gesId,
    };
  }
}
