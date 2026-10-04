import { readFileSync, readdirSync, statSync } from "fs";
import { join } from "path";
import { capexCredibility } from "../src/domain/capex";
import { evaluateCriticalGates } from "../src/domain/gates";
import { calculateLoadMatch } from "../src/domain/load-matching";
import { detectRedFlags } from "../src/domain/red-flags";
import { DEFAULT_SUITABILITY_WEIGHTS, EVALUATION_PARAMETERS } from "../src/domain/parameters";
import { normalizedScore, resolveEvaluationScores, scoreEvaluation, weightedContribution } from "../src/domain/scoring";
import { calculateSuitability, statusFromSuitability } from "../src/domain/suitability";
import { assessFinancialFeasibility } from "../src/domain/finance";
import { applyTariffScenario, buildTariff, compareTariffScenario } from "../src/domain/tariff";
import { buildIppCases, GES_SEED } from "../src/demo/catalog";
import { buildLoadIntervals } from "../src/domain/profiles";
import { evaluatePair } from "../src/domain/evaluate";

const baseDrivers = {
  capexInrCr: 8000,
  bessCapexInrCr: 1200,
  debtRatio: 0.7,
  interestRate: 0.086,
  loanTenureYears: 18,
  moratoriumYears: 0,
  equityIrr: 0.135,
  generationGwh: 3600,
  projectLifeYears: 25,
  opex: {
    om: 0.32,
    insurance: 0.07,
    land: 0.09,
    evacuation: 0.14,
    bess: 0.11,
    replacement: 0.06,
    augmentation: 0.05,
    degradation: 0.08,
    development: 0.06,
    regulatory: 0.05,
    contingency: 0.07,
  },
};

describe("IPP scoring", () => {
  it("uses the stated weight and the 1-5 contribution formula", () => {
    expect(EVALUATION_PARAMETERS.reduce((total, item) => total + item.weight, 0)).toBe(100);
    expect(weightedContribution(15, 4)).toBe(12);
    expect(weightedContribution(10, 4.6)).toBe(9.2);
    expect(normalizedScore(4.5)).toBe(90);
    const scores = {
      execution: 4.6,
      financial: 4.5,
      ehv: 4.4,
      engineering: 4.6,
      fdre: 4.7,
      epc: 4.5,
      cod: 4.5,
      capex: 4.1,
      tariff: 4.3,
      regulatory: 4.2,
    };
    const result = scoreEvaluation(scores);
    expect(result.parameters.find((item) => item.key === "execution")?.weightedContribution).toBe(9.2);
    expect(result.overallScore).toBeCloseTo(
      result.parameters.reduce((total, item) => total + item.weightedContribution, 0),
      2,
    );
  });

  it("moves the financial score when the interest rate moves off the baseline", () => {
    const base = {
      execution: 4.5, financial: 4.5, ehv: 4.5, engineering: 4.5, fdre: 4.5, epc: 4.5, cod: 4.5, capex: 4.5, tariff: 4.5, regulatory: 4.5,
    };
    const signals = {
      interestRate: 0.086, capexInrCr: 1000, capexCredibility: 4, bessMw: 100, bessMwh: 400, solarCuf: 0.22, windCuf: 0.3, generationGwh: 1000,
    };
    const same = resolveEvaluationScores(base, signals, signals);
    expect(same.financial).toBe(4.5);
    const stressed = resolveEvaluationScores(base, { ...signals, interestRate: 0.096 }, signals);
    expect(stressed.financial).toBeLessThan(4.5);
  });
});

describe("tariff and financial feasibility", () => {
  it("increases the calculated tariff when CAPEX increases by 5 percent", () => {
    const compared = compareTariffScenario(baseDrivers, { capexChangePct: 5 });
    expect(compared.scenarioTariff).toBeGreaterThan(compared.baseTariff);
    expect(compared.changePct).toBeGreaterThan(0);
  });

  it("reduces DSCR when the interest rate increases by one percentage point", () => {
    const base = assessFinancialFeasibility(baseDrivers, 3.85, { lenderIdentified: true, fundraisingDependency: false });
    const stressedDrivers = applyTariffScenario(baseDrivers, { interestChangePctPoints: 1 });
    const stressed = assessFinancialFeasibility(stressedDrivers, 3.85, { lenderIdentified: true, fundraisingDependency: false });
    expect(stressed.dscr).toBeLessThan(base.dscr);
    expect(buildTariff(stressedDrivers).calculatedTariff).toBeGreaterThan(buildTariff(baseDrivers).calculatedTariff);
  });
});

