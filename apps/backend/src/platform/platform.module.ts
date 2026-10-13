import { Module } from "@nestjs/common";
import { AccessBootstrap } from "./access.bootstrap";
import { AuditService } from "./audit.service";
import { DOMAIN_PROVIDERS } from "./domain.services";
import { EnergyService } from "./energy.service";
import { PlatformController } from "./platform.controller";
import { ProcurementService } from "./procurement.service";
import { QuestionnaireService } from "./questionnaire.service";

@Module({
  controllers: [PlatformController],
  providers: [EnergyService, ProcurementService, QuestionnaireService, AccessBootstrap, AuditService, ...DOMAIN_PROVIDERS],
  exports: [EnergyService, ProcurementService, ...DOMAIN_PROVIDERS],
})
export class PlatformModule {}
