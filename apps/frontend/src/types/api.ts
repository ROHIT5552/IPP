export type Role =
  | 'ADMIN'
  | 'NEWRA_ADMIN'
  | 'EVALUATOR'
  | 'COMMERCIAL_REVIEWER'
  | 'TECHNICAL_REVIEWER'
  | 'FINANCE_REVIEWER'
  | 'VIEWER'
  | 'GES_ADMIN'
  | 'GES_USER';

export interface AuthUser {
  id: string;
  email: string;
  name: string;
  title?: string;
  role: Role;
  roles?: Role[];
  permissions: string[];
  gesId?: string | null;
}

export interface GesRequirement {
  annualEnergyGwh: number;
  peakDemandMw: number;
  requiredCapacityGw: number;
  targetCodYear: number;
  preferredTechnologies: string[];
  bessPreference: 'OPTIONAL' | 'HOURS_2_TO_4' | 'HOURS_4';
  bessHoursMin: number | null;
  bessHoursMax: number | null;
  renewableTargetPercent?: number | null;
  requiredRenewableGwh?: number | null;
  targetTariffInrPerKwh?: number | null;
  contractTenureYears?: number | null;
  commercialNotes?: string;
  notes?: string;
}

export interface GesAccount {
  id: string;
  code: string;
  name: string;
  legalName?: string;
  location: string;
  city?: string;
  state?: string;
  discom?: string;
  consumerNumbers?: string;
  businessType: string;
  contractDemandMw?: number;
  billedDemandMw?: number;
  existingRooftopMw?: number;
  existingRenewableGwh?: number;
  annualConsumptionGwh?: number;
  renewableEnergyTargetPercent?: number | null;
  sanctionedLoadKw?: number | null;
  solarConnectionType?: string | null;
  peakRecordedDemandKva?: number | null;
  bessRequirement?: string | null;
  notes?: string;
  stage: string;
  requirement: GesRequirement;
  candidateCount?: number;
  averageSuitability?: number;
  ipps?: GesIppUsage[];
}

export interface GesIppUsage {
  id: string;
  name: string;
  technology: string;
  availableGwh: number;
  matchedGwh: number;
  usedPct: number;
  coveragePct: number;
  tariff: number;
  solarMw: number;
  windMw: number;
  bessMw: number;
}

export interface IppCatalogRow {
  id: string;
  code: string;
  name: string;
  projectName: string;
  headquarters: string;
  projectState: string;
  projectDistrict: string | null;
  projectLocation: string | null;
  technology: string;
  solarMw: number;
  windMw: number;
  bessMw: number;
  bessMwh: number;
  annualGenerationGwh: number;
  p90Gwh: number | null;
  generationData15Min: string | null;
  fdreCapability: string | null;
  gridVoltage: string | null;
  gridConnectivity: string | null;
  engineConnectivity: string | null;
  openAccessReadiness: string | null;
  tariff: number;
  tariffType: string | null;
  contractTenureYears: number | null;
  projectStatus: string;
  codYear: number | null;
  codConfidence: string | null;
  financialModelAvailable: string | null;
  fundingStatus: string | null;
  estimatedCapexCr: number | null;
  gesCount: number;
  gesNames: string[];
  selectedByCurrentGes?: boolean;
  usedGwh: number;
  usedPct: number;
}

export interface ProviderOption {
  id: string;
  name: string;
  code: string;
  technology: string[];
  suitability: number;
}

export interface LoadInterval {
  time: string;
  loadMw: number;
  generationMw: number;
  matchedMw: number;
  bessSupportMw: number;
}

export interface EvaluationParameter {
  key: string;
  label: string;
  shortLabel: string;
  score: number;
  normalizedScore: number;
  weight: number;
  weightedContribution: number;
  evidence: string;
  status: string;
  reviewer: string;
}

