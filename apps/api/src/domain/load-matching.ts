import { INTERVAL_LABELS } from "./parameters";
import { round } from "./numbers";

export interface LoadMatchPoint {
  t: string;
  loadMw: number;
  generationMw: number;
  matchedMw: number;
  bessMw: number;
  surplusMw: number;
  deficitMw: number;
}

export interface LoadMatchSummary {
  requiredGwh: number;
  availableGwh: number;
  matchedGwh: number;
  surplusGwh: number;
  deficitGwh: number;
  coveragePct: number;
  loadMatchPct: number;
  series: LoadMatchPoint[];
}

export interface LoadMatchInput {
  loadMw: number[];
  generationMw: number[];
  bessMw: number;
  bessMwh: number;
  roundTripEfficiency: number;
  depthOfDischarge: number;
  requiredAnnualGwh: number;
}

function toGwh(mw: number): number {
  return (mw * 0.25 * 365) / 1000;
}

export function calculateLoadMatch(input: LoadMatchInput): LoadMatchSummary {
  const usable = Math.max(0, input.bessMwh * input.depthOfDischarge);
  const efficiency = input.roundTripEfficiency > 0 ? input.roundTripEfficiency : 0.86;
  const chargeEfficiency = Math.sqrt(efficiency);
  const dischargeEfficiency = Math.sqrt(efficiency);
  let stateOfCharge = usable * 0.5;
  let series: LoadMatchPoint[] = [];

  for (let day = 0; day < 4; day += 1) {
    const next: LoadMatchPoint[] = [];
    for (let index = 0; index < 96; index += 1) {
      const load = input.loadMw[index] ?? 0;
      const generation = input.generationMw[index] ?? 0;
      const direct = Math.min(generation, load);
      const deficit = load - direct;
      const surplus = generation - direct;
      const dischargeCap = Math.min(input.bessMw, (stateOfCharge * dischargeEfficiency) / 0.25);
      const discharge = Math.min(deficit, Math.max(0, dischargeCap));
      stateOfCharge = Math.max(0, stateOfCharge - (discharge * 0.25) / (dischargeEfficiency || 1));
      const room = Math.max(0, usable - stateOfCharge);
      const chargeCap = Math.min(input.bessMw, room / (chargeEfficiency || 1) / 0.25);
      const charge = Math.min(surplus, Math.max(0, chargeCap));
      stateOfCharge = Math.min(usable, stateOfCharge + charge * 0.25 * chargeEfficiency);
      next.push({
        t: INTERVAL_LABELS[index],
        loadMw: round(load, 3),
        generationMw: round(generation, 3),
        matchedMw: round(direct + discharge, 3),
        bessMw: round(discharge, 3),
        surplusMw: round(Math.max(0, surplus - charge), 3),
        deficitMw: round(Math.max(0, deficit - discharge), 3),
      });
    }
    series = next;
  }

  const requiredGwh = input.requiredAnnualGwh;
  const availableGwh = series.reduce((total, point) => total + toGwh(point.generationMw), 0);
  const matchedGwh = series.reduce((total, point) => total + toGwh(point.matchedMw), 0);
  const surplusGwh = series.reduce((total, point) => total + toGwh(point.surplusMw), 0);
  const deficitGwh = series.reduce((total, point) => total + toGwh(point.deficitMw), 0);
  const ratios = series.filter((point) => point.loadMw > 0).map((point) => Math.min(1, point.matchedMw / point.loadMw));
  const loadMatchPct = ratios.length ? (ratios.reduce((total, ratio) => total + ratio, 0) / ratios.length) * 100 : 0;

  return {
    requiredGwh: round(requiredGwh, 2),
    availableGwh: round(availableGwh, 2),
    matchedGwh: round(matchedGwh, 2),
    surplusGwh: round(surplusGwh, 2),
    deficitGwh: round(deficitGwh, 2),
    coveragePct: round(requiredGwh > 0 ? (matchedGwh / requiredGwh) * 100 : 0, 2),
    loadMatchPct: round(loadMatchPct, 2),
    series,
  };
}
