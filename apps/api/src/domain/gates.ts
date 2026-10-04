import { CRITICAL_GATES, GateKey } from "./parameters";
import { ConnectivityStatus } from "./ehv";
import { SustainabilityRating } from "./tariff";

export type GateResultStatus = "PASS" | "CONDITIONAL" | "FAIL";

export interface GateEvaluationInput {
  financialScore: number;
  dscr: number;
  lenderIdentified: boolean;
  fundraisingDependency: boolean;
  debtRatio: number;
  executionScore: number;
  epcCommitted: boolean;
  ehvScore: number;
  connectivityStatus: ConnectivityStatus;
  capexCredibility: number;
  budgetaryShare: number;
  sustainability: SustainabilityRating;
  hasCpm: boolean;
  connectivityAssumed: boolean;
  procurementAligned: boolean;
  projectBufferMonths: number;
  ippCodYear: number;
  gesCodYear: number;
  p50Gwh: number;
  p90Gwh: number;
  generationValidation: "VERIFIED" | "UNDER_REVIEW" | "PENDING" | "RECEIVED" | "MISSING";
  fdreScore: number;
  loadMatchPct: number;
  bessRequired: boolean;
  bessMw: number;
  bessHoursMin: number;
  durationHours: number;
  regulatoryScore: number;
  changeInLaw: "PROTECTED" | "SHARED" | "UNLIMITED";
  curtailment: "CLEAR" | "AMBIGUOUS";
  indemnity: "STRONG" | "WEAK";
  complianceBearer: "IPP" | "GES" | "UNCLEAR";
  scadaIntegration: "EVIDENCED" | "PLANNED" | "NONE";
}

export interface GateFinding {
  key: GateKey;
  name: string;
  description: string;
  status: GateResultStatus;
  rationale: string;
  evidence: string;
}

function pick(conditionFail: boolean, conditionWatch: boolean, pass: string, watch: string, fail: string): {
  status: GateResultStatus;
  rationale: string;
} {
  if (conditionFail) return { status: "FAIL", rationale: fail };
  if (conditionWatch) return { status: "CONDITIONAL", rationale: watch };
  return { status: "PASS", rationale: pass };
}

export function evaluateCriticalGates(input: GateEvaluationInput): GateFinding[] {
  const findings: Record<GateKey, { status: GateResultStatus; rationale: string; evidence: string }> = {
    financial_capacity: {
      ...pick(
        input.financialScore < 3.4 || input.dscr < 1.1 || (!input.lenderIdentified && input.fundraisingDependency && input.debtRatio > 0.75),
        input.financialScore < 4 || input.dscr < 1.3 || !input.lenderIdentified || input.fundraisingDependency,
        "Financial capacity clears the gate for this requirement.",
        "Financing is workable only with conditions on lender, DSCR or fundraising.",
        "Financial capacity does not support the quoted structure.",
      ),
      evidence: `DSCR ${input.dscr.toFixed(2)} · lender ${input.lenderIdentified ? "identified" : "not identified"}`,
    },
    execution_capability: {
      ...pick(
        input.executionScore < 3.2,
        input.executionScore < 4.2 || !input.epcCommitted,
        "Execution track record and EPC commitment are adequate.",
        "Execution needs a firmer EPC commitment or a stronger delivery record.",
        "Execution capability is below the minimum gate.",
      ),
      evidence: `Execution score ${input.executionScore.toFixed(1)} / 5`,
    },
    ehv_connectivity: {
      ...pick(
        input.ehvScore < 3.2,
        input.connectivityStatus !== "APPROVED" || input.ehvScore < 4.3,
        "Project connectivity is approved and the capability evidence holds.",
        "Evacuation capability is evidenced, but this project's connectivity is not confirmed.",
        "EHV capability is too weak to carry the evacuation case.",
      ),
      evidence: input.connectivityStatus.replaceAll("_", " "),
    },
    credible_capex: {
      ...pick(
        input.capexCredibility < 2.8 || input.budgetaryShare > 0.65,
        input.capexCredibility < 4 || input.budgetaryShare > 0.28,
        "CAPEX build-up is sufficiently firm.",
        "A material share of CAPEX is still indicative or budgetary.",
        "CAPEX evidence is not credible enough to clear the gate.",
      ),
      evidence: `Credibility ${input.capexCredibility.toFixed(2)} / 5`,
    },
    sustainable_tariff: {
      ...pick(
        input.sustainability === "UNSUSTAINABLE",
        input.sustainability === "AGGRESSIVE",
        "The tariff build-up is sustainable on the current assumptions.",
        "The tariff is aggressive once CAPEX, generation or financing assumptions are stressed.",
        "The quoted tariff does not sustain the cost, financing and risk stack.",
      ),
      evidence: input.sustainability,
    },
    realistic_cod: {
      ...pick(
        !input.hasCpm,
        input.connectivityAssumed || !input.procurementAligned || input.projectBufferMonths < 3 || (input.gesCodYear > 0 && input.ippCodYear > input.gesCodYear),
        "COD is supported by a schedule, buffer and aligned procurement.",
        "COD still depends on connectivity, procurement, buffer or the GES target year.",
        "COD is stated without a critical-path schedule.",
      ),
      evidence: input.hasCpm ? "Critical path present" : "Critical path missing",
    },
    generation_methodology: {
      ...pick(
        input.p50Gwh <= 0 || input.p90Gwh <= 0,
        input.generationValidation !== "VERIFIED" || (input.p50Gwh > 0 && input.p90Gwh / input.p50Gwh < 0.82),
        "P50 and P90 are present and independently verified.",
        "Generation evidence is incomplete or the P90 case is still under review.",
        "P50 or P90 is missing.",
      ),
      evidence: input.generationValidation.replaceAll("_", " "),
    },
    fdre_load_matching: {
      ...pick(
        input.loadMatchPct < 40 || (input.bessRequired && input.bessMw <= 0 && input.loadMatchPct < 65),
        input.fdreScore < 3.6 || input.loadMatchPct < 78 || (input.bessRequired && input.durationHours + 0.15 < input.bessHoursMin),
        "Fifteen-minute matching clears the GES load shape.",
        "Load matching is only partial for this GES shape or BESS duration.",
        "The profile cannot follow this GES load without a failed energy gap.",
      ),
      evidence: `Load match ${input.loadMatchPct.toFixed(1)}%`,
    },
    regulatory_protection: {
      ...pick(
        input.regulatoryScore < 3.4 || (input.changeInLaw === "UNLIMITED" && input.indemnity === "WEAK"),
        input.regulatoryScore < 4.2 || input.curtailment === "AMBIGUOUS" || input.complianceBearer === "GES" || input.indemnity === "WEAK",
        "Regulatory protections are allocated with a clear indemnity.",
        "One or more regulatory protections remain ambiguous.",
        "Regulatory protection fails the gate.",
      ),
      evidence: `Change in law ${input.changeInLaw.toLowerCase()}`,
    },
    newra_scada: {
      ...pick(
        false,
        input.scadaIntegration !== "EVIDENCED",
        "NewRa SCADA and scheduling integration is evidenced.",
        "NewRa SCADA integration is planned or not yet evidenced.",
        "NewRa SCADA integration is absent.",
      ),
      evidence: input.scadaIntegration,
    },
  };

  return CRITICAL_GATES.map((gate) => ({
    key: gate.key,
    name: gate.name,
    description: gate.description,
    status: findings[gate.key].status,
    rationale: findings[gate.key].rationale,
    evidence: findings[gate.key].evidence,
  }));
}
