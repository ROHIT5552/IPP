import { capexCredibility } from "../domain/capex";
import { IppCase } from "../domain/evaluate";
import { MilestoneInput } from "../domain/execution";
import { DEFAULT_SUITABILITY_WEIGHTS, EvaluationScores } from "../domain/parameters";
import { plantGenerationGwh, plantP90Gwh, technologyEnergySplit } from "../domain/profiles";
import { buildTariff, OpexRates, TariffDrivers } from "../domain/tariff";

export const DEMO_PASSWORD = "NewraDemo#2026";
export const TARIFF_FLOOR = 3.2;
export const TARIFF_CEILING = 4.6;

const MILESTONES = [
  "Detailed Engineering",
  "Connectivity Application",
  "System Studies",
  "Connectivity Approval",
  "Financial Closure",
  "EPC Appointment",
  "Major Procurement",
  "Civil Works",
  "Evacuation Construction",
  "Equipment Delivery",
  "Substation Readiness",
  "Mechanical Completion",
  "Electrical Completion",
  "Synchronization",
  "Trial Operation",
  "COD",
];

export interface GesSeed {
  id: string;
  name: string;
  legalName: string;
  businessType: string;
  location: string;
  state: string;
  discom: string;
  consumerNumbers: string;
  contractDemandMw: number;
  billedDemandMw: number;
  existingRooftopMw: number;
  existingRenewableGwh: number;
  annualConsumptionGwh: number;
  notes: string;
  crmStage: "CLIENT_DISCOVERY" | "INTRODUCTION" | "ELECTRICITY_BILLS" | "NRG_ANALYSIS" | "LOI" | "NRG_SYMPHONY" | "NDA_TC" | "ANNEXURE_B_PPA_DRAFT" | "FINALIZATION" | "PPA_SIGNING" | "PHASE_3_GO_LIVE";
  evaluationStage: "IPP_EVALUATION" | "IPP_SHORTLISTING" | "NEGOTIATION" | "PSOA" | "DEALBOOK";
  annualEnergyGwh: number;
  peakDemandMw: number;
  requiredCapacityGw: number;
  targetCodYear: number;
  preferredTechnologies: string[];
  bessPreference: "OPTIONAL" | "HOURS_2_TO_4" | "HOURS_4";
  bessHoursMin: number;
  bessHoursMax: number | null;
  requirementNotes: string;
}

export const GES_SEED: GesSeed[] = [
  {
    id: "ges_aster",
    name: "Aster Manufacturing Group",
    legalName: "Aster Manufacturing Group Private Limited",
    businessType: "Industrial Consumer",
    location: "Pune",
    state: "Maharashtra",
    discom: "MSEDCL",
    consumerNumbers: "310014408821, 310014408846",
    contractDemandMw: 214,
    billedDemandMw: 186,
    existingRooftopMw: 6.5,
    existingRenewableGwh: 11.4,
    annualConsumptionGwh: 1486,
    notes: "Two HT connections at Chakan and Pimpri. Three-shift forging and machining, load factor 79% on 214 MW contract demand. Night furnace load is why four-hour storage is required.",
    crmStage: "NRG_SYMPHONY",
    evaluationStage: "IPP_SHORTLISTING",
    annualEnergyGwh: 972,
    peakDemandMw: 168,
    requiredCapacityGw: 0.46,
    targetCodYear: 2030,
    preferredTechnologies: ["SOLAR", "WIND", "BESS"],
    bessPreference: "HOURS_4",
    bessHoursMin: 4,
    bessHoursMax: 4,
    requirementNotes: "Open-access tranche of 972 GWh, 65% of annual consumption, for a night-weighted industrial shape with four-hour storage.",
  },
  {
    id: "ges_nova",
    name: "Nova Industrial Works",
    legalName: "Nova Industrial Works Limited",
    businessType: "Industrial Consumer",
    location: "Ahmedabad",
    state: "Gujarat",
    discom: "UGVCL",
    consumerNumbers: "082140319557",
    contractDemandMw: 156,
    billedDemandMw: 128,
    existingRooftopMw: 3.2,
    existingRenewableGwh: 5.5,
    annualConsumptionGwh: 1014,
    notes: "Sanand process plant on UGVCL. Daytime load factor 74% on 156 MW contract demand. Storage is useful but not required.",
    crmStage: "NDA_TC",
    evaluationStage: "IPP_EVALUATION",
    annualEnergyGwh: 728,
    peakDemandMw: 132,
    requiredCapacityGw: 0.34,
    targetCodYear: 2030,
    preferredTechnologies: ["SOLAR", "WIND"],
    bessPreference: "OPTIONAL",
    bessHoursMin: 0,
    bessHoursMax: null,
    requirementNotes: "Open-access tranche of 728 GWh, 72% of annual consumption, for a day-weighted process load. Storage is optional.",
  },
  {
    id: "ges_vertex",
    name: "Vertex Metals & Engineering",
    legalName: "Vertex Metals & Engineering Private Limited",
    businessType: "Industrial Consumer",
    location: "Bellary",
    state: "Karnataka",
    discom: "GESCOM",
    consumerNumbers: "904412208831, 904412208874",
    contractDemandMw: 124,
    billedDemandMw: 108,
    existingRooftopMw: 1.8,
    existingRenewableGwh: 3.1,
    annualConsumptionGwh: 846,
    notes: "Bellary steel and engineering load on GESCOM. Load factor 78% on 124 MW contract demand, with the peak after 16:00. Two to four hours of storage is preferred.",
    crmStage: "LOI",
    evaluationStage: "IPP_SHORTLISTING",
    annualEnergyGwh: 608,
    peakDemandMw: 118,
    requiredCapacityGw: 0.29,
    targetCodYear: 2031,
    preferredTechnologies: ["SOLAR", "WIND", "BESS"],
    bessPreference: "HOURS_2_TO_4",
    bessHoursMin: 2,
    bessHoursMax: 4,
    requirementNotes: "Open-access tranche of 608 GWh, 72% of annual consumption, for an evening-peaking metals load and 2–4 hour storage.",
  },
  {
    id: "ges_helix",
    name: "Helix Chemicals",
    legalName: "Helix Chemicals Private Limited",
    businessType: "Industrial Consumer",
    location: "Cuddalore",
    state: "Tamil Nadu",
    discom: "TANGEDCO",
    consumerNumbers: "039220184410",
    contractDemandMw: 92,
    billedDemandMw: 76,
    existingRooftopMw: 1.1,
    existingRenewableGwh: 1.9,
    annualConsumptionGwh: 584,
    notes: "Cuddalore chemical complex on TANGEDCO. Load factor 72% on 92 MW contract demand. The process runs a daytime plateau, so storage is optional.",
    crmStage: "INTRODUCTION",
    evaluationStage: "IPP_EVALUATION",
    annualEnergyGwh: 437,
    peakDemandMw: 84,
    requiredCapacityGw: 0.21,
    targetCodYear: 2031,
    preferredTechnologies: ["SOLAR", "WIND"],
    bessPreference: "OPTIONAL",
    bessHoursMin: 0,
    bessHoursMax: null,
    requirementNotes: "Open-access tranche of 437 GWh, 75% of annual consumption, for a daytime chemical process load. Storage is optional.",
  },
];

