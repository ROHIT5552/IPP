import {
  ArgumentsHost,
  CallHandler,
  Catch,
  ExceptionFilter,
  ExecutionContext,
  HttpException,
  Injectable,
  NestInterceptor,
  SetMetadata,
  StreamableFile,
} from "@nestjs/common";
import { randomUUID } from "crypto";
import { Request, Response, NextFunction } from "express";
import { Observable, map, tap } from "rxjs";

export const IS_PUBLIC = "isPublic";
export const PERMISSIONS_KEY = "permissions";
export const Public = () => SetMetadata(IS_PUBLIC, true);
export const RequirePermissions = (...permissions: string[]) => SetMetadata(PERMISSIONS_KEY, permissions);

export function requestId(req: Request, res: Response, next: NextFunction) {
  const id = (req.headers["x-request-id"] as string) || randomUUID();
  req.headers["x-request-id"] = id;
  res.setHeader("x-request-id", id);
  next();
}

@Catch()
export class GlobalExceptionFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception instanceof HttpException ? exception.getStatus() : 500;
    const payload = exception instanceof HttpException ? exception.getResponse() : "Internal server error";
    const message = typeof payload === "string" ? payload : (payload as { message?: string | string[] }).message ?? "Request failed";
    response.status(status).json({
      success: false,
      statusCode: status,
      message: Array.isArray(message) ? message.join(", ") : message,
      requestId: request.headers["x-request-id"] ?? null,
      path: request.url,
      timestamp: new Date().toISOString(),
    });
  }
}

@Injectable()
export class ResponseInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<unknown> {
    return next.handle().pipe(
      map((data) => {
        if (data instanceof StreamableFile) return data;
        return { success: true, message: "OK", data: data ?? null };
      }),
    );
  }
}

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<unknown> {
    const request = context.switchToHttp().getRequest<Request>();
    const started = Date.now();
    return next.handle().pipe(
      tap(() => {
        const response = context.switchToHttp().getResponse<Response>();
        console.log(JSON.stringify({
          requestId: request.headers["x-request-id"],
          method: request.method,
          path: request.url,
          statusCode: response.statusCode,
          durationMs: Date.now() - started,
        }));
      }),
    );
  }
}
