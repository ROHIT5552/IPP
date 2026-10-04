import { Module } from "@nestjs/common";
import { PlatformModule } from "../platform/platform.module";

const bind = Module({ imports: [PlatformModule], exports: [PlatformModule] });

export class UsersModule {}
export class RolesModule {}
export class PermissionsModule {}
export class GESModule {}
export class IPPModule {}
export class GenerationModule {}
export class LoadMatchingModule {}
export class FDREModule {}
export class BESSModule {}
export class EHVModule {}
export class EvaluationModule {}
export class ScoringModule {}
export class SuitabilityModule {}
export class CapexModule {}
export class FinanceModule {}
export class TariffModule {}
export class RegulatoryModule {}
export class CriticalGateModule {}
export class RedFlagModule {}
export class ComparisonModule {}
export class NegotiationModule {}
export class DocumentModule {}
export class TaskModule {}
export class PSOAModule {}
export class DealbookModule {}
export class AuditModule {}
export class HealthModule {}

[
  UsersModule, RolesModule, PermissionsModule, GESModule, IPPModule, GenerationModule, LoadMatchingModule,
  FDREModule, BESSModule, EHVModule, EvaluationModule, ScoringModule, SuitabilityModule, CapexModule,
  FinanceModule, TariffModule, RegulatoryModule, CriticalGateModule, RedFlagModule, ComparisonModule,
  NegotiationModule, DocumentModule, TaskModule, PSOAModule, DealbookModule, AuditModule, HealthModule,
].forEach((target) => bind(target));