export const LINK_SEED: Record<string, Record<string, "HIGHLY_SUITABLE" | "SUITABLE" | "CONDITIONAL">> = {
  ges_aster: {
    ipp_sungrid: "HIGHLY_SUITABLE",
    ipp_greenvolt: "HIGHLY_SUITABLE",
    ipp_windcore: "SUITABLE",
    ipp_hybridgreen: "HIGHLY_SUITABLE",
    ipp_repower: "HIGHLY_SUITABLE",
    ipp_novarenewable: "CONDITIONAL",
    ipp_aerosun: "SUITABLE",
    ipp_terragrid: "HIGHLY_SUITABLE",
    ipp_eastwind: "SUITABLE",
    ipp_solstice: "HIGHLY_SUITABLE",
  },
  ges_nova: {
    ipp_sungrid: "SUITABLE",
    ipp_greenvolt: "HIGHLY_SUITABLE",
    ipp_windcore: "SUITABLE",
    ipp_hybridgreen: "SUITABLE",
    ipp_repower: "HIGHLY_SUITABLE",
    ipp_novarenewable: "HIGHLY_SUITABLE",
    ipp_aerosun: "SUITABLE",
    ipp_terragrid: "HIGHLY_SUITABLE",
    ipp_eastwind: "HIGHLY_SUITABLE",
    ipp_solstice: "SUITABLE",
  },
  ges_vertex: {
    ipp_sungrid: "HIGHLY_SUITABLE",
    ipp_greenvolt: "SUITABLE",
    ipp_windcore: "SUITABLE",
    ipp_hybridgreen: "HIGHLY_SUITABLE",
    ipp_repower: "SUITABLE",
    ipp_novarenewable: "CONDITIONAL",
    ipp_aerosun: "HIGHLY_SUITABLE",
    ipp_terragrid: "HIGHLY_SUITABLE",
    ipp_eastwind: "SUITABLE",
    ipp_solstice: "HIGHLY_SUITABLE",
  },
  ges_helix: {
    ipp_sungrid: "SUITABLE",
    ipp_greenvolt: "HIGHLY_SUITABLE",
    ipp_windcore: "HIGHLY_SUITABLE",
    ipp_hybridgreen: "SUITABLE",
    ipp_repower: "SUITABLE",
    ipp_novarenewable: "HIGHLY_SUITABLE",
    ipp_aerosun: "SUITABLE",
    ipp_terragrid: "HIGHLY_SUITABLE",
    ipp_eastwind: "HIGHLY_SUITABLE",
    ipp_solstice: "SUITABLE",
  },
};

