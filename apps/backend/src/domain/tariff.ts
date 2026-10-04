import { clamp, round } from "./numbers";

export interface OpexRates {
  om: number;
  insurance: number;
  land: number;
  evacuation: number;
  bess: number;
  replacement: number;
  augmentation: number;
  degradation: number;
  development: number;
  regulatory: number;
  contingency: number;
}

export interface TariffDrivers {
  capexInrCr: number;
  bessCapexInrCr: number;
  debtRatio: number;
  interestRate: number;
  loanTenureYears: number;
  moratoriumYears: number;
  equityIrr: number;
  generationGwh: number;
  projectLifeYears: number;
  opex: OpexRates;
}

export interface TariffComponentResult {
  key: string;
  label: string;
  amount: number;
  capexLinked: boolean;
  debtLinked: boolean;
  bessLinked: boolean;
  fixedRecovery: boolean;
  sortOrder: number;
}

export interface TariffBuild {
  components: TariffComponentResult[];
  calculatedTariff: number;
  annualDebtServiceInr: number;
  debtInrCr: number;
  equityInrCr: number;
}

export interface TariffScenarioInput {
  capexChangePct?: number;
  interestChangePctPoints?: number;
  codDelayMonths?: number;
  cufReductionPct?: number;
  bessCostChangePct?: number;
}

export function annuityPayment(annualRate: number, years: number, principal: number): number {
  if (principal <= 0 || years <= 0) return 0;
  if (annualRate <= 0) return principal / years;
  const growth = (1 + annualRate) ** years;
  return (principal * annualRate * growth) / (growth - 1);
}

export function buildTariff(drivers: TariffDrivers): TariffBuild {
  const capexInr = drivers.capexInrCr * 1e7;
  let debt = capexInr * drivers.debtRatio;
  if (drivers.moratoriumYears > 0) {
    debt *= (1 + drivers.interestRate) ** drivers.moratoriumYears;
  }
  const repayYears = Math.max(1, drivers.loanTenureYears - drivers.moratoriumYears);
  const annualDebt = annuityPayment(drivers.interestRate, repayYears, debt);
  const equity = capexInr * (1 - drivers.debtRatio);
  const generationKwh = Math.max(drivers.generationGwh, 0.001) * 1e6;
  const life = Math.max(drivers.projectLifeYears, 1);
  const debtPerKwh = (annualDebt * repayYears) / life / generationKwh;
  const equityPerKwh = (equity * drivers.equityIrr) / generationKwh;
  const capital = debtPerKwh + equityPerKwh;
  const rows: TariffComponentResult[] = [
    { key: "capexRecovery", label: "CAPEX Recovery", amount: capital * 0.45, capexLinked: true, debtLinked: false, bessLinked: false, fixedRecovery: true, sortOrder: 1 },
    { key: "debtServicing", label: "Debt Servicing", amount: capital * 0.35, capexLinked: true, debtLinked: true, bessLinked: false, fixedRecovery: true, sortOrder: 2 },
    { key: "equityReturn", label: "Equity Return", amount: capital * 0.2, capexLinked: true, debtLinked: false, bessLinked: false, fixedRecovery: true, sortOrder: 3 },
    { key: "om", label: "O&M", amount: drivers.opex.om, capexLinked: false, debtLinked: false, bessLinked: false, fixedRecovery: false, sortOrder: 4 },
    { key: "insurance", label: "Insurance", amount: drivers.opex.insurance, capexLinked: false, debtLinked: false, bessLinked: false, fixedRecovery: false, sortOrder: 5 },
    { key: "land", label: "Land", amount: drivers.opex.land, capexLinked: false, debtLinked: false, bessLinked: false, fixedRecovery: false, sortOrder: 6 },
    { key: "evacuation", label: "Evacuation", amount: drivers.opex.evacuation, capexLinked: false, debtLinked: false, bessLinked: false, fixedRecovery: false, sortOrder: 7 },
    { key: "bess", label: "BESS", amount: drivers.opex.bess, capexLinked: false, debtLinked: false, bessLinked: true, fixedRecovery: false, sortOrder: 8 },
    { key: "replacement", label: "Replacement", amount: drivers.opex.replacement, capexLinked: false, debtLinked: false, bessLinked: true, fixedRecovery: false, sortOrder: 9 },
    { key: "augmentation", label: "Augmentation", amount: drivers.opex.augmentation, capexLinked: false, debtLinked: false, bessLinked: true, fixedRecovery: false, sortOrder: 10 },
    { key: "degradation", label: "Degradation", amount: drivers.opex.degradation, capexLinked: false, debtLinked: false, bessLinked: false, fixedRecovery: false, sortOrder: 11 },
    { key: "development", label: "Development", amount: drivers.opex.development, capexLinked: false, debtLinked: false, bessLinked: false, fixedRecovery: false, sortOrder: 12 },
    { key: "regulatoryRisk", label: "Regulatory Risk", amount: drivers.opex.regulatory, capexLinked: false, debtLinked: false, bessLinked: false, fixedRecovery: false, sortOrder: 13 },
    { key: "contingency", label: "Contingency", amount: drivers.opex.contingency, capexLinked: false, debtLinked: false, bessLinked: false, fixedRecovery: false, sortOrder: 14 },
    { key: "returns", label: "Returns", amount: 0, capexLinked: false, debtLinked: false, bessLinked: false, fixedRecovery: false, sortOrder: 15 },
  ].map((row) => ({ ...row, amount: round(row.amount, 4) }));

  const calculatedTariff = round(
    rows.reduce((total, row) => total + row.amount, 0),
    4,
  );
  return {
    components: rows,
    calculatedTariff,
    annualDebtServiceInr: annualDebt,
    debtInrCr: round(debt / 1e7, 2),
    equityInrCr: round(equity / 1e7, 2),
  };
}

