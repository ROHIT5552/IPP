import { Injectable, Logger, OnModuleInit } from "@nestjs/common";
import { PrismaClient } from "@prisma/client";

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  private readonly logger = new Logger(PrismaService.name);
  ready = false;

  async onModuleInit() {
    await this.ensureConnected();
  }

  async ensureConnected() {
    if (this.ready) return true;
    try {
      await this.$connect();
      this.ready = true;
      return true;
    } catch {
      this.logger.warn(
        "PostgreSQL unavailable; continuing with the in-memory demo repository.",
      );
      return false;
    }
  }
}