type Assumption = "FIRM" | "QUOTATION_SUPPORTED" | "INDICATIVE" | "BUDGETARY";

interface IppDraft {
  id: string;
  name: string;
  legalName: string;
  headquarters: string;
  solarMw: number;
  windMw: number;
  bessMw: number;
  bessMwh: number;
  annualGenerationGwh: number;
  p90Gwh: number;
  quotedTariff: number;
  codYear: number;
  scores: EvaluationScores;
  costFactor: number;
  debtRatio: number;
  interestRate: number;
  loanTenureYears: number;
  moratoriumYears: number;
  equityIrr: number;
  lenderIdentified: boolean;
  fundraisingDependency: boolean;
  financingScheduleMismatch: boolean;
  connectivityStatus: IppCase["connectivityStatus"];
  generationValidation: IppCase["generationValidation"];
  assumptions: Assumption[];
  hasCpm: boolean;
  procurementAligned: boolean;
  connectivityAssumed: boolean;
  epcCommitted: boolean;
  projectBufferMonths: number;
  weakSystemStudy: boolean;
  bessDegradation: number | null;
  bessExcluded: boolean;
  evacuationExcluded: boolean;
  escalationClear: boolean;
  changeInLaw: IppCase["changeInLaw"];
  curtailment: IppCase["curtailment"];
  indemnity: IppCase["indemnity"];
  complianceBearer: IppCase["complianceBearer"];
  delayBearer: IppCase["delayBearer"];
  scadaIntegration: IppCase["scadaIntegration"];
  dataQualityFactor: number;
  chemistry: string;
  oem: string;
  experienceMw: number;
  years: number;
  projects: number;
  notable: string;
  pendingFrom: string;
  evaluationStage: "IPP_EVALUATION" | "IPP_SHORTLISTING";
  module: string;
  inverter: string;
  wtg: string;
}

