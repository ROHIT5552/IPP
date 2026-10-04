import { INTERVAL_LABELS } from "./parameters";
import { round } from "./numbers";

export interface IntervalPoint {
  t: string;
  mw: number;
}

export function hourOf(index: number): number {
  return index * 0.25;
}

export function annualGwhFromMw(series: number[]): number {
  const dailyMwh = series.reduce((total, mw) => total + mw * 0.25, 0);
  return (dailyMwh * 365) / 1000;
}

export function scaleSeriesToAnnualGwh(series: number[], targetGwh: number): number[] {
  const current = annualGwhFromMw(series);
  if (current <= 0 || targetGwh <= 0) return series.map(() => 0);
  const factor = targetGwh / current;
  return series.map((mw) => mw * factor);
}

export function toIntervals(series: number[]): IntervalPoint[] {
  return series.map((mw, index) => ({ t: INTERVAL_LABELS[index], mw: round(mw, 4) }));
}

function expandHourly(hourly: number[]): number[] {
  return hourly.flatMap((value) => [value, value, value, value]);
}

const ASTER_HOURLY = [
  0.96, 1, 0.98, 0.95, 0.92, 0.86, 0.8, 0.78, 0.8, 0.83, 0.85, 0.87, 0.88, 0.9, 0.91, 0.9, 0.88,
  0.9, 0.93, 0.96, 0.98, 0.99, 0.98, 0.97,
];

const NOVA_HOURLY = [
  0.52, 0.5, 0.48, 0.48, 0.5, 0.58, 0.74, 0.88, 0.96, 1, 0.98, 0.97, 0.95, 1, 0.98, 0.93, 0.86,
  0.76, 0.66, 0.6, 0.56, 0.54, 0.53, 0.52,
];

const VERTEX_HOURLY = [
  0.7, 0.68, 0.66, 0.65, 0.66, 0.72, 0.8, 0.88, 0.92, 0.94, 0.95, 0.94, 0.92, 0.93, 0.96, 0.99, 1,
  0.98, 0.94, 0.9, 0.86, 0.8, 0.76, 0.72,
];

const HELIX_HOURLY = [
  0.48, 0.46, 0.45, 0.46, 0.5, 0.62, 0.78, 0.9, 0.98, 1, 0.99, 0.97, 0.96, 0.98, 0.95, 0.9, 0.82,
  0.72, 0.64, 0.58, 0.54, 0.52, 0.5, 0.49,
];

const SHAPES: Record<string, number[]> = {
  ges_aster: ASTER_HOURLY,
  ges_nova: NOVA_HOURLY,
  ges_vertex: VERTEX_HOURLY,
  ges_helix: HELIX_HOURLY,
};

export function buildLoadIntervals(gesId: string, annualEnergyGwh: number): IntervalPoint[] {
  const hourly = SHAPES[gesId] ?? NOVA_HOURLY;
  const scaled = scaleSeriesToAnnualGwh(expandHourly(hourly), annualEnergyGwh);
  return toIntervals(scaled);
}

export function solarUnit(hour: number): number {
  const sunrise = 6.5;
  const sunset = 18.25;
  if (hour < sunrise || hour > sunset) return 0;
  const position = (hour - sunrise) / (sunset - sunrise);
  return Math.pow(Math.sin(Math.PI * position), 1.35);
}

export function windUnit(hour: number): number {
  return 0.7 + 0.3 * Math.cos(((hour - 1.5) / 24) * Math.PI * 2);
}

/** AC capacity factor used for utility solar in western and southern India. */
export const SOLAR_CUF = 0.245;
/** AC capacity factor used for utility wind in Gujarat, Tamil Nadu and Karnataka. */
export const WIND_CUF = 0.32;

export function plantGenerationGwh(solarMw: number, windMw: number): number {
  return round(solarMw * 8.76 * SOLAR_CUF + windMw * 8.76 * WIND_CUF, 1);
}

export function plantP90Gwh(solarMw: number, windMw: number): number {
  return round(solarMw * 8.76 * SOLAR_CUF * 0.9 + windMw * 8.76 * WIND_CUF * 0.84, 1);
}

function technologyShares(solarMw: number, windMw: number) {
  const solarEnergy = Math.max(0, solarMw) * SOLAR_CUF;
  const windEnergy = Math.max(0, windMw) * WIND_CUF;
  const weight = solarEnergy + windEnergy;
  const solarShare = weight > 0 && solarMw > 0 ? (windMw > 0 ? solarEnergy / weight : 1) : 0;
  const windShare = weight > 0 && windMw > 0 ? (solarMw > 0 ? windEnergy / weight : 1) : 0;
  return { solarShare, windShare };
}

export function technologyEnergySplit(input: { solarMw: number; windMw: number; annualGenerationGwh: number }) {
  const { solarShare, windShare } = technologyShares(input.solarMw, input.windMw);
  return {
    solarGwh: input.annualGenerationGwh * solarShare,
    windGwh: input.annualGenerationGwh * windShare,
    solarCuf: impliedCuf(input.annualGenerationGwh * solarShare, input.solarMw),
    windCuf: impliedCuf(input.annualGenerationGwh * windShare, input.windMw),
  };
}

export function buildGenerationMw(input: {
  solarMw: number;
  windMw: number;
  annualGenerationGwh: number;
}): number[] {
  const solarShape = INTERVAL_LABELS.map((_, index) => solarUnit(hourOf(index)));
  const windShape = INTERVAL_LABELS.map((_, index) => windUnit(hourOf(index)));
  const { solarShare, windShare } = technologyShares(input.solarMw, input.windMw);
  const solarSeries =
    input.solarMw > 0
      ? scaleSeriesToAnnualGwh(
          solarShape.map((unit) => unit * input.solarMw),
          input.annualGenerationGwh * (input.windMw > 0 ? solarShare : 1),
        )
      : solarShape.map(() => 0);
  const windSeries =
    input.windMw > 0
      ? scaleSeriesToAnnualGwh(
          windShape.map((unit) => unit * input.windMw),
          input.annualGenerationGwh * (input.solarMw > 0 ? windShare : 1),
        )
      : windShape.map(() => 0);
  return solarSeries.map((solar, index) => solar + windSeries[index]);
}

export function impliedCuf(annualGwh: number, capacityMw: number): number {
  if (capacityMw <= 0 || annualGwh <= 0) return 0;
  return annualGwh / ((capacityMw * 8760) / 1000);
}

export function monthlyGeneration(annualGwh: number, solarShare: number): { month: string; gwh: number }[] {
  const solarSeason = [0.09, 0.09, 0.1, 0.1, 0.09, 0.07, 0.06, 0.06, 0.07, 0.08, 0.09, 0.1];
  const windSeason = [0.06, 0.06, 0.07, 0.08, 0.1, 0.12, 0.13, 0.12, 0.09, 0.07, 0.05, 0.05];
  const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  const blended = solarSeason.map((solar, index) => solar * solarShare + windSeason[index] * (1 - solarShare));
  const total = blended.reduce((sum, value) => sum + value, 0);
  return months.map((month, index) => ({
    month,
    gwh: round((annualGwh * blended[index]) / total, 2),
  }));
}
