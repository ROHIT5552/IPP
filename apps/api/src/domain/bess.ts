import { round } from "./numbers";

export interface BessYearSnapshot {
  year: number;
  usableMwh: number;
}

export function bessDurationHours(powerMw: number, energyMwh: number): number {
  if (powerMw <= 0) return 0;
  return round(energyMwh / powerMw, 2);
}

export function bessYearSnapshots(usableMwh: number, annualDegradation: number | null): BessYearSnapshot[] {
  const degradation = annualDegradation ?? 0;
  return [1, 5, 10, 15].map((year) => ({
    year,
    usableMwh: round(usableMwh * (1 - degradation) ** (year - 1), 2),
  }));
}