const DRAFTS: IppDraft[] = [
  draft("ipp_sungrid", "SunGrid Renewable Energy", "Hyderabad", 360, 0, 64, 256, 3.85, 2029, [4.6, 4.5, 4.4, 4.6, 4.7, 4.5, 4.5, 4.1, 4.3, 4.2], { costFactor: 0.99, debtRatio: 0.7, interestRate: 0.086, lenderIdentified: true, connectivityStatus: "APPROVAL_PENDING", generationValidation: "VERIFIED", assumptions: ["FIRM", "QUOTATION_SUPPORTED", "FIRM"], scadaIntegration: "EVIDENCED", changeInLaw: "PROTECTED", chemistry: "LFP", oem: "GridStore", experienceMw: 980, pendingFrom: "Technical reviewer" }),
  draft("ipp_greenvolt", "GreenVolt Power", "Mumbai", 250, 170, 36, 144, 3.62, 2030, [4.4, 4.7, 4.5, 4.3, 4.8, 4.4, 4.2, 4.4, 4.6, 4.1], { costFactor: 1.01, debtRatio: 0.68, interestRate: 0.084, lenderIdentified: true, connectivityStatus: "UNDER_STUDY", generationValidation: "VERIFIED", assumptions: ["QUOTATION_SUPPORTED", "FIRM", "INDICATIVE"], scadaIntegration: "PLANNED", changeInLaw: "SHARED", chemistry: "LFP", oem: "NorthCell", experienceMw: 860, pendingFrom: "Commercial reviewer" }),
  draft("ipp_windcore", "WindCore Energy", "Chennai", 0, 310, 48, 192, 3.95, 2030, [4.2, 4.3, 4.6, 4.5, 4.2, 4.3, 4.1, 4.0, 4.0, 4.4], { costFactor: 1.0, debtRatio: 0.72, interestRate: 0.089, lenderIdentified: true, connectivityStatus: "APPLICATION_SUBMITTED", generationValidation: "UNDER_REVIEW", assumptions: ["QUOTATION_SUPPORTED", "INDICATIVE", "QUOTATION_SUPPORTED"], scadaIntegration: "PLANNED", changeInLaw: "PROTECTED", chemistry: "LFP", oem: "AeroStore", experienceMw: 740, pendingFrom: "Technical reviewer" }),
  draft("ipp_hybridgreen", "HybridGreen Power", "Bengaluru", 320, 190, 60, 240, 4.05, 2031, [4.1, 4.0, 4.2, 4.7, 4.9, 4.2, 3.9, 3.9, 3.8, 4.0], { costFactor: 1.05, debtRatio: 0.75, interestRate: 0.094, lenderIdentified: false, fundraisingDependency: true, financingScheduleMismatch: true, connectivityStatus: "PRELIMINARY", generationValidation: "PENDING", assumptions: ["BUDGETARY", "INDICATIVE", "BUDGETARY"], connectivityAssumed: true, procurementAligned: false, projectBufferMonths: 1.5, weakSystemStudy: true, scadaIntegration: "NONE", changeInLaw: "UNLIMITED", curtailment: "AMBIGUOUS", indemnity: "WEAK", complianceBearer: "GES", delayBearer: "UNCLEAR", epcCommitted: false, dataQualityFactor: 0.8, chemistry: "NMC", oem: "HybridCell", experienceMw: 640, pendingFrom: "Finance reviewer" }),
  draft("ipp_repower", "RePower Infrastructure", "Delhi", 420, 130, 40, 160, 3.72, 2029, [4.7, 4.4, 4.3, 4.4, 4.4, 4.8, 4.7, 4.2, 4.5, 4.3], { costFactor: 0.985, debtRatio: 0.7, interestRate: 0.085, lenderIdentified: true, connectivityStatus: "APPROVAL_PENDING", generationValidation: "VERIFIED", assumptions: ["FIRM", "FIRM", "QUOTATION_SUPPORTED"], scadaIntegration: "EVIDENCED", changeInLaw: "PROTECTED", chemistry: "LFP", oem: "ReStore", experienceMw: 1240, pendingFrom: "Evaluator" }),
  draft("ipp_novarenewable", "Nova Renewable Systems", "Ahmedabad", 500, 0, 0, 0, 3.42, 2028, [4.3, 4.1, 4.0, 4.2, 3.1, 4.5, 4.6, 4.7, 4.8, 4.0], { costFactor: 1.16, debtRatio: 0.79, interestRate: 0.098, lenderIdentified: false, fundraisingDependency: true, financingScheduleMismatch: true, connectivityStatus: "PRELIMINARY", generationValidation: "UNDER_REVIEW", assumptions: ["INDICATIVE", "BUDGETARY", "INDICATIVE"], connectivityAssumed: true, procurementAligned: false, evacuationExcluded: true, escalationClear: false, bessExcluded: false, changeInLaw: "UNLIMITED", complianceBearer: "GES", delayBearer: "UNCLEAR", scadaIntegration: "NONE", dataQualityFactor: 0.88, chemistry: "None", oem: "None", experienceMw: 820, pendingFrom: "Technical reviewer", weakSystemStudy: true }),
  draft("ipp_aerosun", "AeroSun Energy", "Jaipur", 190, 240, 36, 144, 3.88, 2030, [4.0, 4.6, 4.5, 4.5, 4.6, 4.1, 4.0, 4.1, 4.2, 4.5], { costFactor: 1.0, debtRatio: 0.69, interestRate: 0.087, lenderIdentified: true, connectivityStatus: "UNDER_STUDY", generationValidation: "RECEIVED", assumptions: ["QUOTATION_SUPPORTED", "QUOTATION_SUPPORTED", "INDICATIVE"], scadaIntegration: "PLANNED", changeInLaw: "PROTECTED", chemistry: "LFP", oem: "AeroCell", experienceMw: 710, pendingFrom: "Commercial reviewer" }),
  draft("ipp_terragrid", "TerraGrid Renewables", "Pune", 340, 110, 55, 220, 3.78, 2029, [4.5, 4.5, 4.7, 4.4, 4.7, 4.6, 4.4, 4.3, 4.4, 4.6], { costFactor: 0.99, debtRatio: 0.7, interestRate: 0.085, lenderIdentified: true, connectivityStatus: "APPROVED", generationValidation: "VERIFIED", assumptions: ["FIRM", "QUOTATION_SUPPORTED", "FIRM"], scadaIntegration: "EVIDENCED", changeInLaw: "PROTECTED", chemistry: "LFP", oem: "TerraStore", experienceMw: 1100, pendingFrom: "None" }),
  draft("ipp_eastwind", "EastWind Harvest", "Kolkata", 0, 260, 22, 88, 3.91, 2030, [4.3, 4.4, 4.5, 4.2, 4.1, 4.3, 4.2, 4.2, 4.1, 4.3], { costFactor: 1.0, debtRatio: 0.7, interestRate: 0.088, lenderIdentified: true, connectivityStatus: "APPLICATION_SUBMITTED", generationValidation: "UNDER_REVIEW", assumptions: ["QUOTATION_SUPPORTED", "INDICATIVE", "QUOTATION_SUPPORTED"], scadaIntegration: "PLANNED", changeInLaw: "SHARED", chemistry: "LFP", oem: "EastStore", experienceMw: 620, pendingFrom: "Technical reviewer" }),
  draft("ipp_solstice", "Solstice Hybrid", "Nagpur", 280, 75, 32, 128, 3.96, 2030, [4.2, 4.3, 4.4, 4.5, 4.6, 4.2, 4.1, 4.0, 4.0, 4.2], { costFactor: 1.02, debtRatio: 0.71, interestRate: 0.09, lenderIdentified: true, connectivityStatus: "UNDER_STUDY", generationValidation: "RECEIVED", assumptions: ["QUOTATION_SUPPORTED", "QUOTATION_SUPPORTED", "INDICATIVE"], scadaIntegration: "PLANNED", changeInLaw: "PROTECTED", chemistry: "LFP", oem: "SolCell", experienceMw: 690, pendingFrom: "Commercial reviewer" }),
];

