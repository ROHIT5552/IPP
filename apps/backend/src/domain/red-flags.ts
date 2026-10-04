export type RedFlagCategory = "TECHNICAL" | "EXECUTION" | "FINANCIAL" | "PRICING" | "REGULATORY";
export type RedFlagSeverity = "LOW" | "MEDIUM" | "HIGH" | "CRITICAL";

export interface RedFlagFinding {
  category: RedFlagCategory;
  severity: RedFlagSeverity;
  code: string;
  title: string;
  detail: string;
  contextual: boolean;
}

export interface RedFlagInput {
  solarCuf: number;
  windCuf: number;
  p50Gwh: number;
  p90Gwh: number;
  ehvScore: number;
  weakSystemStudy: boolean;
  bessMw: number;
  bessDegradation: number | null;
  hasCpm: boolean;
  connectivityAssumed: boolean;
  procurementAligned: boolean;
  epcCommitted: boolean;
  fundraisingDependency: boolean;
  debtRatio: number;
  lenderIdentified: boolean;
  financingScheduleMismatch: boolean;
  capexTotal: number;
  p90Ratio: number;
  evacuationExcluded: boolean;
  bessExcluded: boolean;
  escalationClear: boolean;
  changeInLaw: "PROTECTED" | "SHARED" | "UNLIMITED";
  complianceBearer: "IPP" | "GES" | "UNCLEAR";
  curtailment: "CLEAR" | "AMBIGUOUS";
  indemnity: "STRONG" | "WEAK";
  delayBearer: "IPP" | "GES" | "UNCLEAR";
  ges?: {
    bessRequired: boolean;
    targetCodYear: number;
    ippCodYear: number;
  };
}

