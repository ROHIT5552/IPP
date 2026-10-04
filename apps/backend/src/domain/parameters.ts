export const EVALUATION_PARAMETERS = [
  { key: "execution", name: "IPP Execution Track Record", short: "Execution", weight: 10 },
  { key: "financial", name: "Financial Strength & Funding Capability", short: "Financial", weight: 10 },
  { key: "ehv", name: "EHV Connectivity & Evacuation Execution Capability", short: "EHV", weight: 10 },
  { key: "engineering", name: "Technical Engineering Capability", short: "Engineering", weight: 10 },
  { key: "fdre", name: "FDRE / 15-Minute Load Matching Capability", short: "FDRE", weight: 10 },
  { key: "epc", name: "EPC & Procurement Capability", short: "EPC", weight: 10 },
  { key: "cod", name: "Project Execution & COD Certainty", short: "COD", weight: 15 },
  { key: "capex", name: "CAPEX Model Credibility", short: "CAPEX", weight: 10 },
  { key: "tariff", name: "PPA Pricing Sustainability", short: "Tariff", weight: 10 },
  { key: "regulatory", name: "Regulatory & Contractual Protection", short: "Regulatory", weight: 5 },
] as const;

export type EvaluationParameterKey = (typeof EVALUATION_PARAMETERS)[number]["key"];

export type EvaluationScores = Record<EvaluationParameterKey, number>;

export const SUITABILITY_DIMENSIONS = [
  { key: "energyCoverage", label: "Energy Coverage" },
  { key: "loadMatch", label: "Load Matching" },
  { key: "technologyFit", label: "Technology Fit" },
  { key: "bessFit", label: "BESS Fit" },
  { key: "codFit", label: "COD Fit" },
  { key: "tariffFit", label: "Tariff Fit" },
  { key: "financialFit", label: "Financial Feasibility" },
  { key: "technicalFit", label: "Technical Feasibility" },
  { key: "connectivityFit", label: "Connectivity Fit" },
  { key: "regulatoryFit", label: "Regulatory Fit" },
] as const;

export type SuitabilityDimensionKey = (typeof SUITABILITY_DIMENSIONS)[number]["key"];

export type SuitabilityWeights = Record<SuitabilityDimensionKey, number>;

export const DEFAULT_SUITABILITY_WEIGHTS: SuitabilityWeights = {
  energyCoverage: 14,
  loadMatch: 16,
  technologyFit: 10,
  bessFit: 12,
  codFit: 8,
  tariffFit: 8,
  financialFit: 10,
  technicalFit: 10,
  connectivityFit: 7,
  regulatoryFit: 5,
};

export const CRITICAL_GATES = [
  { key: "financial_capacity", name: "Financial Capacity", description: "Balance sheet, equity and lender evidence can support the project." },
  { key: "execution_capability", name: "Execution Capability", description: "Track record and EPC commitment support delivery." },
  { key: "ehv_connectivity", name: "EHV Connectivity", description: "Evacuation experience is evidenced. Project connectivity is not assumed." },
  { key: "credible_capex", name: "Credible CAPEX", description: "The cost build-up is supported by firm or quoted evidence." },
  { key: "sustainable_tariff", name: "Sustainable PPA Tariff", description: "The quoted tariff can carry CAPEX, financing, operations and risk." },
  { key: "realistic_cod", name: "Realistic COD", description: "The schedule has a critical path, buffer and aligned procurement." },
  { key: "generation_methodology", name: "Generation Methodology", description: "P50 and P90 exist and the resource case is independently reviewed." },
  { key: "fdre_load_matching", name: "FDRE / Load Matching", description: "The generation shape, with BESS where required, can follow the GES load." },
  { key: "regulatory_protection", name: "Regulatory Protection", description: "Change in law, curtailment and compliance risk are allocated." },
  { key: "newra_scada", name: "NewRa SCADA / Scheduling Integration", description: "Scheduling and SCADA integration with NewRa is evidenced." },
] as const;

export type GateKey = (typeof CRITICAL_GATES)[number]["key"];

export const INTERVAL_LABELS: string[] = Array.from({ length: 96 }, (_, index) => {
  const hour = Math.floor(index / 4);
  const minute = (index % 4) * 15;
  return `${String(hour).padStart(2, "0")}:${String(minute).padStart(2, "0")}`;
});