function draft(
  id: string,
  name: string,
  headquarters: string,
  solarMw: number,
  windMw: number,
  bessMw: number,
  bessMwh: number,
  quotedTariff: number,
  codYear: number,
  scoreRow: number[],
  extra: Partial<IppDraft> & Pick<IppDraft, "costFactor" | "debtRatio" | "interestRate" | "connectivityStatus" | "generationValidation" | "assumptions" | "scadaIntegration" | "changeInLaw" | "chemistry" | "oem" | "experienceMw" | "pendingFrom">,
): IppDraft {
  const [execution, financial, ehv, engineering, fdre, epc, cod, capex, tariff, regulatory] = scoreRow;
  return {
    id,
    name,
    legalName: `${name} Limited`,
    headquarters,
    solarMw,
    windMw,
    bessMw,
    bessMwh,
    annualGenerationGwh: plantGenerationGwh(solarMw, windMw),
    p90Gwh: plantP90Gwh(solarMw, windMw),
    quotedTariff,
    codYear,
    scores: { execution, financial, ehv, engineering, fdre, epc, cod, capex, tariff, regulatory },
    loanTenureYears: extra.loanTenureYears ?? 18,
    moratoriumYears: extra.moratoriumYears ?? 0.5,
    equityIrr: extra.equityIrr ?? 0.135,
    lenderIdentified: extra.lenderIdentified ?? true,
    fundraisingDependency: extra.fundraisingDependency ?? false,
    financingScheduleMismatch: extra.financingScheduleMismatch ?? false,
    hasCpm: extra.hasCpm ?? true,
    procurementAligned: extra.procurementAligned ?? true,
    connectivityAssumed: extra.connectivityAssumed ?? false,
    epcCommitted: extra.epcCommitted ?? true,
    projectBufferMonths: extra.projectBufferMonths ?? 4,
    weakSystemStudy: extra.weakSystemStudy ?? false,
    bessDegradation: extra.bessDegradation === undefined ? (bessMw > 0 ? 0.025 : null) : extra.bessDegradation,
    bessExcluded: extra.bessExcluded ?? false,
    evacuationExcluded: extra.evacuationExcluded ?? false,
    escalationClear: extra.escalationClear ?? true,
    curtailment: extra.curtailment ?? "CLEAR",
    indemnity: extra.indemnity ?? "STRONG",
    complianceBearer: extra.complianceBearer ?? "IPP",
    delayBearer: extra.delayBearer ?? "IPP",
    dataQualityFactor: extra.dataQualityFactor ?? 1,
    evaluationStage: "IPP_EVALUATION",
    years: 11,
    projects: 7,
    notable: "Operating and under-construction renewable capacity in western and southern India.",
    module: solarMw > 0 ? "TOPCon bifacial" : "Not applicable",
    inverter: solarMw > 0 ? "Central inverters with plant controller" : "Not applicable",
    wtg: windMw > 0 ? "4.2 MW class" : "Not applicable",
    ...extra,
  };
}

function opexFor(draftIpp: IppDraft): OpexRates {
  const hasBess = draftIpp.bessMw > 0 && !draftIpp.bessExcluded;
  return {
    om: 0.32,
    insurance: 0.07,
    land: 0.09,
    evacuation: draftIpp.evacuationExcluded ? 0 : 0.14,
    bess: hasBess ? 0.11 : 0,
    replacement: hasBess ? 0.06 : 0,
    augmentation: hasBess ? 0.05 : 0,
    degradation: 0.08,
    development: 0.06,
    regulatory: 0.05,
    contingency: 0.07,
  };
}

function componentFractions(draftIpp: IppDraft): Array<{ category: string; fraction: number }> {
  const solar = draftIpp.solarMw * 4.4;
  const wind = draftIpp.windMw * 7.4;
  const bess = draftIpp.bessMwh * 2;
  const plant = solar + wind + bess || 1;
  const raw: Array<[string, number]> = [
    ["Solar CAPEX", solar / plant],
    ["Wind CAPEX", wind / plant],
    ["BESS CAPEX", bess / plant],
    ["EPC", 0.08],
    ["Pooling", 0.035],
    ["Transmission", 0.05],
    ["Bay", 0.02],
    ["SCADA", 0.012],
    ["EMS", 0.01],
    ["Metering", 0.008],
    ["Civil", 0.04],
    ["Development", 0.025],
    ["IDC", 0.03],
    ["Taxes", 0.025],
    ["Insurance", 0.01],
    ["Contingency", 0.02],
    ["Other CAPEX", 0.015],
  ];
  const shareTotal = raw.reduce((sum, [, share]) => sum + share, 0) || 1;
  return raw.map(([category, share]) => ({ category, fraction: share / shareTotal })).filter((row) => row.fraction > 0);
}

