import { clamp, round } from "./numbers";
import {
  SuitabilityDimensionKey,
  SuitabilityWeights,
} from "./parameters";
import { ConnectivityStatus, connectivityFitScore } from "./ehv";
import { regulatoryFitScore, RegulatoryInput } from "./regulatory";
import { tariffFitScore } from "./tariff";

export type CompatibilityStatus =
  | "HIGHLY_SUITABLE"
  | "SUITABLE"
  | "CONDITIONAL"
  | "NOT_SUITABLE"
  | "GATE_FAILED";

export interface SuitabilityInput {
  annualRequiredGwh: number;
  availableGwh: number;
  loadMatchPct: number;
  preferredTechnologies: string[];
  bessPreference: "OPTIONAL" | "HOURS_2_TO_4" | "HOURS_4";
  peakDemandMw: number;
  targetCodYear: number;
  solarMw: number;
  windMw: number;
  bessMw: number;
  bessMwh: number;
  ippCodYear: number;
  quotedTariff: number;
  tariffFloor: number;
  tariffCeiling: number;
  financialScore: number;
  dscr: number;
  lenderIdentified: boolean;
  engineeringScore: number;
  dataQualityFactor: number;
  connectivityStatus: ConnectivityStatus;
  ehvScore: number;
  regulatory: RegulatoryInput;
  weights: SuitabilityWeights;
  failedGate: boolean;
  conditionalGate: boolean;
}

export interface SuitabilityDimension {
  key: SuitabilityDimensionKey;
  label: string;
  score: number;
  weight: number;
  contribution: number;
}

export interface SuitabilityResult {
  overallPct: number;
  compatibilityStatus: CompatibilityStatus;
  dimensions: SuitabilityDimension[];
  technicalFit: number;
  commercialFit: number;
  financialFit: number;
  generationFit: number;
  loadMatchScore: number;
}

const LABELS: Record<SuitabilityDimensionKey, string> = {
  energyCoverage: "Energy Coverage",
  loadMatch: "Load Matching",
  technologyFit: "Technology Fit",
  bessFit: "BESS Fit",
  codFit: "COD Fit",
  tariffFit: "Tariff Fit",
  financialFit: "Financial Feasibility",
  technicalFit: "Technical Feasibility",
  connectivityFit: "Connectivity Fit",
  regulatoryFit: "Regulatory Fit",
};

export function technologyFitScore(input: SuitabilityInput): number {
  let score = 100;
  if (input.preferredTechnologies.includes("SOLAR") && input.solarMw <= 0) score -= 34;
  if (input.preferredTechnologies.includes("WIND") && input.windMw <= 0) score -= 28;
  const bessRequested = input.preferredTechnologies.includes("BESS") && input.bessPreference !== "OPTIONAL";
  if (bessRequested && input.bessMw <= 0) score -= 30;
  if (input.bessPreference === "OPTIONAL" && input.bessMw <= 0 && input.preferredTechnologies.includes("SOLAR") && input.windMw <= 0) {
    score -= 8;
  }
  return clamp(score, 0, 100);
}

export function bessFitScore(input: SuitabilityInput): number {
  const duration = input.bessMw > 0 ? input.bessMwh / input.bessMw : 0;
  if (input.bessPreference === "OPTIONAL") {
    if (input.bessMw <= 0) return 74;
    return clamp(80 + Math.min(20, duration * 4), 0, 100);
  }
  const target = input.bessPreference === "HOURS_4" ? 4 : 3;
  if (input.bessMw <= 0) return input.bessPreference === "HOURS_4" ? 16 : 30;
  const durationScore = (clamp(duration / target, 0, 1.15) / 1.15) * 68;
  const powerScore = clamp(input.bessMw / Math.max(1, input.peakDemandMw * 0.22), 0, 1) * 32;
  return round(clamp(durationScore + powerScore, 0, 100), 2);
}

export function codFitScore(ippYear: number, gesYear: number): number {
  if (!ippYear || ippYear <= 0) return 16;
  const gap = ippYear - gesYear;
  if (gap <= 0) return 100;
  if (gap === 1) return 62;
  if (gap === 2) return 36;
  return 16;
}

export function statusFromSuitability(
  overallPct: number,
  failedGate: boolean,
  _conditionalGate: boolean,
): CompatibilityStatus {
  if (failedGate) return "GATE_FAILED";
  if (overallPct >= 85) return "HIGHLY_SUITABLE";
  if (overallPct >= 72) return "SUITABLE";
  if (overallPct >= 55) return "CONDITIONAL";
  return "NOT_SUITABLE";
}

export function calculateSuitability(input: SuitabilityInput): SuitabilityResult {
  const energyCoverage = round(
    clamp(input.annualRequiredGwh > 0 ? (input.availableGwh / input.annualRequiredGwh) * 100 : 0, 0, 100),
    2,
  );
  const financialFit = round(
    clamp(
      (input.financialScore / 5) * 100 * (input.dscr < 1.15 ? 0.72 : input.dscr < 1.3 ? 0.86 : 1) -
        (input.lenderIdentified ? 0 : 8),
      0,
      100,
    ),
    2,
  );
  const scores: Record<SuitabilityDimensionKey, number> = {
    energyCoverage,
    loadMatch: round(clamp(input.loadMatchPct, 0, 100), 2),
    technologyFit: round(technologyFitScore(input), 2),
    bessFit: round(bessFitScore(input), 2),
    codFit: codFitScore(input.ippCodYear, input.targetCodYear),
    tariffFit: tariffFitScore(input.quotedTariff, input.tariffFloor, input.tariffCeiling),
    financialFit,
    technicalFit: round(clamp((input.engineeringScore / 5) * 100 * input.dataQualityFactor, 0, 100), 2),
    connectivityFit: connectivityFitScore(input.connectivityStatus, input.ehvScore),
    regulatoryFit: regulatoryFitScore(input.regulatory),
  };

  const weightTotal = (Object.values(input.weights) as number[]).reduce((total, weight) => total + weight, 0) || 1;
  const dimensions = (Object.keys(scores) as SuitabilityDimensionKey[]).map((key) => {
    const weight = input.weights[key];
    const score = scores[key];
    return {
      key,
      label: LABELS[key],
      score,
      weight,
      contribution: round((score * weight) / weightTotal, 2),
    };
  });
  const overallPct = round(
    dimensions.reduce((total, dimension) => total + dimension.contribution, 0),
    2,
  );
  return {
    overallPct,
    compatibilityStatus: statusFromSuitability(overallPct, input.failedGate, input.conditionalGate),
    dimensions,
    technicalFit: round((scores.technicalFit + scores.technologyFit) / 2, 2),
    commercialFit: round((scores.tariffFit + scores.codFit) / 2, 2),
    financialFit: scores.financialFit,
    generationFit: scores.energyCoverage,
    loadMatchScore: scores.loadMatch,
  };
}
