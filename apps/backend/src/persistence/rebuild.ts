import { Prisma, PrismaClient } from "@prisma/client";
import { EVALUATION_PARAMETERS } from "../domain/parameters";
import { evaluatePair, GesCase, IppCase } from "../domain/evaluate";
import { buildLoadIntervals } from "../domain/profiles";
import { TariffDrivers } from "../domain/tariff";
import { EvaluationScores } from "../domain/parameters";

type Db = PrismaClient;

interface BaselinePayload {
  interestRate: number;
  capexInrCr: number;
  capexCredibility: number;
  bessMw: number;
  bessMwh: number;
  solarCuf: number;
  windCuf: number;
  generationGwh: number;
  baseScores: EvaluationScores;
  scadaIntegration: IppCase["scadaIntegration"];
  weakSystemStudy: boolean;
  dataQualityFactor: number;
}

const REVIEWERS: Record<string, string> = {
  execution: "Technical Team",
  financial: "Finance Team",
  ehv: "Technical Team",
  engineering: "Technical Team",
  fdre: "Technical Team",
  epc: "Technical Team",
  cod: "Technical Team",
  capex: "Finance Team",
  tariff: "Commercial Team",
  regulatory: "Commercial Team",
};

const EVIDENCE: Record<string, string> = {
  execution: "Commissioning record received",
  financial: "Funding capability note received",
  ehv: "Evacuation experience note received",
  engineering: "Design basis received",
  fdre: "Generation profile received",
  epc: "Procurement plan received",
  cod: "Schedule received",
  capex: "CAPEX build-up received",
  tariff: "Tariff proposal received",
  regulatory: "Contractual mark-up received",
};

function parameterStatus(score: number): "PASS" | "CONDITIONAL" | "FAIL" {
  if (score >= 4) return "PASS";
  if (score >= 3.4) return "CONDITIONAL";
  return "FAIL";
}