function solveCapex(draftIpp: IppDraft): number {
  const target = draftIpp.quotedTariff * draftIpp.costFactor;
  const share = componentFractions(draftIpp).find((row) => row.category === "BESS CAPEX")?.fraction ?? 0;
  let low = 200;
  let high = 120000;
  for (let index = 0; index < 48; index += 1) {
    const mid = (low + high) / 2;
    const calculated = buildTariff(driversFor(draftIpp, mid, mid * share)).calculatedTariff;
    if (calculated < target) low = mid;
    else high = mid;
  }
  return Math.round(((low + high) / 2) * 100) / 100;
}

function driversFor(draftIpp: IppDraft, capexInrCr: number, bessCapexInrCr: number): TariffDrivers {
  return {
    capexInrCr,
    bessCapexInrCr,
    debtRatio: draftIpp.debtRatio,
    interestRate: draftIpp.interestRate,
    loanTenureYears: draftIpp.loanTenureYears,
    moratoriumYears: draftIpp.moratoriumYears,
    equityIrr: draftIpp.equityIrr,
    generationGwh: draftIpp.annualGenerationGwh,
    projectLifeYears: 25,
    opex: opexFor(draftIpp),
  };
}

export interface CapexSeedLine {
  category: string;
  amountInrCr: number;
  assumptionType: Assumption;
}

function capexLines(draftIpp: IppDraft, total: number): CapexSeedLine[] {
  return componentFractions(draftIpp).map((row, index) => ({
    category: row.category,
    amountInrCr: Math.round(total * row.fraction * 100) / 100,
    assumptionType: draftIpp.assumptions[index % draftIpp.assumptions.length],
  }));
}

function milestones(bufferMonths: number): MilestoneInput[] {
  return MILESTONES.map((name, index) => ({
    name,
    durationDays: name === "Major Procurement" || name === "Evacuation Construction" ? 120 : 45,
    leadTimeDays: name === "Major Procurement" ? 240 : name === "Connectivity Approval" ? 180 : 30 + index,
  })).map((milestone) => ({
    ...milestone,
    durationDays: milestone.durationDays + Math.round(bufferMonths),
  }));
}

export interface SeedIpp extends IppCase {
  meta: IppDraft;
  lines: CapexSeedLine[];
}

export function buildIppCases(): SeedIpp[] {
  return DRAFTS.map(toSeedIpp);
}