describe("load matching and suitability", () => {
  it("matches only the overlapping part of load and generation", () => {
    const load = Array.from({ length: 96 }, () => 100);
    const generation = Array.from({ length: 96 }, (_, index) => (index < 48 ? 0 : 80));
    const result = calculateLoadMatch({
      loadMw: load,
      generationMw: generation,
      bessMw: 0,
      bessMwh: 0,
      roundTripEfficiency: 0.9,
      depthOfDischarge: 0.9,
      requiredAnnualGwh: 100,
    });
    expect(result.matchedGwh).toBeGreaterThan(0);
    expect(result.deficitGwh).toBeGreaterThan(0);
    expect(result.series[0].bessMw).toBe(0);
    expect(result.series.every((point) => point.matchedMw <= point.loadMw + 0.01)).toBe(true);
  });

  it("lowers BESS fit when storage is required and absent", () => {
    const shared = {
      annualRequiredGwh: 4000,
      availableGwh: 4000,
      loadMatchPct: 80,
      preferredTechnologies: ["SOLAR", "WIND", "BESS"],
      peakDemandMw: 600,
      targetCodYear: 2030,
      solarMw: 2000,
      windMw: 0,
      bessMwh: 0,
      ippCodYear: 2030,
      quotedTariff: 3.5,
      tariffFloor: 3.2,
      tariffCeiling: 4.6,
      financialScore: 4,
      dscr: 1.4,
      lenderIdentified: true,
      engineeringScore: 4,
      dataQualityFactor: 1,
      connectivityStatus: "UNDER_STUDY" as const,
      ehvScore: 4,
      regulatory: {
        changeInLaw: "PROTECTED" as const,
        curtailment: "CLEAR" as const,
        indemnity: "STRONG" as const,
        complianceBearer: "IPP" as const,
        delayBearer: "IPP" as const,
        evaluationScore: 4,
      },
      weights: DEFAULT_SUITABILITY_WEIGHTS,
      failedGate: false,
      conditionalGate: true,
    };
    const required = calculateSuitability({ ...shared, bessPreference: "HOURS_4", bessMw: 0 });
    const optional = calculateSuitability({ ...shared, bessPreference: "OPTIONAL", bessMw: 0, preferredTechnologies: ["SOLAR", "WIND"] });
    const withStorage = calculateSuitability({ ...shared, bessPreference: "HOURS_4", bessMw: 250, bessMwh: 1000 });
    expect(required.dimensions.find((item) => item.key === "bessFit")!.score).toBeLessThan(
      optional.dimensions.find((item) => item.key === "bessFit")!.score,
    );
    expect(withStorage.dimensions.find((item) => item.key === "bessFit")!.score).toBeGreaterThan(
      required.dimensions.find((item) => item.key === "bessFit")!.score,
    );
  });

  it("does not let a high suitability percentage override a failed gate", () => {
    expect(statusFromSuitability(94, true, false)).toBe("GATE_FAILED");
    expect(statusFromSuitability(94, false, true)).toBe("HIGHLY_SUITABLE");
  });
});

