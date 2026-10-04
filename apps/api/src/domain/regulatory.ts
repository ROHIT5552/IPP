import { clampScore, round } from "./numbers";

export interface RegulatoryInput {
  changeInLaw: "PROTECTED" | "SHARED" | "UNLIMITED";
  curtailment: "CLEAR" | "AMBIGUOUS";
  indemnity: "STRONG" | "WEAK";
  complianceBearer: "IPP" | "GES" | "UNCLEAR";
  delayBearer: "IPP" | "GES" | "UNCLEAR";
  evaluationScore: number;
}

export function regulatoryProtectionScore(input: RegulatoryInput): number {
  let score = 3;
  if (input.changeInLaw === "PROTECTED") score += 0.8;
  if (input.changeInLaw === "SHARED") score += 0.2;
  if (input.changeInLaw === "UNLIMITED") score -= 1.2;
  if (input.curtailment === "CLEAR") score += 0.4;
  else score -= 0.7;
  if (input.indemnity === "STRONG") score += 0.4;
  else score -= 0.8;
  if (input.complianceBearer === "GES") score -= 0.7;
  if (input.complianceBearer === "UNCLEAR") score -= 0.4;
  if (input.delayBearer === "UNCLEAR") score -= 0.4;
  if (input.delayBearer === "GES") score -= 0.3;
  return clampScore(score);
}

export function regulatoryFitScore(input: RegulatoryInput): number {
  const protection = (regulatoryProtectionScore(input) / 5) * 100;
  const evaluation = (input.evaluationScore / 5) * 100;
  return round(protection * 0.6 + evaluation * 0.4, 2);
}