export function manualSeedIpp(input: {
  id: string;
  name: string;
  headquarters: string;
  solarMw: number;
  windMw: number;
  bessMw: number;
  bessMwh: number;
  annualGenerationGwh: number;
  p90Gwh?: number | null;
  quotedTariff: number;
  codYear: number;
}): SeedIpp {
  const p90 = input.p90Gwh == null ? 0 : input.p90Gwh;
  const seeded = draft(
    input.id,
    input.name,
    input.headquarters,
    input.solarMw,
    input.windMw,
    input.bessMw,
    input.bessMwh,
    input.quotedTariff,
    input.codYear,
    [4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    {
      costFactor: 1,
      debtRatio: 0.7,
      interestRate: 0.09,
      lenderIdentified: true,
      connectivityStatus: "UNDER_STUDY",
      generationValidation: "PENDING",
      assumptions: ["INDICATIVE", "INDICATIVE", "INDICATIVE"],
      scadaIntegration: "PLANNED",
      changeInLaw: "SHARED",
      chemistry: input.bessMw > 0 ? "LFP" : "None",
      oem: "Declared at entry",
      experienceMw: input.solarMw + input.windMw,
      pendingFrom: "Evaluator",
    },
  );
  return toSeedIpp({
    ...seeded,
    annualGenerationGwh: input.annualGenerationGwh,
    p90Gwh: p90,
  });
}

function toSeedIpp(draftIpp: IppDraft): SeedIpp {
    const capexInrCr = solveCapex(draftIpp);
    const bessShare = componentFractions(draftIpp).find((row) => row.category === "BESS CAPEX")?.fraction ?? 0;
    const drivers = driversFor(draftIpp, capexInrCr, Math.round(capexInrCr * bessShare * 100) / 100);
    const lines = capexLines(draftIpp, capexInrCr);
    const items = lines.map((item) => ({
      amountInrCr: item.amountInrCr,
      assumptionType: item.assumptionType,
    }));
    const credibility = capexCredibility(items);
    const split = technologyEnergySplit({
      solarMw: draftIpp.solarMw,
      windMw: draftIpp.windMw,
      annualGenerationGwh: draftIpp.annualGenerationGwh,
    });
    const p50 = draftIpp.annualGenerationGwh;
    return {
      id: draftIpp.id,
      name: draftIpp.name,
      solarMw: draftIpp.solarMw,
      windMw: draftIpp.windMw,
      bessMw: draftIpp.bessMw,
      bessMwh: draftIpp.bessMwh,
      annualGenerationGwh: draftIpp.annualGenerationGwh,
      p50Gwh: p50,
      p75Gwh: Math.round(((p50 + draftIpp.p90Gwh) / 2) * 10) / 10,
      p90Gwh: draftIpp.p90Gwh,
      quotedTariff: draftIpp.quotedTariff,
      codYear: draftIpp.codYear,
      baseScores: draftIpp.scores,
      solarCuf: split.solarCuf,
      windCuf: split.windCuf,
      generationValidation: draftIpp.generationValidation,
      connectivityStatus: draftIpp.connectivityStatus,
      capexItems: items,
      drivers,
      lenderIdentified: draftIpp.lenderIdentified,
      fundraisingDependency: draftIpp.fundraisingDependency,
      financingScheduleMismatch: draftIpp.financingScheduleMismatch,
      hasCpm: draftIpp.hasCpm,
      procurementAligned: draftIpp.procurementAligned,
      connectivityAssumed: draftIpp.connectivityAssumed,
      epcCommitted: draftIpp.epcCommitted,
      projectBufferMonths: draftIpp.projectBufferMonths,
      weakSystemStudy: draftIpp.weakSystemStudy,
      bessDegradation: draftIpp.bessDegradation,
      bessExcluded: draftIpp.bessExcluded,
      evacuationExcluded: draftIpp.evacuationExcluded,
      escalationClear: draftIpp.escalationClear,
      changeInLaw: draftIpp.changeInLaw,
      curtailment: draftIpp.curtailment,
      indemnity: draftIpp.indemnity,
      complianceBearer: draftIpp.complianceBearer,
      delayBearer: draftIpp.delayBearer,
      scadaIntegration: draftIpp.scadaIntegration,
      dataQualityFactor: draftIpp.dataQualityFactor,
      depthOfDischarge: draftIpp.bessMw > 0 ? 0.9 : 0,
      roundTripEfficiency: draftIpp.bessMw > 0 ? 0.87 : 1,
      usableEnergyMwh: draftIpp.bessMwh * 0.9,
      milestones: milestones(draftIpp.projectBufferMonths),
      baseline: {
        interestRate: draftIpp.interestRate,
        capexInrCr,
        capexCredibility: credibility.score,
        bessMw: draftIpp.bessMw,
        bessMwh: draftIpp.bessMwh,
        solarCuf: split.solarCuf,
        windCuf: split.windCuf,
        generationGwh: draftIpp.annualGenerationGwh,
      },
      meta: draftIpp,
      lines,
    };
}

export function draftById(id: string): IppDraft {
  const found = DRAFTS.find((item) => item.id === id);
  if (!found) throw new Error(`Unknown IPP ${id}`);
  return found;
}

export const SUITABILITY_CONFIG = {
  id: "suitability_default",
  name: "Default GES suitability weights",
  weights: DEFAULT_SUITABILITY_WEIGHTS,
  tariffFloor: TARIFF_FLOOR,
  tariffCeiling: TARIFF_CEILING,
};

const PROCUREMENT_READ = ["REQUIREMENT_VIEW", "SELECTION_VIEW", "COMMERCIAL_REQUIREMENT_VIEW"];
const PROCUREMENT_WRITE = ["GES_PROFILE_EDIT", "REQUIREMENT_EDIT", "SELECTION_CREATE", "COMMERCIAL_REQUIREMENT_CREATE"];

export const ROLE_PERMISSIONS: Record<string, string[]> = {
  ADMIN: [
    "IPP_VIEW", "IPP_CREATE", "IPP_EDIT", "GES_VIEW", "GES_CREATE", "GES_EDIT", "EVALUATION_VIEW", "EVALUATION_EDIT",
    "TECHNICAL_REVIEW", "FINANCIAL_REVIEW", "COMMERCIAL_REVIEW", "TARIFF_REVIEW", "NEGOTIATION_CREATE", "NEGOTIATION_APPROVE",
    "PSOA_VIEW", "PSOA_CREATE", "DEALBOOK_VIEW", "DEALBOOK_CREATE", "DOCUMENT_VIEW", "DOCUMENT_UPLOAD", "AUDIT_VIEW",
    ...PROCUREMENT_READ, ...PROCUREMENT_WRITE,
  ],
  NEWRA_ADMIN: [
    "IPP_VIEW", "IPP_CREATE", "IPP_EDIT", "GES_VIEW", "GES_CREATE", "GES_EDIT", "EVALUATION_VIEW", "EVALUATION_EDIT",
    "DOCUMENT_VIEW", "DOCUMENT_UPLOAD", "PSOA_VIEW", "DEALBOOK_VIEW",
    ...PROCUREMENT_READ, ...PROCUREMENT_WRITE,
  ],
  EVALUATOR: [
    "IPP_VIEW", "IPP_CREATE", "IPP_EDIT", "GES_VIEW", "GES_CREATE", "GES_EDIT", "EVALUATION_VIEW", "EVALUATION_EDIT",
    "PSOA_VIEW", "PSOA_CREATE", "DEALBOOK_VIEW", "DOCUMENT_VIEW", "DOCUMENT_UPLOAD", "AUDIT_VIEW", "NEGOTIATION_CREATE",
    ...PROCUREMENT_READ, ...PROCUREMENT_WRITE,
  ],
  COMMERCIAL_REVIEWER: [
    "IPP_VIEW", "GES_VIEW", "EVALUATION_VIEW", "COMMERCIAL_REVIEW", "TARIFF_REVIEW", "NEGOTIATION_CREATE", "NEGOTIATION_APPROVE",
    "PSOA_VIEW", "DEALBOOK_VIEW", "DOCUMENT_VIEW", ...PROCUREMENT_READ,
  ],
  TECHNICAL_REVIEWER: [
    "IPP_VIEW", "GES_VIEW", "EVALUATION_VIEW", "TECHNICAL_REVIEW", "DOCUMENT_VIEW", "DOCUMENT_UPLOAD", "PSOA_VIEW",
    "REQUIREMENT_VIEW", "SELECTION_VIEW",
  ],
  FINANCE_REVIEWER: [
    "IPP_VIEW", "GES_VIEW", "EVALUATION_VIEW", "FINANCIAL_REVIEW", "TARIFF_REVIEW", "DEALBOOK_VIEW", "DOCUMENT_VIEW", "PSOA_VIEW",
    "REQUIREMENT_VIEW", "SELECTION_VIEW",
  ],
  VIEWER: ["IPP_VIEW", "GES_VIEW", "EVALUATION_VIEW", "PSOA_VIEW", "DEALBOOK_VIEW", "DOCUMENT_VIEW", ...PROCUREMENT_READ],
  GES_ADMIN: [
    "IPP_VIEW", "GES_VIEW", "EVALUATION_VIEW", "DOCUMENT_VIEW",
    ...PROCUREMENT_READ, ...PROCUREMENT_WRITE,
  ],
  GES_USER: [
    "IPP_VIEW", "GES_VIEW", "EVALUATION_VIEW", "DOCUMENT_VIEW",
    ...PROCUREMENT_READ, ...PROCUREMENT_WRITE,
  ],
};

export const USERS = [
  { id: "usr_admin", email: "admin@newra.demo", name: "Asha Menon", title: "Platform administrator", role: "ADMIN" },
  { id: "usr_newra", email: "newra.admin@newra.demo", name: "Neha Kulkarni", title: "NewRa operations", role: "NEWRA_ADMIN" },
  { id: "usr_evaluator", email: "evaluator@newra.demo", name: "Rohan Iyer", title: "Lead evaluator", role: "EVALUATOR" },
  { id: "usr_commercial", email: "commercial@newra.demo", name: "Meera Shah", title: "Commercial reviewer", role: "COMMERCIAL_REVIEWER" },
  { id: "usr_technical", email: "technical@newra.demo", name: "Vikram Desai", title: "Technical reviewer", role: "TECHNICAL_REVIEWER" },
  { id: "usr_finance", email: "finance@newra.demo", name: "Leela Nair", title: "Finance reviewer", role: "FINANCE_REVIEWER" },
  { id: "usr_viewer", email: "viewer@newra.demo", name: "Arjun Rao", title: "Read-only reviewer", role: "VIEWER" },
  { id: "usr_ges_admin_aster", email: "ges.admin.aster@newra.demo", name: "Sanjay Kulkarni", title: "Aster Manufacturing Group", role: "GES_ADMIN", gesId: "ges_aster" },
  { id: "usr_ges_aster", email: "ges.aster@newra.demo", name: "Anil Pawar", title: "Aster Manufacturing Group", role: "GES_USER", gesId: "ges_aster" },
  { id: "usr_ges_nova", email: "ges.nova@newra.demo", name: "Hetal Shah", title: "Nova Industrial Works", role: "GES_USER", gesId: "ges_nova" },
  { id: "usr_ges_vertex", email: "ges.vertex@newra.demo", name: "Ramesh Gowda", title: "Vertex Metals & Engineering", role: "GES_USER", gesId: "ges_vertex" },
  { id: "usr_ges_helix", email: "ges.helix@newra.demo", name: "Kavitha Raman", title: "Helix Chemicals", role: "GES_USER", gesId: "ges_helix" },
];