describe("critical gates and red flags", () => {
  const gateInput = {
    financialScore: 4.5,
    dscr: 1.4,
    lenderIdentified: true,
    fundraisingDependency: false,
    debtRatio: 0.7,
    executionScore: 4.5,
    epcCommitted: true,
    ehvScore: 4.5,
    connectivityStatus: "APPROVED" as const,
    capexCredibility: 4.4,
    budgetaryShare: 0.1,
    sustainability: "SUSTAINABLE" as const,
    hasCpm: true,
    connectivityAssumed: false,
    procurementAligned: true,
    projectBufferMonths: 4,
    ippCodYear: 2029,
    gesCodYear: 2030,
    p50Gwh: 100,
    p90Gwh: 90,
    generationValidation: "VERIFIED" as const,
    fdreScore: 4.5,
    loadMatchPct: 90,
    bessRequired: false,
    bessMw: 10,
    bessHoursMin: 0,
    durationHours: 4,
    regulatoryScore: 4.5,
    changeInLaw: "PROTECTED" as const,
    curtailment: "CLEAR" as const,
    indemnity: "STRONG" as const,
    complianceBearer: "IPP" as const,
    scadaIntegration: "EVIDENCED" as const,
  };

  it("fails the tariff gate when the tariff is unsustainable", () => {
    const gates = evaluateCriticalGates({ ...gateInput, sustainability: "UNSUSTAINABLE" });
    expect(gates.find((gate) => gate.key === "sustainable_tariff")?.status).toBe("FAIL");
  });

  it("detects an excluded evacuation cost and a missing critical path", () => {
    const flags = detectRedFlags({
      solarCuf: 0.2,
      windCuf: 0,
      p50Gwh: 100,
      p90Gwh: 90,
      ehvScore: 4,
      weakSystemStudy: false,
      bessMw: 0,
      bessDegradation: null,
      hasCpm: false,
      connectivityAssumed: true,
      procurementAligned: false,
      epcCommitted: false,
      fundraisingDependency: true,
      debtRatio: 0.8,
      lenderIdentified: false,
      financingScheduleMismatch: true,
      capexTotal: 10,
      p90Ratio: 0.9,
      evacuationExcluded: true,
      bessExcluded: false,
      escalationClear: false,
      changeInLaw: "UNLIMITED",
      complianceBearer: "GES",
      curtailment: "AMBIGUOUS",
      indemnity: "WEAK",
      delayBearer: "UNCLEAR",
    });
    const codes = flags.map((flag) => flag.code);
    expect(codes).toEqual(expect.arrayContaining(["COD_WITHOUT_CPM", "EVACUATION_EXCLUDED", "UNLIMITED_CHANGE_IN_LAW", "LENDER_UNIDENTIFIED"]));
  });
});

describe("demo catalogue", () => {
  it("contains four GES accounts and ten distinct IPPs", () => {
    expect(GES_SEED).toHaveLength(4);
    expect(GES_SEED.map((ges) => ges.name)).toEqual([
      "Aster Manufacturing Group",
      "Nova Industrial Works",
      "Vertex Metals & Engineering",
      "Helix Chemicals",
    ]);
    const ipps = buildIppCases();
    expect(ipps).toHaveLength(10);
    expect(new Set(ipps.map((ipp) => ipp.quotedTariff)).size).toBe(10);
    const nova = ipps.find((ipp) => ipp.name === "Nova Renewable Systems");
    expect(nova?.bessMw).toBe(0);
    expect(nova?.baseScores.fdre).toBe(3.1);
  });

  it("changes suitability when the same solar IPP is matched to a different GES shape", () => {
    const ipp = buildIppCases().find((item) => item.id === "ipp_novarenewable");
    if (!ipp) throw new Error("missing ipp");
    const weights = DEFAULT_SUITABILITY_WEIGHTS;
    const run = (gesId: string) => {
      const ges = GES_SEED.find((item) => item.id === gesId)!;
      const load = buildLoadIntervals(ges.id, ges.annualEnergyGwh);
      return evaluatePair(ipp, {
        id: ges.id,
        annualEnergyGwh: ges.annualEnergyGwh,
        peakDemandMw: ges.peakDemandMw,
        targetCodYear: ges.targetCodYear,
        preferredTechnologies: ges.preferredTechnologies,
        bessPreference: ges.bessPreference,
        bessHoursMin: ges.bessHoursMin,
        loadMw: load.map((point) => point.mw),
        tariffFloor: 3.2,
        tariffCeiling: 4.6,
        weights,
      }).suitability.overallPct;
    };
    expect(run("ges_nova")).toBeGreaterThan(run("ges_aster"));
  });
});

describe("capex credibility", () => {
  it("scores firm evidence above budgetary evidence", () => {
    const firm = capexCredibility([{ amountInrCr: 100, assumptionType: "FIRM" }]);
    const budgetary = capexCredibility([{ amountInrCr: 100, assumptionType: "BUDGETARY" }]);
    expect(firm.score).toBeGreaterThan(budgetary.score);
  });
});

describe("language guard", () => {
  it("does not use the retired programme acronym anywhere in the application source", () => {
    const roots = [join(__dirname, "..", "src"), join(__dirname, "..", "prisma")];
    const offenders: string[] = [];
    const walk = (dir: string) => {
      for (const entry of readdirSync(dir)) {
        const path = join(dir, entry);
        if (statSync(path).isDirectory()) walk(path);
        else if (/\.(ts|prisma|json|md)$/.test(entry)) {
          const text = readFileSync(path, "utf8");
          const banned = ["j", "s", "m", "a"].join("");
          if (text.toLowerCase().includes(banned)) offenders.push(path);
        }
      }
    };
    roots.forEach(walk);
    expect(offenders).toEqual([]);
  });
});
