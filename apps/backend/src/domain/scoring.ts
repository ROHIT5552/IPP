import { clampScore, round } from "./numbers";
import {
  EVALUATION_PARAMETERS,
  EvaluationParameterKey,
  EvaluationScores,
} from "./parameters";

export interface ScoredParameter {
  key: EvaluationParameterKey;
  name: string;
  short: string;
  score: number;
  weight: number;
  normalizedScore: number;
  weightedContribution: number;
}

export interface ScoringResult {
  parameters: ScoredParameter[];
  overallScore: number;
  weightTotal: number;
}

export function normalizedScore(score: number): number {
  return round((score / 5) * 100, 2);
}

export function weightedContribution(weight: number, score: number): number {
  return round((weight * score) / 5, 2);
}

export function scoreEvaluation(scores: EvaluationScores): ScoringResult {
  const parameters = EVALUATION_PARAMETERS.map((parameter) => {
    const score = scores[parameter.key];
    return {
      key: parameter.key,
      name: parameter.name,
      short: parameter.short,
      score: round(score, 2),
      weight: parameter.weight,
      normalizedScore: normalizedScore(score),
      weightedContribution: weightedContribution(parameter.weight, score),
    };
  });
  const overallScore = round(
    parameters.reduce((total, parameter) => total + parameter.weightedContribution, 0),
    2,
  );
  const weightTotal = EVALUATION_PARAMETERS.reduce((total, parameter) => total + parameter.weight, 0);
  return { parameters, overallScore, weightTotal };
}

export interface ScoreSignals {
  interestRate: number;
  capexInrCr: number;
  capexCredibility: number;
  bessMw: number;
  bessMwh: number;
  solarCuf: number;
  windCuf: number;
  generationGwh: number;
}

export function resolveEvaluationScores(
  base: EvaluationScores,
  current: ScoreSignals,
  baseline: ScoreSignals,
): EvaluationScores {
  const interestPoints = (current.interestRate - baseline.interestRate) * 100;
  const capexChange =
    baseline.capexInrCr > 0 ? (current.capexInrCr - baseline.capexInrCr) / baseline.capexInrCr : 0;
  const cufChange =
    current.solarCuf -
    baseline.solarCuf +
    (current.windCuf - baseline.windCuf);
  const generationChange =
    baseline.generationGwh > 0
      ? (current.generationGwh - baseline.generationGwh) / baseline.generationGwh
      : 0;
  const credibilityDelta = current.capexCredibility - baseline.capexCredibility;

  return {
    execution: clampScore(base.execution),
    financial: clampScore(base.financial - interestPoints * 0.35),
    ehv: clampScore(base.ehv),
    engineering: clampScore(base.engineering - Math.max(0, cufChange) * 6),
    fdre: clampScore(
      base.fdre +
        (current.bessMw - baseline.bessMw) * 0.006 +
        (current.bessMwh - baseline.bessMwh) * 0.0015,
    ),
    epc: clampScore(base.epc),
    cod: clampScore(base.cod),
    capex: clampScore(base.capex + credibilityDelta * 0.5 - Math.max(0, capexChange) * 2),
    tariff: clampScore(
      base.tariff -
        Math.max(0, capexChange) * 2 -
        Math.max(0, cufChange) * 8 -
        Math.max(0, -generationChange) * 1.5,
    ),
    regulatory: clampScore(base.regulatory),
  };
}
