import { capexCredibility } from "./capex";
import { bessDurationHours, bessYearSnapshots } from "./bess";
import { analyseSchedule, MilestoneInput } from "./execution";
import { assessFinancialFeasibility } from "./finance";
import { evaluateCriticalGates } from "./gates";
import { connectivityRisk } from "./ehv";
import { calculateLoadMatch } from "./load-matching";
import { buildGenerationMw } from "./profiles";
import { detectRedFlags } from "./red-flags";
import { regulatoryProtectionScore } from "./regulatory";
import { resolveEvaluationScores, scoreEvaluation } from "./scoring";
import { calculateSuitability } from "./suitability";
import { assessTariffSustainability, buildTariff, TariffDrivers } from "./tariff";
import { EvaluationScores } from "./parameters";
import { CapexLine } from "./capex";

export interface IppCase {
  id: string;
  name: string;
  solarMw: number;
  windMw: number;
  bessMw: number;
  bessMwh: number;
  annualGenerationGwh: number;
  p50Gwh: number;
  p75Gwh: number;
  p90Gwh: number;
  quotedTariff: number;
  codYear: number;
  baseScores: EvaluationScores;
  solarCuf: number;
  windCuf: number;
  generationValidation: "VERIFIED" | "UNDER_REVIEW" | "PENDING" | "RECEIVED" | "MISSING";
  connectivityStatus: "PRELIMINARY" | "UNDER_STUDY" | "APPLICATION_SUBMITTED" | "APPROVAL_PENDING" | "APPROVED";
  capexItems: CapexLine[];
  drivers: TariffDrivers;
  lenderIdentified: boolean;
  fundraisingDependency: boolean;
  financingScheduleMismatch: boolean;
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
  changeInLaw: "PROTECTED" | "SHARED" | "UNLIMITED";
  curtailment: "CLEAR" | "AMBIGUOUS";
  indemnity: "STRONG" | "WEAK";
  complianceBearer: "IPP" | "GES" | "UNCLEAR";
  delayBearer: "IPP" | "GES" | "UNCLEAR";
  scadaIntegration: "EVIDENCED" | "PLANNED" | "NONE";
  dataQualityFactor: number;
  depthOfDischarge: number;
  roundTripEfficiency: number;
  usableEnergyMwh: number;
  milestones: MilestoneInput[];
  baseline: {
    interestRate: number;
    capexInrCr: number;
    capexCredibility: number;
    bessMw: number;
    bessMwh: number;
    solarCuf: number;
    windCuf: number;
    generationGwh: number;
  };
}

export interface GesCase {
  id: string;
  annualEnergyGwh: number;
  peakDemandMw: number;
  targetCodYear: number;
  preferredTechnologies: string[];
  bessPreference: "OPTIONAL" | "HOURS_2_TO_4" | "HOURS_4";
  bessHoursMin: number;
  loadMw: number[];
  tariffFloor: number;
  tariffCeiling: number;
  weights: {
    energyCoverage: number;
    loadMatch: number;
    technologyFit: number;
    bessFit: number;
    codFit: number;
    tariffFit: number;
    financialFit: number;
    technicalFit: number;
    connectivityFit: number;
    regulatoryFit: number;
  };
}