export async function rebuildPair(prisma: Db, gesId: string, ippId: string) {
  const [ges, ipp, config] = await Promise.all([
    prisma.gES.findUnique({
      where: { id: gesId },
      include: { requirement: true, loadProfiles: true },
    }),
    prisma.iPP.findUnique({
      where: { id: ippId },
      include: {
        solarProfile: true,
        windProfile: true,
        bessProfile: true,
        generation: true,
        ehv: true,
        execution: true,
        capex: { include: { items: true } },
        financial: true,
        tariff: true,
        regulatory: true,
      },
    }),
    prisma.suitabilityConfig.findFirst({ where: { active: true } }),
  ]);
  if (!ges?.requirement || !ipp?.tariff || !ipp.capex || !ipp.financial || !ipp.regulatory || !ipp.execution || !ipp.ehv || !ipp.generation || !config) {
    throw new Error("IPP or GES is missing the inputs required for calculation");
  }

  const baseline = ipp.baseline as unknown as BaselinePayload;
  const storedDrivers = ipp.tariff.drivers as unknown as TariffDrivers;
  const bessLine = ipp.capex.items.find((item) => item.category === "BESS CAPEX");
  const drivers: TariffDrivers = {
    ...storedDrivers,
    capexInrCr: ipp.capex.totalInrCr,
    bessCapexInrCr: bessLine?.amountInrCr ?? storedDrivers.bessCapexInrCr,
    interestRate: ipp.financial.interestRate,
    loanTenureYears: ipp.financial.loanTenureYears,
    moratoriumYears: ipp.financial.moratoriumYears,
    generationGwh: ipp.annualGenerationGwh,
    opex: {
      ...storedDrivers.opex,
      evacuation: ipp.tariff.evacuationExcluded ? 0 : storedDrivers.opex.evacuation || 0.14,
      bess: ipp.bessMw > 0 && !ipp.tariff.bessExcluded ? storedDrivers.opex.bess : 0,
    },
  };

  const load = buildLoadIntervals(ges.id, ges.requirement.annualEnergyGwh);
  const ippCase: IppCase = {
    id: ipp.id,
    name: ipp.name,
    solarMw: ipp.solarMw,
    windMw: ipp.windMw,
    bessMw: ipp.bessMw,
    bessMwh: ipp.bessMwh,
    annualGenerationGwh: ipp.annualGenerationGwh,
    p50Gwh: ipp.generation.p50Gwh,
    p75Gwh: ipp.generation.p75Gwh,
    p90Gwh: ipp.generation.p90Gwh,
    quotedTariff: ipp.tariff.quotedTariff,
    codYear: ipp.targetCodYear,
    baseScores: baseline.baseScores,
    solarCuf: ipp.solarProfile?.cuf ?? 0,
    windCuf: ipp.windProfile?.cuf ?? 0,
    generationValidation: mapValidation(ipp.generation.independentValidation),
    connectivityStatus: ipp.ehv.connectivityStatus,
    capexItems: ipp.capex.items.map((item) => ({ amountInrCr: item.amountInrCr, assumptionType: item.assumptionType })),
    drivers,
    lenderIdentified: ipp.financial.lenderIdentified,
    fundraisingDependency: ipp.financial.fundraisingDependency,
    financingScheduleMismatch: ipp.financial.financingScheduleMismatch,
    hasCpm: ipp.execution.hasCpm,
    procurementAligned: ipp.execution.procurementAligned,
    connectivityAssumed: ipp.execution.connectivityAssumed,
    epcCommitted: ipp.execution.epcCommitted,
    projectBufferMonths: ipp.execution.projectBufferMonths,
    weakSystemStudy: baseline.weakSystemStudy,
    bessDegradation: ipp.bessProfile?.degradation ?? null,
    bessExcluded: ipp.tariff.bessExcluded,
    evacuationExcluded: ipp.tariff.evacuationExcluded,
    escalationClear: ipp.tariff.escalationClear,
    changeInLaw: ipp.regulatory.changeInLaw as IppCase["changeInLaw"],
    curtailment: ipp.regulatory.curtailment as IppCase["curtailment"],
    indemnity: ipp.regulatory.indemnity as IppCase["indemnity"],
    complianceBearer: ipp.regulatory.complianceBearer as IppCase["complianceBearer"],
    delayBearer: ipp.regulatory.delayBearer as IppCase["delayBearer"],
    scadaIntegration: baseline.scadaIntegration,
    dataQualityFactor: baseline.dataQualityFactor,
    depthOfDischarge: ipp.bessProfile?.depthOfDischarge ?? 0,
    roundTripEfficiency: ipp.bessProfile?.roundTripEfficiency ?? 1,
    usableEnergyMwh: ipp.bessProfile?.usableEnergyMwh ?? 0,
    milestones: (ipp.execution.milestones as unknown as IppCase["milestones"]) ?? [],
    baseline,
  };

  const weights = config.weights as unknown as GesCase["weights"];
  const gesCase: GesCase = {
    id: ges.id,
    annualEnergyGwh: ges.requirement.annualEnergyGwh,
    peakDemandMw: ges.requirement.peakDemandMw,
    targetCodYear: ges.requirement.targetCodYear,
    preferredTechnologies: ges.requirement.preferredTechnologies,
    bessPreference: ges.requirement.bessPreference,
    bessHoursMin: ges.requirement.bessHoursMin ?? 0,
    loadMw: load.map((point) => point.mw),
    tariffFloor: config.tariffFloor,
    tariffCeiling: config.tariffCeiling,
    weights,
  };

  const result = evaluatePair(ippCase, gesCase);
  const requirementId = ges.requirement.id;
  const link = await prisma.gESRequirementIPP.findUnique({
    where: { gesRequirementId_ippId: { gesRequirementId: requirementId, ippId } },
  });
  const now = new Date();

  await prisma.$transaction(async (tx) => {
    await tx.gESLoadProfile.updateMany({
      where: { gesId: ges.id },
      data: {
        intervals: load as unknown as Prisma.InputJsonValue,
        annualEnergyGwh: ges.requirement!.annualEnergyGwh,
        peakMw: Math.max(...load.map((point) => point.mw)),
      },
    });
    await tx.iPPGenerationProfile.update({
      where: { ippId: ipp.id },
      data: {
        intervals: result.loadMatch.series.map((point) => ({ t: point.t, mw: point.generationMw })) as unknown as Prisma.InputJsonValue,
        p50Gwh: ipp.generation!.p50Gwh,
        p90Gwh: ipp.generation!.p90Gwh,
      },
    });
    await tx.iPPEvaluation.upsert({
      where: { ippId: ipp.id },
      create: {
        id: `eval_${ipp.id}`,
        ippId: ipp.id,
        overallScore: result.scoring.overallScore,
        dataQuality: result.failedGate ? "PARTIAL" : "COMPLETE",
        confidence: baseline.dataQualityFactor,
        reviewerName: "NewRa evaluation service",
        calculatedAt: now,
      },
      update: {
        overallScore: result.scoring.overallScore,
        confidence: baseline.dataQualityFactor,
        calculatedAt: now,
      },
    });
    const evaluation = await tx.iPPEvaluation.findUniqueOrThrow({ where: { ippId: ipp.id } });
    for (const parameter of result.scoring.parameters) {
      await tx.iPPEvaluationParameter.upsert({
        where: { evaluationId_key: { evaluationId: evaluation.id, key: parameter.key } },
        create: {
          evaluationId: evaluation.id,
          key: parameter.key,
          name: parameter.name,
          shortLabel: parameter.short,
          score: parameter.score,
          weight: parameter.weight,
          normalizedScore: parameter.normalizedScore,
          weightedContribution: parameter.weightedContribution,
          evidence: EVIDENCE[parameter.key],
          status: parameterStatus(parameter.score),
          reviewer: REVIEWERS[parameter.key],
          dataQuality: "COMPLETE",
        },
        update: {
          score: parameter.score,
          normalizedScore: parameter.normalizedScore,
          weightedContribution: parameter.weightedContribution,
          status: parameterStatus(parameter.score),
        },
      });
      await tx.iPPEvaluationScore.upsert({
        where: { evaluationId_key: { evaluationId: evaluation.id, key: parameter.key } },
        create: {
          evaluationId: evaluation.id,
          key: parameter.key,
          baseScore: baseline.baseScores[parameter.key as keyof EvaluationScores],
          appliedScore: parameter.score,
          reason: "Calculated from base score and input movement versus the seeded baseline",
        },
        update: {
          appliedScore: parameter.score,
        },
      });
    }

    await tx.iPPCapexModel.update({
      where: { ippId: ipp.id },
      data: { credibilityScore: result.credibility.score, totalInrCr: ipp.capex!.totalInrCr },
    });
    await tx.iPPFinancialModel.update({
      where: { ippId: ipp.id },
      data: {
        dscr: result.finance.dscr,
        projectIrr: result.finance.projectIrr,
        equityIrr: result.finance.equityIrr,
        debtInrCr: result.finance.debtInrCr,
        equityInrCr: result.finance.equityInrCr,
        debtEquityRatio: result.finance.debtEquityRatio,
        capabilityScore: result.finance.capabilityScore,
        equityRequirementInrCr: result.finance.equityInrCr,
      },
    });
    await tx.iPPTariffComponent.deleteMany({ where: { modelId: ipp.tariff!.id } });
    await tx.iPPTariffComponent.createMany({
      data: result.tariff.components.map((component) => ({
        modelId: ipp.tariff!.id,
        key: component.key,
        label: component.label,
        amount: component.amount,
        capexLinked: component.capexLinked,
        debtLinked: component.debtLinked,
        bessLinked: component.bessLinked,
        fixedRecovery: component.fixedRecovery,
        sortOrder: component.sortOrder,
      })),
    });
    await tx.iPPTariffModel.update({
      where: { ippId: ipp.id },
      data: {
        calculatedTariff: result.tariff.calculatedTariff,
        sustainability: result.sustainability,
        drivers: drivers as unknown as Prisma.InputJsonValue,
      },
    });
    await tx.iPPRegulatoryProfile.update({
      where: { ippId: ipp.id },
      data: { protectionScore: result.regulatoryScore },
    });
    if (ipp.bessProfile) {
      await tx.iPPBESSProfile.update({
        where: { ippId: ipp.id },
        data: {
          durationHours: result.durationHours,
          yearSnapshots: result.bessSnapshots as unknown as Prisma.InputJsonValue,
        },
      });
    }
    await tx.iPPEHVProfile.update({
      where: { ippId: ipp.id },
      data: { connectivityRisk: result.connectivityRisk, capabilityScore: result.scores.ehv },
    });
    await tx.iPPExecutionSchedule.update({
      where: { ippId: ipp.id },
      data: {
        criticalPath: result.schedule.criticalPath as unknown as Prisma.InputJsonValue,
        longestLeadItem: `${result.schedule.longestLeadItem} (${result.schedule.longestLeadDays} days)`,
        milestones: result.schedule.milestones as unknown as Prisma.InputJsonValue,
      },
    });

    await tx.loadMatchResult.upsert({
      where: { gesId_ippId: { gesId, ippId } },
      create: {
        gesId,
        ippId,
        requiredGwh: result.loadMatch.requiredGwh,
        availableGwh: result.loadMatch.availableGwh,
        matchedGwh: result.loadMatch.matchedGwh,
        surplusGwh: result.loadMatch.surplusGwh,
        deficitGwh: result.loadMatch.deficitGwh,
        coveragePct: result.loadMatch.coveragePct,
        loadMatchPct: result.loadMatch.loadMatchPct,
        series: result.loadMatch.series as unknown as Prisma.InputJsonValue,
        dataQuality: "COMPLETE",
        calculatedAt: now,
      },
      update: {
        requiredGwh: result.loadMatch.requiredGwh,
        availableGwh: result.loadMatch.availableGwh,
        matchedGwh: result.loadMatch.matchedGwh,
        surplusGwh: result.loadMatch.surplusGwh,
        deficitGwh: result.loadMatch.deficitGwh,
        coveragePct: result.loadMatch.coveragePct,
        loadMatchPct: result.loadMatch.loadMatchPct,
        series: result.loadMatch.series as unknown as Prisma.InputJsonValue,
        calculatedAt: now,
      },
    });

    await tx.iPPSuitability.upsert({
      where: { gesRequirementId_ippId: { gesRequirementId: requirementId, ippId } },
      create: {
        gesRequirementId: requirementId,
        ippId,
        overallPct: result.suitability.overallPct,
        compatibilityStatus: result.suitability.compatibilityStatus,
        illustrativeSeedStatus: link?.illustrativeSeedStatus,
        dimensions: result.suitability.dimensions as unknown as Prisma.InputJsonValue,
        dataQuality: baseline.dataQualityFactor >= 0.95 ? "COMPLETE" : "PARTIAL",
        blockedByGate: result.failedGate,
        calculatedAt: now,
      },
      update: {
        overallPct: result.suitability.overallPct,
        compatibilityStatus: result.suitability.compatibilityStatus,
        dimensions: result.suitability.dimensions as unknown as Prisma.InputJsonValue,
        blockedByGate: result.failedGate,
        calculatedAt: now,
      },
    });

    await tx.gESRequirementIPP.update({
      where: { gesRequirementId_ippId: { gesRequirementId: requirementId, ippId } },
      data: {
        compatibilityStatus: result.suitability.compatibilityStatus,
        suitabilityScore: result.suitability.overallPct,
        technicalFit: result.suitability.technicalFit,
        commercialFit: result.suitability.commercialFit,
        financialFit: result.suitability.financialFit,
        generationFit: result.suitability.generationFit,
        loadMatchScore: result.suitability.loadMatchScore,
      },
    });

    await tx.criticalGateResult.deleteMany({ where: { gesId, ippId } });
    const gates = await tx.criticalGate.findMany();
    await tx.criticalGateResult.createMany({
      data: result.gates.map((gate) => ({
        gateId: gates.find((item) => item.key === gate.key)?.id ?? gate.key,
        ippId,
        gesId,
        status: gate.status,
        rationale: gate.rationale,
        evidence: gate.evidence,
      })),
    });

    await tx.redFlag.deleteMany({ where: { ippId, gesId } });
    if (result.redFlags.length) {
      await tx.redFlag.createMany({
        data: result.redFlags.map((flag) => ({
          ippId,
          gesId,
          category: flag.category,
          severity: flag.severity,
          code: flag.code,
          title: flag.title,
          detail: flag.detail,
          active: true,
        })),
      });
    }
  });

  return { scoring: result.scoring, suitability: result.suitability, loadMatch: result.loadMatch, gates: result.gates, redFlags: result.redFlags, tariff: result.tariff, finance: result.finance, sustainability: result.sustainability };
}

export async function rebuildGes(prisma: Db, gesId: string) {
  const links = await prisma.gESRequirementIPP.findMany({
    where: { requirement: { gesId } },
    select: { ippId: true },
  });
  const results = [];
  for (const link of links) results.push(await rebuildPair(prisma, gesId, link.ippId));
  return results;
}

export async function rebuildAll(prisma: Db) {
  const links = await prisma.gESRequirementIPP.findMany({ select: { ippId: true, requirement: { select: { gesId: true } } } });
  for (const link of links) {
    await rebuildPair(prisma, link.requirement.gesId, link.ippId);
  }
}

function mapValidation(status: string): IppCase["generationValidation"] {
  if (status === "VERIFIED" || status === "UNDER_REVIEW" || status === "PENDING" || status === "RECEIVED" || status === "MISSING") {
    return status;
  }
  return "PENDING";
}

void EVALUATION_PARAMETERS;
