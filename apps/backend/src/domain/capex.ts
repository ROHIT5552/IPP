import { round } from "./numbers";

export type CapexAssumption = "FIRM" | "QUOTATION_SUPPORTED" | "INDICATIVE" | "BUDGETARY";

const QUALITY: Record<CapexAssumption, number> = {
  FIRM: 1,
  QUOTATION_SUPPORTED: 0.86,
  INDICATIVE: 0.68,
  BUDGETARY: 0.42,
};

export interface CapexLine {
  amountInrCr: number;
  assumptionType: CapexAssumption;
}

export function capexCredibility(items: CapexLine[]): { score: number; budgetaryShare: number; total: number } {
  const total = items.reduce((sum, item) => sum + Math.max(0, item.amountInrCr), 0);
  if (total <= 0) return { score: 1, budgetaryShare: 1, total: 0 };
  const weighted = items.reduce((sum, item) => sum + Math.max(0, item.amountInrCr) * QUALITY[item.assumptionType], 0);
  const budgetary = items
    .filter((item) => item.assumptionType === "BUDGETARY" || item.assumptionType === "INDICATIVE")
    .reduce((sum, item) => sum + Math.max(0, item.amountInrCr), 0);
  return {
    score: round(1 + (weighted / total) * 4, 2),
    budgetaryShare: round(budgetary / total, 3),
    total: round(total, 2),
  };
}
