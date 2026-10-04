import { Injectable } from "@nestjs/common";
import { capexCredibility } from "../domain/capex";
import { bessYearSnapshots } from "../domain/bess";
import { analyseSchedule } from "../domain/execution";
import { assessFinancialFeasibility } from "../domain/finance";
import { evaluateCriticalGates, GateEvaluationInput } from "../domain/gates";
import { calculateLoadMatch, LoadMatchInput } from "../domain/load-matching";
import { detectRedFlags, RedFlagInput } from "../domain/red-flags";
import { regulatoryProtectionScore, RegulatoryInput } from "../domain/regulatory";
import { EvaluationScores } from "../domain/parameters";
import { resolveEvaluationScores, scoreEvaluation, ScoreSignals } from "../domain/scoring";
import { calculateSuitability, SuitabilityInput } from "../domain/suitability";
import { compareTariffScenario, TariffDrivers, TariffScenarioInput } from "../domain/tariff";
import { connectivityFitScore } from "../domain/ehv";
import { rebuildAll, rebuildGes, rebuildPair } from "../persistence/rebuild";
import { PrismaService } from "../prisma/prisma.service";

@Injectable()
export class IPPScoringService {
  score(scores: EvaluationScores) {
    return scoreEvaluation(scores);
  }

  resolve(base: EvaluationScores, current: ScoreSignals, baseline: ScoreSignals) {
    return resolveEvaluationScores(base, current, baseline);
  }
}

@Injectable()
export class GESSuitabilityService {
  calculate(input: SuitabilityInput) {
    return calculateSuitability(input);
  }
}

@Injectable()
export class SuitabilityCalculationService {
  constructor(private readonly suitability: GESSuitabilityService) {}

  calculate(input: SuitabilityInput) {
    return this.suitability.calculate(input);
  }
}

@Injectable()
export class GenerationAnalysisService {
  summarise(p50: number, p75: number, p90: number) {
    return { p50, p75, p90, p90Ratio: p50 > 0 ? p90 / p50 : 0 };
  }
}

@Injectable()
export class LoadMatchingService {
  calculate(input: LoadMatchInput) {
    return calculateLoadMatch(input);
  }
}

@Injectable()
export class FDRECalculationService {
  constructor(private readonly loadMatching: LoadMatchingService) {}

  calculate(input: LoadMatchInput) {
    const match = this.loadMatching.calculate(input);
    return { ...match, fdreReady: match.loadMatchPct >= 78 };
  }
}

@Injectable()
export class BESSAnalysisService {
  snapshots(usableMwh: number, degradation: number | null) {
    return bessYearSnapshots(usableMwh, degradation);
  }
}

@Injectable()
export class EHVEvaluationService {
  fit(status: "PRELIMINARY" | "UNDER_STUDY" | "APPLICATION_SUBMITTED" | "APPROVAL_PENDING" | "APPROVED", score: number) {
    return connectivityFitScore(status, score);
  }
}

@Injectable()
export class CapexEvaluationService {
  credibility(items: { amountInrCr: number; assumptionType: "FIRM" | "QUOTATION_SUPPORTED" | "INDICATIVE" | "BUDGETARY" }[]) {
    return capexCredibility(items);
  }
}

@Injectable()
export class FinancialFeasibilityService {
  assess(drivers: TariffDrivers, quotedTariff: number, lenderIdentified: boolean, fundraisingDependency: boolean) {
    return assessFinancialFeasibility(drivers, quotedTariff, { lenderIdentified, fundraisingDependency });
  }
}

@Injectable()
export class TariffCalculationService {
  compare(drivers: TariffDrivers, scenario: TariffScenarioInput) {
    return compareTariffScenario(drivers, scenario);
  }
}

@Injectable()
export class TariffSensitivityService {
  constructor(private readonly tariff: TariffCalculationService) {}

  compare(drivers: TariffDrivers, scenario: TariffScenarioInput) {
    return this.tariff.compare(drivers, scenario);
  }
}

@Injectable()
export class RegulatoryEvaluationService {
  score(input: RegulatoryInput) {
    return regulatoryProtectionScore(input);
  }
}

@Injectable()
export class CriticalGateService {
  evaluate(input: GateEvaluationInput) {
    return evaluateCriticalGates(input);
  }
}

@Injectable()
export class RedFlagService {
  detect(input: RedFlagInput) {
    return detectRedFlags(input);
  }
}

@Injectable()
export class ComparisonService {
  constructor(private readonly prisma: PrismaService) {}

  async recalculate(gesId: string, ippIds?: string[]) {
    if (!ippIds?.length) return rebuildGes(this.prisma, gesId);
    const results = [];
    for (const ippId of ippIds) results.push(await rebuildPair(this.prisma, gesId, ippId));
    return results;
  }

  recalculateAll() {
    return rebuildAll(this.prisma);
  }
}

@Injectable()
export class NegotiationService {}

@Injectable()
export class PSOAService {}

@Injectable()
export class DealbookService {}

export const DOMAIN_PROVIDERS = [
  IPPScoringService,
  GESSuitabilityService,
  SuitabilityCalculationService,
  GenerationAnalysisService,
  LoadMatchingService,
  FDRECalculationService,
  BESSAnalysisService,
  EHVEvaluationService,
  CapexEvaluationService,
  FinancialFeasibilityService,
  TariffCalculationService,
  TariffSensitivityService,
  RegulatoryEvaluationService,
  CriticalGateService,
  RedFlagService,
  ComparisonService,
  NegotiationService,
  PSOAService,
  DealbookService,
];