export function detectRedFlags(input: RedFlagInput): RedFlagFinding[] {
  const flags: RedFlagFinding[] = [];
  const add = (flag: RedFlagFinding) => flags.push(flag);

  if (input.solarCuf > 0.3 || input.windCuf > 0.48) {
    add({ category: "TECHNICAL", severity: "HIGH", code: "HIGH_CUF", title: "High CUF", detail: "The stated capacity factor sits above a cautious resource band and needs independent support.", contextual: false });
  }
  if (input.p50Gwh <= 0 || input.p90Gwh <= 0) {
    add({ category: "TECHNICAL", severity: "CRITICAL", code: "MISSING_P50_P90", title: "Missing P50/P90", detail: "The generation case does not contain both a P50 and a P90 energy figure.", contextual: false });
  }
  if (input.ehvScore < 3.6) {
    add({ category: "TECHNICAL", severity: "HIGH", code: "WEAK_EHV", title: "Weak EHV capability", detail: "Evacuation experience is thin relative to the capacity being offered.", contextual: false });
  }
  if (input.weakSystemStudy) {
    add({ category: "TECHNICAL", severity: "MEDIUM", code: "WEAK_SYSTEM_STUDY", title: "Weak system-study methodology", detail: "System studies are desktop-level or still unstructured.", contextual: false });
  }
  if (input.bessMw > 0 && input.bessDegradation == null) {
    add({ category: "TECHNICAL", severity: "HIGH", code: "BESS_DEGRADATION_MISSING", title: "BESS degradation missing", detail: "A storage system is offered without a degradation assumption.", contextual: false });
  }
  if (!input.hasCpm) {
    add({ category: "EXECUTION", severity: "HIGH", code: "COD_WITHOUT_CPM", title: "COD without CPM", detail: "The COD date is not backed by a critical-path schedule.", contextual: false });
  }
  if (input.connectivityAssumed) {
    add({ category: "EXECUTION", severity: "HIGH", code: "CONNECTIVITY_ASSUMED", title: "Connectivity assumed", detail: "The schedule treats evacuation consent as if it were already granted.", contextual: false });
  }
  if (!input.procurementAligned) {
    add({ category: "EXECUTION", severity: "MEDIUM", code: "PROCUREMENT_MISALIGNED", title: "Procurement not aligned with COD", detail: "Long-lead procurement does not line up with the stated COD.", contextual: false });
  }
  if (!input.epcCommitted) {
    add({ category: "EXECUTION", severity: "MEDIUM", code: "WEAK_EPC", title: "Weak EPC commitment", detail: "The EPC role is indicative rather than contracted.", contextual: false });
  }
  if (input.fundraisingDependency) {
    add({ category: "FINANCIAL", severity: "HIGH", code: "FUNDRAISING_DEPENDENCY", title: "Future fundraising dependency", detail: "Equity is still dependent on a future raise.", contextual: false });
  }
  if (input.debtRatio > 0.77) {
    add({ category: "FINANCIAL", severity: "MEDIUM", code: "WEAK_EQUITY", title: "Weak equity", detail: "The debt share leaves a thin equity cushion.", contextual: false });
  }
  if (!input.lenderIdentified) {
    add({ category: "FINANCIAL", severity: "HIGH", code: "LENDER_UNIDENTIFIED", title: "Unidentified lender", detail: "No lender has been identified for the debt package.", contextual: false });
  }
  if (input.financingScheduleMismatch) {
    add({ category: "FINANCIAL", severity: "MEDIUM", code: "FINANCING_SCHEDULE_MISMATCH", title: "Financing schedule mismatch", detail: "Financial closure does not sit ahead of the procurement commitments.", contextual: false });
  }
  if (input.capexTotal <= 0) {
    add({ category: "PRICING", severity: "CRITICAL", code: "NO_CAPEX_BUILDUP", title: "No CAPEX build-up", detail: "The tariff has no supporting CAPEX build-up.", contextual: false });
  }
  if (input.p90Ratio > 0 && input.p90Ratio < 0.83) {
    add({ category: "PRICING", severity: "MEDIUM", code: "AGGRESSIVE_GENERATION", title: "Aggressive generation", detail: "P90 sits far below P50, so the tariff case is sensitive to resource downside.", contextual: false });
  }
  if (input.evacuationExcluded) {
    add({ category: "PRICING", severity: "HIGH", code: "EVACUATION_EXCLUDED", title: "Evacuation excluded", detail: "Evacuation cost is outside the quoted tariff.", contextual: false });
  }
  if (input.bessMw > 0 && input.bessExcluded) {
    add({ category: "PRICING", severity: "HIGH", code: "BESS_EXCLUDED", title: "BESS excluded", detail: "Storage is part of the offer but excluded from the tariff build-up.", contextual: false });
  }
  if (!input.escalationClear) {
    add({ category: "PRICING", severity: "MEDIUM", code: "UNCLEAR_ESCALATION", title: "Unclear tariff escalation", detail: "Escalation, indexation or reset mechanics are not stated.", contextual: false });
  }
  if (input.changeInLaw === "UNLIMITED") {
    add({ category: "REGULATORY", severity: "HIGH", code: "UNLIMITED_CHANGE_IN_LAW", title: "Unlimited Change-in-Law", detail: "Change-in-law exposure is open-ended.", contextual: false });
  }
  if (input.complianceBearer === "GES") {
    add({ category: "REGULATORY", severity: "HIGH", code: "CONSUMER_BEARS_COMPLIANCE", title: "Consumer bears generator compliance failures", detail: "Grid-compliance failure sits with the GES rather than the generator.", contextual: false });
  }
  if (input.curtailment === "AMBIGUOUS") {
    add({ category: "REGULATORY", severity: "MEDIUM", code: "AMBIGUOUS_CURTAILMENT", title: "Ambiguous curtailment", detail: "Curtailment compensation and deemed generation are not defined.", contextual: false });
  }
  if (input.indemnity === "WEAK") {
    add({ category: "REGULATORY", severity: "MEDIUM", code: "WEAK_INDEMNITY", title: "Weak indemnity", detail: "The indemnity does not cover the principal regulatory breaches.", contextual: false });
  }
  if (input.delayBearer === "UNCLEAR") {
    add({ category: "REGULATORY", severity: "MEDIUM", code: "UNCLEAR_CONNECTIVITY_DELAY", title: "Unclear connectivity delay responsibility", detail: "Responsibility for a connectivity delay is not allocated.", contextual: false });
  }

  if (input.ges?.bessRequired && input.bessMw <= 0) {
    add({ category: "TECHNICAL", severity: "HIGH", code: "BESS_REQUIRED_ABSENT", title: "BESS required by this GES", detail: "This GES preference includes storage and the IPP currently offers none.", contextual: true });
  }
  if (input.ges && input.ges.ippCodYear > input.ges.targetCodYear) {
    add({ category: "EXECUTION", severity: "MEDIUM", code: "COD_AFTER_GES_TARGET", title: "COD after GES target", detail: "The IPP COD is later than this GES target year.", contextual: true });
  }

  return flags;
}
