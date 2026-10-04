import { Module } from "@nestjs/common";
import { APP_GUARD } from "@nestjs/core";
import { ThrottlerGuard, ThrottlerModule } from "@nestjs/throttler";
import { AuthModule } from "./auth/auth.module";
import { GesScopeGuard, JwtAuthGuard, PermissionsGuard } from "./common/guards";
import {
  AuditModule, BESSModule, CapexModule, ComparisonModule, CriticalGateModule, DealbookModule, DocumentModule,
  EHVModule, EvaluationModule, FDREModule, FinanceModule, GESModule, GenerationModule, HealthModule, IPPModule,
  LoadMatchingModule, NegotiationModule, PSOAModule, PermissionsModule, RedFlagModule, RegulatoryModule,
  RolesModule, ScoringModule, SuitabilityModule, TariffModule, TaskModule, UsersModule,
} from "./modules";
import { PlatformModule } from "./platform/platform.module";
import { PrismaModule } from "./prisma/prisma.module";

@Module({
  imports: [
    ThrottlerModule.forRoot([{ ttl: 60000, limit: 300 }]),
    PrismaModule,
    AuthModule,
    PlatformModule,
    UsersModule, RolesModule, PermissionsModule, GESModule, IPPModule, GenerationModule, LoadMatchingModule,
    FDREModule, BESSModule, EHVModule, EvaluationModule, ScoringModule, SuitabilityModule, CapexModule,
    FinanceModule, TariffModule, RegulatoryModule, CriticalGateModule, RedFlagModule, ComparisonModule,
    NegotiationModule, DocumentModule, TaskModule, PSOAModule, DealbookModule, AuditModule, HealthModule,
  ],
  providers: [
    { provide: APP_GUARD, useClass: ThrottlerGuard },
    { provide: APP_GUARD, useClass: JwtAuthGuard },
    { provide: APP_GUARD, useClass: GesScopeGuard },
    { provide: APP_GUARD, useClass: PermissionsGuard },
  ],
})
export class AppModule {}