export function applyTariffScenario(drivers: TariffDrivers, scenario: TariffScenarioInput): TariffDrivers {
  const capexFactor = 1 + (scenario.capexChangePct ?? 0) / 100;
  const bessFactor = 1 + (scenario.bessCostChangePct ?? 0) / 100;
  const bessCapex = drivers.bessCapexInrCr * bessFactor;
  const nonBess = Math.max(0, drivers.capexInrCr - drivers.bessCapexInrCr) * capexFactor;
  let capexInrCr = nonBess + bessCapex;
  const interestRate = Math.max(0, drivers.interestRate + (scenario.interestChangePctPoints ?? 0) / 100);
  const delayMonths = scenario.codDelayMonths ?? 0;
  if (delayMonths > 0) {
    const debtCr = capexInrCr * drivers.debtRatio;
    capexInrCr += debtCr * interestRate * (delayMonths / 12);
  }
  const generationGwh = drivers.generationGwh * (1 - (scenario.cufReductionPct ?? 0) / 100);
  return {
    ...drivers,
    capexInrCr,
    bessCapexInrCr: bessCapex,
    interestRate,
    generationGwh: Math.max(generationGwh, 0.001),
    opex: {
      ...drivers.opex,
      bess: round(drivers.opex.bess * bessFactor, 4),
      replacement: round(drivers.opex.replacement * bessFactor, 4),
      augmentation: round(drivers.opex.augmentation * bessFactor, 4),
    },
  };
}

export function compareTariffScenario(drivers: TariffDrivers, scenario: TariffScenarioInput) {
  const base = buildTariff(drivers);
  const next = buildTariff(applyTariffScenario(drivers, scenario));
  const change = round(next.calculatedTariff - base.calculatedTariff, 4);
  const changePct = round(base.calculatedTariff ? (change / base.calculatedTariff) * 100 : 0, 2);
  return {
    baseTariff: base.calculatedTariff,
    scenarioTariff: next.calculatedTariff,
    change,
    changePct,
    base,
    scenario: next,
  };
}

export type SustainabilityRating = "SUSTAINABLE" | "AGGRESSIVE" | "UNSUSTAINABLE";

export function assessTariffSustainability(input: {
  quotedTariff: number;
  calculatedTariff: number;
  dscr: number;
  p50Gwh: number;
  p90Gwh: number;
  budgetaryShare: number;
  bessMw: number;
  bessExcluded: boolean;
  evacuationExcluded: boolean;
  escalationClear: boolean;
  solarCuf: number;
  windCuf: number;
}): SustainabilityRating {
  const gap = input.calculatedTariff > 0 ? (input.calculatedTariff - input.quotedTariff) / input.calculatedTariff : 0;
  const p90Ratio = input.p50Gwh > 0 ? input.p90Gwh / input.p50Gwh : 0;
  let penalty = 0;
  if (gap > 0.08) penalty += 2;
  else if (gap > 0.03) penalty += 1;
  if (input.dscr < 1.1) penalty += 2;
  else if (input.dscr < 1.25) penalty += 1;
  if (p90Ratio > 0 && p90Ratio < 0.8) penalty += 1;
  if (input.budgetaryShare > 0.45) penalty += 1;
  if (input.bessMw > 0 && input.bessExcluded) penalty += 2;
  if (input.evacuationExcluded) penalty += 1;
  if (!input.escalationClear) penalty += 1;
  if (input.solarCuf > 0.3 || input.windCuf > 0.48) penalty += 1;
  if (penalty >= 4) return "UNSUSTAINABLE";
  if (penalty >= 2) return "AGGRESSIVE";
  return "SUSTAINABLE";
}

export function tariffFitScore(tariff: number, floor: number, ceiling: number): number {
  if (ceiling <= floor) return 50;
  return round(clamp(((ceiling - tariff) / (ceiling - floor)) * 100, 0, 100), 2);
}