export function evaluatePair(ipp: IppCase, ges: GesCase) {
  const credibility = capexCredibility(ipp.capexItems);
  const scores = resolveEvaluationScores(
    ipp.baseScores,
    {
      interestRate: ipp.drivers.interestRate,
      capexInrCr: ipp.drivers.capexInrCr,
      capexCredibility: credibility.score,
      bessMw: ipp.bessMw,
      bessMwh: ipp.bessMwh,
      solarCuf: ipp.solarCuf,
      windCuf: ipp.windCuf,
      generationGwh: ipp.drivers.generationGwh,
    },
    ipp.baseline,
  );
  const scoring = scoreEvaluation(scores);
  const tariff = buildTariff(ipp.drivers);
  const finance = assessFinancialFeasibility(ipp.drivers, ipp.quotedTariff, {
    lenderIdentified: ipp.lenderIdentified,
    fundraisingDependency: ipp.fundraisingDependency,
  });
  const sustainability = assessTariffSustainability({
    quotedTariff: ipp.quotedTariff,
    calculatedTariff: tariff.calculatedTariff,
    dscr: finance.dscr,
    p50Gwh: ipp.p50Gwh,
    p90Gwh: ipp.p90Gwh,
    budgetaryShare: credibility.budgetaryShare,
    bessMw: ipp.bessMw,
    bessExcluded: ipp.bessExcluded,
    evacuationExcluded: ipp.evacuationExcluded,
    escalationClear: ipp.escalationClear,
    solarCuf: ipp.solarCuf,
    windCuf: ipp.windCuf,
  });
  const generationMw = buildGenerationMw({
    solarMw: ipp.solarMw,
    windMw: ipp.windMw,
    annualGenerationGwh: ipp.drivers.generationGwh,
  });
  const loadMatch = calculateLoadMatch({
    loadMw: ges.loadMw,
    generationMw,
    bessMw: ipp.bessMw,
    bessMwh: ipp.bessMwh,
    roundTripEfficiency: ipp.roundTripEfficiency,
    depthOfDischarge: ipp.depthOfDischarge,
    requiredAnnualGwh: ges.annualEnergyGwh,
  });
  const durationHours = bessDurationHours(ipp.bessMw, ipp.bessMwh);
  const bessRequired = ges.bessPreference !== "OPTIONAL";
  const regulatoryScore = regulatoryProtectionScore({
    changeInLaw: ipp.changeInLaw,
    curtailment: ipp.curtailment,
    indemnity: ipp.indemnity,
    complianceBearer: ipp.complianceBearer,
    delayBearer: ipp.delayBearer,
    evaluationScore: scores.regulatory,
  });
  const gates = evaluateCriticalGates({
    financialScore: scores.financial,
    dscr: finance.dscr,
    lenderIdentified: ipp.lenderIdentified,
    fundraisingDependency: ipp.fundraisingDependency,
    debtRatio: ipp.drivers.debtRatio,
    executionScore: scores.execution,
    epcCommitted: ipp.epcCommitted,
    ehvScore: scores.ehv,
    connectivityStatus: ipp.connectivityStatus,
    capexCredibility: credibility.score,
    budgetaryShare: credibility.budgetaryShare,
    sustainability,
    hasCpm: ipp.hasCpm,
    connectivityAssumed: ipp.connectivityAssumed,
    procurementAligned: ipp.procurementAligned,
    projectBufferMonths: ipp.projectBufferMonths,
    ippCodYear: ipp.codYear,
    gesCodYear: ges.targetCodYear,
    p50Gwh: ipp.p50Gwh,
    p90Gwh: ipp.p90Gwh,
    generationValidation: ipp.generationValidation,
    fdreScore: scores.fdre,
    loadMatchPct: loadMatch.loadMatchPct,
    bessRequired,
    bessMw: ipp.bessMw,
    bessHoursMin: ges.bessHoursMin,
    durationHours,
    regulatoryScore: scores.regulatory,
    changeInLaw: ipp.changeInLaw,
    curtailment: ipp.curtailment,
    indemnity: ipp.indemnity,
    complianceBearer: ipp.complianceBearer,
    scadaIntegration: ipp.scadaIntegration,
  });
  const failedGate = gates.some((gate) => gate.status === "FAIL");
  const conditionalGate = gates.some((gate) => gate.status === "CONDITIONAL");
  const suitability = calculateSuitability({
    annualRequiredGwh: ges.annualEnergyGwh,
    availableGwh: loadMatch.availableGwh,
    loadMatchPct: loadMatch.loadMatchPct,
    preferredTechnologies: ges.preferredTechnologies,
    bessPreference: ges.bessPreference,
    peakDemandMw: ges.peakDemandMw,
    targetCodYear: ges.targetCodYear,
    solarMw: ipp.solarMw,
    windMw: ipp.windMw,
    bessMw: ipp.bessMw,
    bessMwh: ipp.bessMwh,
    ippCodYear: ipp.codYear,
    quotedTariff: ipp.quotedTariff,
    tariffFloor: ges.tariffFloor,
    tariffCeiling: ges.tariffCeiling,
    financialScore: scores.financial,
    dscr: finance.dscr,
    lenderIdentified: ipp.lenderIdentified,
    engineeringScore: scores.engineering,
    dataQualityFactor: ipp.dataQualityFactor,
    connectivityStatus: ipp.connectivityStatus,
    ehvScore: scores.ehv,
    regulatory: {
      changeInLaw: ipp.changeInLaw,
      curtailment: ipp.curtailment,
      indemnity: ipp.indemnity,
      complianceBearer: ipp.complianceBearer,
      delayBearer: ipp.delayBearer,
      evaluationScore: scores.regulatory,
    },
    weights: ges.weights,
    failedGate,
    conditionalGate,
  });
  const redFlags = detectRedFlags({
    solarCuf: ipp.solarCuf,
    windCuf: ipp.windCuf,
    p50Gwh: ipp.p50Gwh,
    p90Gwh: ipp.p90Gwh,
    ehvScore: scores.ehv,
    weakSystemStudy: ipp.weakSystemStudy,
    bessMw: ipp.bessMw,
    bessDegradation: ipp.bessDegradation,
    hasCpm: ipp.hasCpm,
    connectivityAssumed: ipp.connectivityAssumed,
    procurementAligned: ipp.procurementAligned,
    epcCommitted: ipp.epcCommitted,
    fundraisingDependency: ipp.fundraisingDependency,
    debtRatio: ipp.drivers.debtRatio,
    lenderIdentified: ipp.lenderIdentified,
    financingScheduleMismatch: ipp.financingScheduleMismatch,
    capexTotal: credibility.total,
    p90Ratio: ipp.p50Gwh > 0 ? ipp.p90Gwh / ipp.p50Gwh : 0,
    evacuationExcluded: ipp.evacuationExcluded,
    bessExcluded: ipp.bessExcluded,
    escalationClear: ipp.escalationClear,
    changeInLaw: ipp.changeInLaw,
    complianceBearer: ipp.complianceBearer,
    curtailment: ipp.curtailment,
    indemnity: ipp.indemnity,
    delayBearer: ipp.delayBearer,
    ges: {
      bessRequired,
      targetCodYear: ges.targetCodYear,
      ippCodYear: ipp.codYear,
    },
  });
  const schedule = analyseSchedule(ipp.milestones);
  return {
    scores,
    scoring,
    tariff,
    finance,
    sustainability,
    loadMatch,
    durationHours,
    regulatoryScore,
    gates,
    failedGate,
    conditionalGate,
    suitability,
    redFlags,
    schedule,
    credibility,
    connectivityRisk: connectivityRisk(ipp.connectivityStatus),
    bessSnapshots: bessYearSnapshots(ipp.usableEnergyMwh, ipp.bessDegradation),
    generationMw,
  };
}
