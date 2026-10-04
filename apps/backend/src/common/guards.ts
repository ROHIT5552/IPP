import { CanActivate, ExecutionContext, Injectable, UnauthorizedException, ForbiddenException } from "@nestjs/common";
import { Reflector } from "@nestjs/core";
import { AuthGuard } from "@nestjs/passport";
import { IS_PUBLIC, PERMISSIONS_KEY } from "./http";

@Injectable()
export class JwtAuthGuard extends AuthGuard("jwt") {
  constructor(private readonly reflector: Reflector) {
    super();
  }

  canActivate(context: ExecutionContext) {
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC, [context.getHandler(), context.getClass()]);
    if (isPublic) return true;
    return super.canActivate(context);
  }

  handleRequest<T>(error: unknown, user: T): T {
    if (error || !user) throw error || new UnauthorizedException("Sign in required");
    return user;
  }
}

@Injectable()
export class PermissionsGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const required = this.reflector.getAllAndOverride<string[]>(PERMISSIONS_KEY, [context.getHandler(), context.getClass()]);
    if (!required?.length) return true;
    const request = context.switchToHttp().getRequest<{ user?: { permissions?: string[] } }>();
    const owned = new Set(request.user?.permissions ?? []);
    if (required.every((permission) => owned.has(permission))) return true;
    throw new ForbiddenException("You do not have permission to perform this action");
  }
}

@Injectable()
export class GesScopeGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest<{
      user?: { gesId?: string | null };
      params?: Record<string, string>;
      query?: Record<string, string>;
      body?: { gesId?: string };
      path?: string;
      url?: string;
    }>();
    const roles = (request.user as { roles?: string[] } | undefined)?.roles ?? [];
    const customerRole = roles.includes("GES_USER") || roles.includes("GES_ADMIN");
    const scope = request.user?.gesId;
    if (customerRole && !scope) {
      const path = String(request.path || request.url || "");
      if (!path.includes("/auth/")) {
        throw new ForbiddenException("This GES login is not assigned to a GES account");
      }
    }
    if (!scope) return true;
    const path = String(request.path || request.url || "").split("?")[0];
    const fromPath = path.match(/\/ges\/([^/]+)/)?.[1];
    const candidates = [request.params?.gesId, request.query?.gesId, request.body?.gesId, fromPath].filter(
      (value): value is string => typeof value === "string" && value.length > 0,
    );
    if (candidates.some((id) => id !== scope)) {
      throw new ForbiddenException("This login can open only its own GES account");
    }
    return true;
  }
}
