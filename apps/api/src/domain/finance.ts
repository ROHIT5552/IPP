import { round } from "./numbers";
import { TariffDrivers, annuityPayment, buildTariff } from "./tariff";

export interface FinancialResult {
  dscr: number;
  projectIrr: number;
  equityIrr: number;
  equityYield: number;
  annualDebtServiceInr: number;
  debtInrCr: number;
  equityInrCr: number;
  debtEquityRatio: number;
  ebitdaInrCr: number;
  capabilityScore: number;
}

function irr(cashflows: number[]): number {
  let rate = 0.12;
  for (let iteration = 0; iteration < 40; iteration += 1) {
    let value = 0;
    let derivative = 0;
    cashflows.forEach((cashflow, year) => {
      const denominator = (1 + rate) ** year;
      value += cashflow / denominator;
      if (year > 0) derivative -= (year * cashflow) / ((1 + rate) ** (year + 1));
    });
    if (Math.abs(derivative) < 1e-9) break;
    const next = rate - value / derivative;
    if (!Number.isFinite(next)) break;
    if (Math.abs(next - rate) < 1e-6) return next;
    rate = Math.min(1.5, Math.max(-0.9, next));
  }
  return rate;
}

export function opexPerKwh(drivers: TariffDrivers): number {
  return Object.values(drivers.opex).reduce((total, value) => total + value, 0);
}

export function assessFinancialFeasibility(
  drivers: TariffDrivers,
  quotedTariff: number,
  signals: { lenderIdentified: boolean; fundraisingDependency: boolean },
): FinancialResult {
  const tariff = buildTariff(drivers);
  const generationKwh = Math.max(drivers.generationGwh, 0.001) * 1e6;
  const ebitda = generationKwh * (quotedTariff - opexPerKwh(drivers));
  const dscr = tariff.annualDebtServiceInr > 0 ? ebitda / tariff.annualDebtServiceInr : 0;
  const equityInr = tariff.equityInrCr * 1e7;
  const equityCash = ebitda - tariff.annualDebtServiceInr;
  const cashflows = [-equityInr, ...Array.from({ length: drivers.projectLifeYears }, () => equityCash)];
  const equityIrr = irr(cashflows);
  const projectCashflows = [
    -drivers.capexInrCr * 1e7,
    ...Array.from({ length: drivers.projectLifeYears }, () => ebitda),
  ];
  let capability = 3;
  if (dscr >= 1.45) capability += 1.1;
  else if (dscr >= 1.3) capability += 0.7;
  else if (dscr >= 1.15) capability += 0.2;
  else capability -= 0.8;
  if (signals.lenderIdentified) capability += 0.3;
  else capability -= 0.5;
  if (signals.fundraisingDependency) capability -= 0.4;
  if (drivers.debtRatio > 0.78) capability -= 0.3;
  capability = Math.min(5, Math.max(1, capability));
  return {
    dscr: round(dscr, 3),
    projectIrr: round(irr(projectCashflows) * 100, 2),
    equityIrr: round(equityIrr * 100, 2),
    equityYield: round(equityInr > 0 ? (equityCash / equityInr) * 100 : 0, 2),
    annualDebtServiceInr: tariff.annualDebtServiceInr,
    debtInrCr: tariff.debtInrCr,
    equityInrCr: tariff.equityInrCr,
    debtEquityRatio: round(drivers.debtRatio / Math.max(0.01, 1 - drivers.debtRatio), 2),
    ebitdaInrCr: round(ebitda / 1e7, 2),
    capabilityScore: round(capability, 2),
  };
}