export interface ComparisonProvider {
  ipp: {
    id: string;
    code: string;
    name: string;
    technology: string[];
    solarMw: number;
    windMw: number;
    bessMw: number;
    bessMwh: number;
    annualGenerationGwh: number;
    p90Gwh: number;
    tariff: number;
    targetCodYear: number;
    shortlisted?: boolean;
    register?: {
      projectName?: string;
      fdreCapability?: string | null;
      generationData15Min?: string | null;
      gridVoltage?: string | null;
      gridConnectivity?: string | null;
      openAccessReadiness?: string | null;
      estimatedCapexCr?: number | null;
      financialModelAvailable?: string | null;
      fundingStatus?: string | null;
    };
    scores: Record<string, number>;
    capexInrCr: number;
    interestRate: number;
    dscr: number;
    bessDurationHours: number;
    technologyDetails: Record<string, string | number | boolean>;
  };
  evaluation: { overallScore: number; parameters: EvaluationParameter[] };
  suitability: {
    overallPct: number;
    status: string;
    dimensions: {
      key: string;
      label: string;
      weight: number;
      score: number;
      weightedContribution: number;
    }[];
  };
  loadMatch: {
    requiredGwh: number;
    availableGwh: number;
    matchedGwh: number;
    surplusGwh: number;
    deficitGwh: number;
    loadMatchPct: number;
    coveragePct: number;
    intervals: LoadInterval[];
  };
  tariff: {
    baseTariff: number;
    scenarioTariff: number;
    change: number;
    changePct: number;
    sustainability: string;
    tariffScore: number;
    baseDscr: number;
    scenarioDscr: number;
    buildUp: { label: string; amount: number }[];
  };
  financial: {
    score: number;
    interestRatePct: number;
    debtEquityRatio: number;
    dscr: number;
    equitySharePct: number;
    projectIrrPct: number;
    equityIrrPct: number;
    lender: string;
    fundraisingDependency: boolean;
  };
  gates: { name: string; status: string; rationale: string; blocking?: boolean }[];
  requirementComparison?: {
    key: string;
    name: string;
    term: string | null;
    weight: number;
    score: number;
    contribution: number;
    gesValue: string;
    ippValue: string;
    status: string;
    evidence: string;
  }[];
  shortlistEligibility?: {
    status: 'ELIGIBLE' | 'NOT_ELIGIBLE' | 'PENDING_REVIEW';
    blockingIssues: number;
    pendingChecks: number;
    passed: number;
  };
  redFlags: { category: string; severity: string; title: string; detail: string }[];
  technologyDetails: Record<string, unknown>;
  documents: {
    id: string;
    title: string;
    category: string;
    status: string;
    version: number;
    owner: string;
    pendingFrom: string;
    comments: string;
  }[];
  tasks: {
    id: string;
    title: string;
    owner: string;
    pendingFrom: string;
    priority: string;
    status: string;
    dueDate: string;
  }[];
}

export interface ComparisonResponse {
  ges: GesAccount;
  requirements: GesRequirement;
  providerOptions: ProviderOption[];
  selectedIpps: ComparisonProvider[];
  radarData: Record<string, string | number>[];
  technologyMix: {
    id: string;
    name: string;
    code: string;
    solarMw: number;
    windMw: number;
    bessMw: number;
  }[];
  comparisonTable: {
    id: string;
    name: string;
    code: string;
    technology: string;
    capacityMw: number;
    annualGenerationGwh: number;
    p90Gwh: number;
    bessMw: number;
    bessMwh: number;
    tariff: number;
    capexInrCr: number;
    targetCodYear: number;
    evaluationScore: number;
    suitability: number;
    loadMatchPct: number;
    coveragePct: number;
    criticalGate: string;
    shortlisted?: boolean;
    riskCount: number;
    financialScore: number;
  }[];
  summary: {
    averageSuitability: number;
    bestSuitability: number;
    bestProviderId: string;
    bestProviderName: string;
  };
}

export interface DashboardResponse {
  totals: {
    gesAccounts: number;
    ippCandidates: number;
    activeEvaluations: number;
    shortlisted: number;
    pendingReviews: number;
    pendingActions?: number;
    criticalRisks: number;
  };
  ges: GesAccount[];
  selectedGes: GesAccount;
  keyMetrics: {
    averageSuitability: number;
    bestSuitability: number;
    candidateCount: number;
    targetCodYear: number;
  };
  recentTasks: {
    id: string;
    title: string;
    owner: string;
    status: string;
    dueDate: string;
    priority: string;
  }[];
  recentDocuments: { id: string; title: string; status: string; updatedAt: string }[];
}

export interface OfferRecord {
  id: string;
  ippId: string;
  version: number;
  offerType: string;
  tariff: number;
  codYear: number;
  status: string;
  createdBy: string;
  createdAt: string;
  paymentTerms: string;
  otherTerms: string;
}

export interface PsoaRecord {
  ippId: string;
  ippName: string;
  status: string;
  items: { name: string; status: string }[];
}
