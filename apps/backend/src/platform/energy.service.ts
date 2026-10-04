import { BadRequestException, Injectable, NotFoundException } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { Workbook } from "exceljs";
import PDFDocument from "pdfkit";
import { manualSeedIpp } from "../demo/catalog";
import { monthlyGeneration, technologyEnergySplit } from "../domain/profiles";
import { TariffDrivers } from "../domain/tariff";
import { rebuildGes, rebuildPair } from "../persistence/rebuild";
import { storeIpp } from "../persistence/store-ipp";
import { PrismaService } from "../prisma/prisma.service";
import { AuditService } from "./audit.service";
import { FinancialFeasibilityService, TariffSensitivityService } from "./domain.services";

type Actor = { id: string; permissions: string[]; gesId?: string | null; roles?: string[]; name?: string };

const bessLabel: Record<string, string> = {
  OPTIONAL: "Optional",
  HOURS_2_TO_4: "2–4 hour capability",
  HOURS_4: "4-hour capability",
};

@Injectable()
export class EnergyService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly tariffSensitivity: TariffSensitivityService,
    private readonly finance: FinancialFeasibilityService,
  ) {}

  async dashboard(gesId?: string, onlyThisGes = false) {
    const scopedId = onlyThisGes ? gesId : undefined;
    const metricId = gesId;
    const linkWhere = metricId ? { requirement: { gesId: metricId } } : {};
    const reviewWhere = metricId
      ? { gesId: metricId, status: { in: ["UNDER_REVIEW" as const, "PENDING" as const, "REQUESTED" as const] } }
      : { status: { in: ["UNDER_REVIEW" as const, "PENDING" as const, "REQUESTED" as const] } };
    const riskWhere = metricId
      ? { gesId: metricId, active: true, severity: { in: ["HIGH" as const, "CRITICAL" as const] } }
      : { active: true, severity: { in: ["HIGH" as const, "CRITICAL" as const] } };
    const taskWhere = metricId
      ? { gesId: metricId, status: { in: ["OPEN" as const, "IN_PROGRESS" as const] } }
      : { status: { in: ["OPEN" as const, "IN_PROGRESS" as const] } };
    const [gesCount, ippCount, links, reviews, risks, tasks, gesRows] = await Promise.all([
      this.prisma.gES.count(scopedId ? { where: { id: scopedId } } : undefined),
      metricId
        ? this.prisma.gESRequirementIPP.count({ where: { requirement: { gesId: metricId } } })
        : this.prisma.iPP.count(),
      this.prisma.gESRequirementIPP.findMany({ where: linkWhere, include: { requirement: { include: { ges: true } }, ipp: true } }),
      this.prisma.document.count({ where: reviewWhere }),
      this.prisma.redFlag.count({ where: riskWhere }),
      this.prisma.task.count({ where: taskWhere }),
      this.prisma.gES.findMany({
        where: scopedId ? { id: scopedId } : {},
        include: { requirement: true },
        orderBy: { name: "asc" },
      }),
    ]);
    const tasksOpen = await this.prisma.task.findMany({ where: taskWhere, include: { owner: true }, orderBy: { dueDate: "asc" }, take: 6 });
    const documents = await this.prisma.document.findMany({ where: metricId ? { gesId: metricId } : {}, orderBy: { updatedAt: "desc" }, take: 6 });
    const selectedId = gesId && gesRows.some((ges) => ges.id === gesId) ? gesId : gesRows[0]?.id;
    const selectedLinks = links.filter((link) => link.requirement.gesId === selectedId);
    const average = selectedLinks.length
      ? selectedLinks.reduce((total, link) => total + link.suitabilityScore, 0) / selectedLinks.length
      : 0;
    const ges = gesRows.find((item) => item.id === selectedId);
    const accounts = await this.listGes(scopedId);
    const selected = accounts.find((item) => item.id === selectedId) ?? accounts[0];
    return {
      illustrative: true,
      totals: {
        gesAccounts: gesCount,
        ippCandidates: ippCount,
        activeEvaluations: links.length,
        shortlisted: links.filter((link) => link.shortlisted).length,
        pendingReviews: reviews,
        pendingActions: tasks,
        criticalRisks: risks,
      },
      ges: accounts,
      selectedGes: selected,
      keyMetrics: {
        averageSuitability: round(average),
        bestSuitability: selectedLinks.reduce((best, link) => Math.max(best, link.suitabilityScore), 0),
        candidateCount: selectedLinks.length,
        targetCodYear: ges?.requirement?.targetCodYear ?? null,
      },
      recentTasks: tasksOpen.map((task) => ({
        id: task.id,
        title: task.title,
        owner: task.owner?.name ?? task.pendingFrom,
        status: task.status,
        dueDate: task.dueDate.toISOString().slice(0, 10),
        priority: task.priority,
      })),
      recentDocuments: documents.map((document) => ({
        id: document.id,
        title: document.title,
        status: document.status,
        updatedAt: document.updatedAt.toISOString(),
      })),
    };
  }

  listGes(onlyId?: string | null) {
    return this.prisma.gES.findMany({
      where: onlyId ? { id: onlyId } : {},
      include: { requirement: { include: { ipps: true } } },
      orderBy: { name: "asc" },
    }).then(async (rows) => {
      const matches = await this.prisma.loadMatchResult.findMany({
        where: { gesId: { in: rows.map((ges) => ges.id) } },
        include: { ipp: true },
      });
      const createdOrder = [...rows].sort((left, right) => left.createdAt.getTime() - right.createdAt.getTime()).map((ges) => ges.id);
      const profiles = await loadGesProfiles(this.prisma, rows.map((ges) => ges.id));
      return rows.map((ges) => {
        const profile = profiles.get(ges.id);
        return {
        ...this.toGesAccount(ges, average(ges.requirement?.ipps.map((link) => link.suitabilityScore) ?? [])),
        code: gesCode(ges.id, createdOrder),
        legalName: ges.legalName,
        city: ges.location,
        state: ges.state,
        discom: ges.discom,
        consumerNumbers: ges.consumerNumbers,
        contractDemandMw: ges.contractDemandMw,
        billedDemandMw: ges.billedDemandMw,
        existingRooftopMw: ges.existingRooftopMw,
        existingRenewableGwh: ges.existingRenewableGwh,
        annualConsumptionGwh: ges.annualConsumptionGwh,
        renewableEnergyTargetPercent: profile?.renewableEnergyTargetPercent ?? null,
        sanctionedLoadKw: profile?.sanctionedLoadKw ?? null,
        solarConnectionType: profile?.solarConnectionType ?? null,
        peakRecordedDemandKva: profile?.peakRecordedDemandKva ?? null,
        bessRequirement: profile?.bessRequirement ?? null,
        notes: ges.notes,
        ipps: matches
          .filter((match) => match.gesId === ges.id)
          .map((match) => ({
            id: match.ippId,
            name: match.ipp.name,
            technology: match.ipp.technologySummary,
            availableGwh: round(match.availableGwh, 1),
            matchedGwh: round(match.matchedGwh, 1),
            usedPct: match.availableGwh > 0 ? round((match.matchedGwh / match.availableGwh) * 100, 1) : 0,
            coveragePct: round(match.coveragePct, 1),
            tariff: match.ipp.indicativeTariffInrPerKwh,
            solarMw: match.ipp.solarMw,
            windMw: match.ipp.windMw,
            bessMw: match.ipp.bessMw,
          }))
          .sort((left, right) => right.usedPct - left.usedPct),
        };
      });
    });
  }

  async getGes(id: string) {
    const ges = await this.prisma.gES.findUnique({
      where: { id },
      include: {
        requirement: true,
        consumers: true,
        loadProfiles: true,
        documents: { include: { versions: true } },
        tasks: true,
        activities: { orderBy: { createdAt: "desc" }, take: 20, include: { actor: true } },
      },
    });
    if (!ges) throw new NotFoundException("GES account was not found");
    const board = await this.ippBoard(id);
    return {
      ...ges,
      bessLabel: ges.requirement ? bessLabel[ges.requirement.bessPreference] : null,
      kpis: {
        annualEnergyGwh: ges.requirement?.annualEnergyGwh ?? null,
        peakDemandMw: ges.requirement?.peakDemandMw ?? null,
        requiredCapacityGw: ges.requirement?.requiredCapacityGw ?? null,
        targetCodYear: ges.requirement?.targetCodYear ?? null,
        candidates: board.length,
        shortlisted: board.filter((row) => row.shortlisted).length,
        bestSuitability: board.reduce((best, row) => Math.max(best, row.suitability), 0),
        openRisks: board.reduce((total, row) => total + row.riskCount, 0),
      },
      candidates: board,
      illustrative: true,
    };
  }

  async createGes(body: Record<string, unknown>, actor: Actor) {
    const input = gesInput(body);
    await this.assertUniqueName(input.name);
    const id = `ges_${Date.now()}`;
    await this.prisma.gES.create({
      data: {
        id,
        name: input.name,
        legalName: input.legalName,
        businessType: input.businessType,
        location: input.city,
        state: input.state,
        discom: input.discom,
        consumerNumbers: input.consumerNumbers,
        contractDemandMw: input.contractDemandMw,
        billedDemandMw: input.billedDemandMw,
        existingRooftopMw: input.existingRooftopMw,
        existingRenewableGwh: input.existingRenewableGwh,
        annualConsumptionGwh: input.annualConsumptionGwh,
        notes: input.notes,
        illustrative: true,
        crmStage: "CLIENT_DISCOVERY",
        evaluationStage: "IPP_EVALUATION",
        consumers: {
          create: {
            consumerNumber: input.consumerNumbers.split(",")[0].trim(),
            discom: input.discom,
            contractDemandMw: input.contractDemandMw,
            billedDemandMw: input.billedDemandMw,
            voltageLevel: "33 kV",
          },
        },
        requirement: {
          create: {
            id: `req_${id}`,
            annualEnergyGwh: input.annualEnergyGwh,
            peakDemandMw: input.peakDemandMw,
            requiredCapacityGw: input.requiredCapacityGw,
            targetCodYear: input.targetCodYear,
            preferredTechnologies: input.preferredTechnologies,
            bessPreference: input.bessPreference,
            bessHoursMin: input.bessHoursMin,
            bessHoursMax: input.bessHoursMax,
            notes: input.notes,
            dataQuality: "PARTIAL",
          },
        },
        loadProfiles: {
          create: {
            id: `load_${id}`,
            name: "Illustrative 15-minute operating day",
            intervalMinutes: 15,
            intervals: [],
            annualEnergyGwh: input.annualEnergyGwh,
            peakMw: input.peakDemandMw,
            dataQuality: "PARTIAL",
            source: "Daytime industrial shape scaled to the annual requirement",
            evidenceStatus: "PENDING",
          },
        },
      },
    });
    const ipps = await this.prisma.iPP.findMany({ select: { id: true }, orderBy: { name: "asc" } });
    for (const ipp of ipps) {
      await this.prisma.gESRequirementIPP.create({
        data: {
          id: `link_${id}_${ipp.id}`,
          gesRequirementId: `req_${id}`,
          ippId: ipp.id,
          compatibilityStatus: "CONDITIONAL",
          illustrativeSeedStatus: "CONDITIONAL",
        },
      });
    }
    const preferred = ["ipp_sungrid", "ipp_hybridgreen", "ipp_terragrid"].filter((ippId) => ipps.some((ipp) => ipp.id === ippId));
    const comparisonIds = [...preferred, ...ipps.map((ipp) => ipp.id).filter((ippId) => !preferred.includes(ippId))].slice(0, 3);
    if (comparisonIds.length) {
      await this.prisma.comparison.create({
        data: {
          gesId: id,
          name: "Working comparison",
          working: true,
          createdById: actor.id,
          ipps: { create: comparisonIds.map((ippId, position) => ({ ippId, position })) },
        },
      });
    }
    await saveGesProfile(this.prisma, id, input.profile);
    await rebuildGes(this.prisma, id);
    await this.audit.log({ entity: "GES", entityId: id, action: "CREATE", newValue: { name: input.name }, userId: actor.id });
    return this.listGes();
  }

  async updateGes(id: string, body: Record<string, unknown>, actor: Actor) {
    const current = await this.prisma.gES.findUnique({ where: { id }, include: { requirement: true } });
    if (!current?.requirement) throw new NotFoundException("GES account was not found");
    const input = gesInput(body, {
      name: current.name,
      legalName: current.legalName,
      businessType: current.businessType,
      city: current.location,
      state: current.state,
      discom: current.discom,
      consumerNumbers: current.consumerNumbers,
      contractDemandMw: current.contractDemandMw,
      billedDemandMw: current.billedDemandMw,
      existingRooftopMw: current.existingRooftopMw,
      existingRenewableGwh: current.existingRenewableGwh,
      annualConsumptionGwh: current.annualConsumptionGwh,
      notes: current.notes,
      annualEnergyGwh: current.requirement.annualEnergyGwh,
      peakDemandMw: current.requirement.peakDemandMw,
      requiredCapacityGw: current.requirement.requiredCapacityGw,
      targetCodYear: current.requirement.targetCodYear,
      preferredTechnologies: current.requirement.preferredTechnologies,
      bessPreference: current.requirement.bessPreference,
    });
    await this.assertUniqueName(input.name, id);
    await this.prisma.gES.update({
      where: { id },
      data: {
        name: input.name,
        legalName: input.legalName,
        businessType: input.businessType,
        location: input.city,
        state: input.state,
        discom: input.discom,
        consumerNumbers: input.consumerNumbers,
        contractDemandMw: input.contractDemandMw,
        billedDemandMw: input.billedDemandMw,
        existingRooftopMw: input.existingRooftopMw,
        existingRenewableGwh: input.existingRenewableGwh,
        annualConsumptionGwh: input.annualConsumptionGwh,
        notes: input.notes,
        requirement: {
          update: {
            annualEnergyGwh: input.annualEnergyGwh,
            peakDemandMw: input.peakDemandMw,
            requiredCapacityGw: input.requiredCapacityGw,
            targetCodYear: input.targetCodYear,
            preferredTechnologies: input.preferredTechnologies,
            bessPreference: input.bessPreference,
            bessHoursMin: input.bessHoursMin,
            bessHoursMax: input.bessHoursMax,
            notes: input.notes,
          },
        },
      },
    });
    await this.prisma.gESConsumer.deleteMany({ where: { gesId: id } });
    await this.prisma.gESConsumer.create({
      data: {
        gesId: id,
        consumerNumber: input.consumerNumbers.split(",")[0].trim(),
        discom: input.discom,
        contractDemandMw: input.contractDemandMw,
        billedDemandMw: input.billedDemandMw,
        voltageLevel: "33 kV",
      },
    });
    await this.prisma.gESLoadProfile.updateMany({
      where: { gesId: id },
      data: { annualEnergyGwh: input.annualEnergyGwh, peakMw: input.peakDemandMw },
    });
    await saveGesProfile(this.prisma, id, input.profile);
    await rebuildGes(this.prisma, id);
    await this.audit.log({ entity: "GES", entityId: id, action: "UPDATE", oldValue: { name: current.name }, newValue: { name: input.name }, userId: actor.id });
    return this.listGes();
  }

  async linkIpp(gesId: string, ippId: string, actor: Actor) {
    const ges = await this.prisma.gES.findUnique({ where: { id: gesId }, include: { requirement: true } });
    if (!ges?.requirement) throw new NotFoundException("GES account was not found");
    const ipp = await this.prisma.iPP.findUnique({ where: { id: ippId }, select: { id: true, name: true } });
    if (!ipp) throw new NotFoundException("Independent power producer was not found");
    const existing = await this.prisma.gESRequirementIPP.findFirst({ where: { gesRequirementId: ges.requirement.id, ippId } });
    if (!existing) {
      await this.prisma.gESRequirementIPP.create({
        data: {
          id: `link_${gesId}_${ippId}`,
          gesRequirementId: ges.requirement.id,
          ippId,
          compatibilityStatus: "CONDITIONAL",
          illustrativeSeedStatus: "CONDITIONAL",
        },
      });
      await rebuildPair(this.prisma, gesId, ippId);
      await this.audit.log({ entity: "GESRequirementIPP", entityId: `link_${gesId}_${ippId}`, action: "CREATE", newValue: { gesId, ippId, name: ipp.name }, userId: actor.id });
    }
    return this.listGes();
  }

  async ippCatalog(gesId?: string | null, options?: { clientSafe?: boolean }) {
    const selections = await this.prisma.gESIPPSelection.findMany({
      select: { ippId: true, gesId: true, ges: { select: { name: true } } },
    });
    const ipps = await this.prisma.iPP.findMany({
      orderBy: { name: "asc" },
      include: {
        links: { include: { requirement: { include: { ges: true } } } },
        loadMatches: gesId ? { where: { gesId } } : true,
        project: true,
        ehv: true,
        capex: true,
      },
    });
    const profiles = await loadIppProfiles(this.prisma, ipps.map((ipp) => ipp.id));
    const extras = [...ipps].sort((left, right) => left.createdAt.getTime() - right.createdAt.getTime()).filter((ipp) => !IPP_CODES[ipp.id]);
    return ipps.map((ipp) => {
      const usedGwh = ipp.loadMatches.reduce((best, match) => Math.max(best, match.matchedGwh), 0);
      const extraIndex = extras.findIndex((item) => item.id === ipp.id);
      const profile = profiles.get(ipp.id);
      return {
        id: ipp.id,
        code: IPP_CODES[ipp.id] ?? `IPP ${String(Object.keys(IPP_CODES).length + extraIndex + 1).padStart(2, "0")}`,
        name: ipp.name,
        projectName: ipp.project?.name ?? "",
        headquarters: ipp.headquarters,
        projectState: ipp.project?.state ?? "",
        projectDistrict: profile?.projectDistrict ?? null,
        projectLocation: profile?.projectLocation ?? null,
        technology: ipp.technologySummary,
        solarMw: ipp.solarMw,
        windMw: ipp.windMw,
        bessMw: ipp.bessMw,
        bessMwh: ipp.bessMwh,
        annualGenerationGwh: ipp.annualGenerationGwh,
        p90Gwh: ipp.p90Gwh > 0 ? ipp.p90Gwh : null,
        generationData15Min: profile?.generationData15Min ?? null,
        fdreCapability: profile?.fdreCapability ?? null,
        gridVoltage: profile?.gridVoltage ?? null,
        gridConnectivity: profile?.gridConnectivity ?? null,
        engineConnectivity: ipp.ehv?.connectivityStatus ?? null,
        openAccessReadiness: profile?.openAccessReadiness ?? null,
        tariff: ipp.indicativeTariffInrPerKwh,
        tariffType: profile?.tariffType ?? null,
        contractTenureYears: profile?.contractTenureYears ?? null,
        projectStatus: ipp.project?.status ?? "",
        codYear: ipp.targetCodYear,
        codConfidence: profile?.codConfidence ?? null,
        estimatedCapexCr: options?.clientSafe ? null : ipp.capex && ipp.capex.totalInrCr > 0 ? ipp.capex.totalInrCr : null,
        fundingStatus: options?.clientSafe ? null : profile?.fundingStatus ?? null,
        financialModelAvailable: options?.clientSafe ? null : profile?.financialModelAvailable ?? null,
        gesCount: options?.clientSafe ? 0 : selections.filter((item) => item.ippId === ipp.id && (!gesId || item.gesId === gesId)).length,
        gesNames: options?.clientSafe ? [] : selections.filter((item) => item.ippId === ipp.id && (!gesId || item.gesId === gesId)).map((item) => item.ges.name),
        selectedByCurrentGes: Boolean(gesId && selections.some((item) => item.ippId === ipp.id && item.gesId === gesId)),
        usedGwh: options?.clientSafe ? 0 : round(usedGwh, 1),
        usedPct: options?.clientSafe ? 0 : ipp.annualGenerationGwh > 0 ? round((usedGwh / ipp.annualGenerationGwh) * 100, 1) : 0,
      };
    });
  }

  async createIpp(body: Record<string, unknown>, actor: Actor) {
    const draft = ippWrite(body);
    const id = `ipp_${Date.now()}`;
    const seeded = manualSeedIpp({
      id,
      name: draft.name,
      headquarters: draft.headquarters || "Not specified",
      solarMw: draft.solarMw,
      windMw: draft.windMw,
      bessMw: draft.bessMw,
      bessMwh: draft.bessMwh,
      annualGenerationGwh: draft.annualGenerationGwh,
      p90Gwh: draft.p90Gwh,
      quotedTariff: draft.tariff,
      codYear: draft.codYear || 2030,
    });
    await storeIpp(this.prisma, seeded);
    await this.prisma.iPP.update({
      where: { id },
      data: {
        headquarters: draft.headquarters,
        targetCodYear: draft.codYear ?? 0,
      },
    });
    if (draft.projectName) {
      await this.prisma.iPPProject.update({
        where: { ippId: id },
        data: {
          name: draft.projectName,
          state: draft.projectState,
          status: draft.projectStatus || "",
          capacityMw: draft.solarMw + draft.windMw,
          codYear: draft.codYear || 0,
        },
      });
    }
    await saveIppProfile(this.prisma, id, draft.profile);
    if (draft.estimatedCapexCr != null) {
      await this.prisma.iPPCapexModel.update({ where: { ippId: id }, data: { totalInrCr: draft.estimatedCapexCr } });
    }
    await syncConnectivity(this.prisma, id, draft.profile.gridConnectivity);
    const requirements = await this.prisma.gESRequirement.findMany();
    for (const requirement of requirements) {
      await this.prisma.gESRequirementIPP.create({
        data: {
          id: `link_${requirement.gesId}_${id}`,
          gesRequirementId: requirement.id,
          ippId: id,
          compatibilityStatus: "CONDITIONAL",
          illustrativeSeedStatus: "CONDITIONAL",
        },
      });
      await rebuildPair(this.prisma, requirement.gesId, id);
    }
    await this.audit.log({ entity: "IPP", entityId: id, action: "CREATE", newValue: { name: draft.name }, userId: actor.id });
    return this.ippCatalog();
  }

  async updateIpp(id: string, body: Record<string, unknown>, actor: Actor) {
    const current = await this.prisma.iPP.findUnique({
      where: { id },
      include: { tariff: true, generation: true, technology: true, solarProfile: true, windProfile: true, bessProfile: true, project: true, execution: true, capex: true },
    });
    if (!current?.tariff || !current.generation || !current.technology || !current.solarProfile || !current.windProfile || !current.bessProfile) {
      throw new NotFoundException("IPP was not found");
    }
    const stored = await loadIppProfiles(this.prisma, [id]);
    const draft = ippWrite(body, {
      name: current.name,
      projectName: current.project?.name ?? "",
      headquarters: current.headquarters,
      projectState: current.project?.state ?? "",
      projectStatus: current.project?.status ?? "",
      solarMw: current.solarMw,
      windMw: current.windMw,
      bessMw: current.bessMw,
      bessMwh: current.bessMwh,
      annualGenerationGwh: current.annualGenerationGwh,
      p90Gwh: current.p90Gwh > 0 ? current.p90Gwh : null,
      tariff: current.indicativeTariffInrPerKwh,
      codYear: current.targetCodYear,
      estimatedCapexCr: current.capex && current.capex.totalInrCr > 0 ? current.capex.totalInrCr : null,
      technology: current.technologySummary,
      profile: stored.get(id) ?? emptyIppProfile(),
    });
    const split = technologyEnergySplit({ solarMw: draft.solarMw, windMw: draft.windMw, annualGenerationGwh: draft.annualGenerationGwh });
    const drivers = { ...(current.tariff.drivers as unknown as TariffDrivers), generationGwh: draft.annualGenerationGwh };
    const p90ForProfile = draft.p90Gwh ?? 0;
    await this.prisma.iPP.update({
      where: { id },
      data: {
        name: draft.name,
        legalName: current.legalName === current.name ? draft.name : current.legalName,
        headquarters: draft.headquarters,
        technologySummary: draft.technology,
        solarMw: draft.solarMw,
        windMw: draft.windMw,
        bessMw: draft.bessMw,
        bessMwh: draft.bessMwh,
        annualGenerationGwh: draft.annualGenerationGwh,
        p90Gwh: p90ForProfile,
        indicativeTariffInrPerKwh: draft.tariff,
        targetCodYear: draft.codYear ?? 0,
        technology: { update: { solar: draft.solarMw > 0, wind: draft.windMw > 0, bess: draft.bessMw > 0, hybrid: [draft.solarMw, draft.windMw, draft.bessMw].filter((value) => value > 0).length > 1 } },
        solarProfile: { update: { acMw: draft.solarMw, dcMw: round(draft.solarMw * 1.35, 2), dcAcRatio: draft.solarMw > 0 ? 1.35 : 0, cuf: round(split.solarCuf, 4), dataQuality: draft.solarMw > 0 ? "COMPLETE" : "MISSING" } },
        windProfile: { update: { cuf: round(split.windCuf, 4), dataQuality: draft.windMw > 0 ? "COMPLETE" : "MISSING" } },
        bessProfile: {
          update: {
            powerMw: draft.bessMw,
            energyMwh: draft.bessMwh,
            usableEnergyMwh: round(draft.bessMwh * 0.9, 2),
            durationHours: draft.bessMw > 0 && draft.bessMwh > 0 ? round(draft.bessMwh / draft.bessMw, 2) : 0,
            dataQuality: draft.bessMw > 0 ? "COMPLETE" : "MISSING",
          },
        },
        generation: {
          update: {
            p50Gwh: draft.annualGenerationGwh,
            p75Gwh: p90ForProfile > 0 ? round((draft.annualGenerationGwh + p90ForProfile) / 2, 1) : draft.annualGenerationGwh,
            p90Gwh: p90ForProfile,
            monthly: monthlyGeneration(draft.annualGenerationGwh, split.solarGwh / Math.max(draft.annualGenerationGwh, 1)) as unknown as Prisma.InputJsonValue,
          },
        },
        tariff: { update: { quotedTariff: draft.tariff, drivers: drivers as unknown as Prisma.InputJsonValue } },
        ...(current.project ? { project: { update: { name: draft.projectName, state: draft.projectState, status: draft.projectStatus, capacityMw: draft.solarMw + draft.windMw, codYear: draft.codYear || current.project.codYear } } } : {}),
        ...(current.execution && draft.codYear ? { execution: { update: { internalCod: new Date(Date.UTC(draft.codYear, 2, 31)), contractualCod: new Date(Date.UTC(draft.codYear, 2, 31)) } } } : {}),
      },
    });
    await saveIppProfile(this.prisma, id, draft.profile);
    if (draft.estimatedCapexCr != null && current.capex) {
      await this.prisma.iPPCapexModel.update({ where: { ippId: id }, data: { totalInrCr: draft.estimatedCapexCr } });
    }
    await syncConnectivity(this.prisma, id, draft.profile.gridConnectivity);
    const links = await this.prisma.gESRequirementIPP.findMany({ where: { ippId: id }, select: { requirement: { select: { gesId: true } } } });
    for (const link of links) await rebuildPair(this.prisma, link.requirement.gesId, id);
    await this.audit.log({ entity: "IPP", entityId: id, action: "UPDATE", oldValue: { name: current.name }, newValue: { name: draft.name }, userId: actor.id });
    return this.ippCatalog();
  }

  async deleteIpp(id: string, actor: Actor) {
    const current = await this.prisma.iPP.findUnique({ where: { id } });
    if (!current) throw new NotFoundException("IPP was not found");
    await this.prisma.iPP.delete({ where: { id } });
    await this.audit.log({ entity: "IPP", entityId: id, action: "DELETE", oldValue: { name: current.name }, userId: actor.id });
    return this.ippCatalog();
  }

  async deleteGes(id: string, actor: Actor) {
    const current = await this.prisma.gES.findUnique({ where: { id } });
    if (!current) throw new NotFoundException("GES account was not found");
    await this.prisma.gES.delete({ where: { id } });
    await this.audit.log({ entity: "GES", entityId: id, action: "DELETE", oldValue: { name: current.name }, userId: actor.id });
    return this.listGes();
  }

  private async assertUniqueName(name: string, ignoreId?: string) {
    const existing = await this.prisma.gES.findFirst({
      where: { name: { equals: name, mode: "insensitive" }, ...(ignoreId ? { NOT: { id: ignoreId } } : {}) },
    });
    if (existing) throw new BadRequestException("A GES account with this name already exists");
  }

  async recalculate(gesId: string, ippIds?: string[]) {
    if (ippIds?.length) {
      for (const ippId of ippIds) await rebuildPair(this.prisma, gesId, ippId);
      return { recalculated: ippIds.length };
    }
    await rebuildGes(this.prisma, gesId);
    return { recalculated: true };
  }

  async updateRequirement(gesId: string, body: Record<string, unknown>, actor: Actor) {
    const ges = await this.prisma.gES.findUnique({ where: { id: gesId }, include: { requirement: true } });
    const current = ges?.requirement;
    if (!ges || !current) throw new NotFoundException("GES requirement was not found");
    const customer = Boolean(actor.gesId);
    const target = "renewableTargetPercent" in body || "renewableEnergyTargetPercent" in body
      ? optionalNumber(body.renewableTargetPercent ?? body.renewableEnergyTargetPercent)
      : current.renewableTargetPercent ?? ges.renewableEnergyTargetPercent;
    const requiredRenewable = target != null && ges.annualConsumptionGwh > 0
      ? round(ges.annualConsumptionGwh * (target / 100), 4)
      : current.requiredRenewableGwh;
    const preferredTechnologies = "preferredTechnology" in body || Array.isArray(body.preferredTechnologies)
      ? technologiesFromPreference(body.preferredTechnology ?? body.preferredTechnologies, current.preferredTechnologies)
      : undefined;
    const bessRequirement = "bessRequirement" in body ? optionalText(body.bessRequirement) : undefined;
    const bessPreference = bessRequirement
      ? engineBess(bessRequirement)
      : body.bessPreference
        ? normalizeBess(body.bessPreference)
        : undefined;
    const hours = bessPreference === "HOURS_4"
      ? { min: 4, max: 4 as number | null }
      : bessPreference === "HOURS_2_TO_4"
        ? { min: 2, max: 4 }
        : bessPreference === "OPTIONAL"
          ? { min: 0, max: null }
          : null;
    const updated = await this.prisma.gESRequirement.update({
      where: { gesId },
      data: {
        annualEnergyGwh: customer
          ? requiredRenewable == null ? undefined : requiredRenewable
          : body.annualEnergyGwh == null ? requiredRenewable ?? undefined : number(body.annualEnergyGwh, current.annualEnergyGwh),
        peakDemandMw: customer || body.peakDemandMw == null ? undefined : number(body.peakDemandMw, current.peakDemandMw),
        requiredCapacityGw: customer || body.requiredCapacityGw == null ? undefined : number(body.requiredCapacityGw, current.requiredCapacityGw),
        targetCodYear: body.targetCodYear == null && body.targetSupplyStartYear == null
          ? undefined
          : number(body.targetSupplyStartYear ?? body.targetCodYear, current.targetCodYear),
        preferredTechnologies,
        bessPreference,
        bessHoursMin: hours ? hours.min : body.bessHoursMin == null ? undefined : number(body.bessHoursMin, 0),
        bessHoursMax: hours ? hours.max : body.bessHoursMax == null ? undefined : number(body.bessHoursMax, 0),
        notes: body.notes == null ? undefined : String(body.notes),
        renewableTargetPercent: target,
        requiredRenewableGwh: requiredRenewable,
        targetTariffInrPerKwh: "targetTariffInrPerKwh" in body ? optionalNumber(body.targetTariffInrPerKwh) : undefined,
        contractTenureYears: "contractTenureYears" in body ? optionalNumber(body.contractTenureYears) : undefined,
        commercialNotes: body.commercialNotes == null ? undefined : String(body.commercialNotes),
      },
    });
    if (target !== ges.renewableEnergyTargetPercent || bessRequirement !== undefined) {
      await saveGesProfile(this.prisma, gesId, {
        renewableEnergyTargetPercent: target,
        sanctionedLoadKw: ges.sanctionedLoadKw,
        solarConnectionType: ges.solarConnectionType,
        peakRecordedDemandKva: ges.peakRecordedDemandKva,
        bessRequirement: bessRequirement === undefined ? ges.bessRequirement : bessRequirement,
      });
    }
    await rebuildGes(this.prisma, gesId);
    await this.audit.log({
      entity: "GESRequirement",
      entityId: current.id,
      action: "UPDATE",
      oldValue: current,
      newValue: updated,
      userId: actor.id,
    });
    return updated;
  }

  async ippBoard(gesId: string) {
    const requirement = await this.prisma.gESRequirement.findUnique({ where: { gesId } });
    if (!requirement) throw new NotFoundException("GES requirement was not found");
    const [links, flags, gates] = await Promise.all([
      this.prisma.gESRequirementIPP.findMany({
        where: { gesRequirementId: requirement.id },
        include: { ipp: { include: { evaluation: true, tariff: true, capex: true, generation: true } } },
      }),
      this.prisma.redFlag.findMany({ where: { gesId, active: true } }),
      this.prisma.criticalGateResult.findMany({ where: { gesId } }),
    ]);
    return links
      .map((link) => {
        const ippFlags = flags.filter((flag) => flag.ippId === link.ippId);
        const ippGates = gates.filter((gate) => gate.ippId === link.ippId);
        return {
          id: link.ippId,
          name: link.ipp.name,
          technology: link.ipp.technologySummary,
          solarMw: link.ipp.solarMw,
          windMw: link.ipp.windMw,
          bessMw: link.ipp.bessMw,
          bessMwh: link.ipp.bessMwh,
          capacityMw: link.ipp.solarMw + link.ipp.windMw,
          generationGwh: link.ipp.annualGenerationGwh,
          p90Gwh: link.ipp.p90Gwh,
          tariff: link.ipp.indicativeTariffInrPerKwh,
          calculatedTariff: link.ipp.tariff?.calculatedTariff ?? null,
          sustainability: link.ipp.tariff?.sustainability ?? null,
          capexInrCr: link.ipp.capex?.totalInrCr ?? null,
          codYear: link.ipp.targetCodYear,
          evaluation: link.ipp.evaluation?.overallScore ?? null,
          suitability: link.suitabilityScore,
          status: link.compatibilityStatus,
          illustrativeSeedStatus: link.illustrativeSeedStatus,
          technicalFit: link.technicalFit,
          commercialFit: link.commercialFit,
          financialFit: link.financialFit,
          generationFit: link.generationFit,
          loadMatch: link.loadMatchScore,
          shortlisted: link.shortlisted,
          gate: rollup(ippGates.map((gate) => gate.status)),
          riskCount: ippFlags.length,
          pendingFrom: link.ipp.pendingFrom,
          evaluationStage: link.ipp.evaluationStage,
          illustrative: true,
        };
      })
      .sort((left, right) => right.suitability - left.suitability);
  }

  async getIpp(gesId: string, ippId: string, actor: Actor) {
    const ipp = await this.prisma.iPP.findUnique({
      where: { id: ippId },
      include: {
        project: true,
        experience: true,
        technology: true,
        solarProfile: true,
        windProfile: true,
        bessProfile: true,
        generation: true,
        ehv: true,
        epc: true,
        execution: true,
        capex: { include: { items: true } },
        financial: true,
        tariff: { include: { components: { orderBy: { sortOrder: "asc" } }, scenarios: { orderBy: { createdAt: "desc" }, take: 8 } } },
        regulatory: true,
        evaluation: { include: { parameters: true } },
        documents: { include: { versions: true } },
      },
    });
    if (!ipp) throw new NotFoundException("IPP was not found");
    const [link, loadMatch, gates, flags, suitabilityRecord] = await Promise.all([
      this.prisma.gESRequirementIPP.findFirst({ where: { ippId, requirement: { gesId } } }),
      this.prisma.loadMatchResult.findUnique({ where: { gesId_ippId: { gesId, ippId } } }),
      this.prisma.criticalGateResult.findMany({ where: { gesId, ippId }, include: { gate: true }, orderBy: { gate: { sortOrder: "asc" } } }),
      this.prisma.redFlag.findMany({ where: { gesId, ippId, active: true } }),
      this.prisma.iPPSuitability.findFirst({ where: { ippId, requirement: { gesId } } }),
    ]);
    const financialAllowed = actor.permissions.includes("FINANCIAL_REVIEW");
    return {
      ...ipp,
      financial: financialAllowed ? ipp.financial : ipp.financial ? { capabilityScore: ipp.financial.capabilityScore, dataQuality: ipp.financial.dataQuality, restricted: true } : null,
      interestRatePct: ipp.financial ? round(ipp.financial.interestRate * 100, 2) : null,
      link,
      suitabilityRecord,
      loadMatch,
      gates,
      redFlags: flags,
      radar: (ipp.evaluation?.parameters ?? []).map((parameter) => ({
        key: parameter.key,
        axis: parameter.shortLabel,
        name: parameter.name,
        score: parameter.score,
        normalized: parameter.normalizedScore,
        weight: parameter.weight,
        contribution: parameter.weightedContribution,
        evidence: parameter.evidence,
        status: parameter.status,
        reviewer: parameter.reviewer,
      })),
      illustrative: true,
    };
  }

  async patchAssumptions(ippId: string, body: Record<string, unknown>, actor: Actor) {
    const ipp = await this.prisma.iPP.findUnique({
      where: { id: ippId },
      include: { capex: { include: { items: true } }, financial: true, tariff: true, solarProfile: true, windProfile: true, bessProfile: true, generation: true },
    });
    if (!ipp?.capex || !ipp.financial || !ipp.tariff) throw new NotFoundException("IPP inputs were not found");
    const drivers = { ...(ipp.tariff.drivers as unknown as TariffDrivers) };
    if (body.capexChangePct != null) {
      const factor = 1 + number(body.capexChangePct, 0) / 100;
      for (const item of ipp.capex.items) {
        await this.prisma.iPPCapexItem.update({ where: { id: item.id }, data: { amountInrCr: round(item.amountInrCr * factor, 2) } });
      }
      const total = round(ipp.capex.totalInrCr * factor, 2);
      drivers.capexInrCr = total;
      drivers.bessCapexInrCr = round(drivers.bessCapexInrCr * factor, 2);
      await this.prisma.iPPCapexModel.update({ where: { ippId }, data: { totalInrCr: total } });
    }
    if (body.interestRatePct != null) {
      drivers.interestRate = number(body.interestRatePct, 0) / 100;
      await this.prisma.iPPFinancialModel.update({ where: { ippId }, data: { interestRate: drivers.interestRate } });
    }
    if (body.interestDeltaPoints != null) {
      drivers.interestRate = ipp.financial.interestRate + number(body.interestDeltaPoints, 0) / 100;
      await this.prisma.iPPFinancialModel.update({ where: { ippId }, data: { interestRate: drivers.interestRate } });
    }
    const ippData: Prisma.IPPUpdateInput = {};
    if (body.bessMw != null) ippData.bessMw = number(body.bessMw, 0);
    if (body.bessMwh != null) ippData.bessMwh = number(body.bessMwh, 0);
    if (body.annualGenerationGwh != null) {
      ippData.annualGenerationGwh = number(body.annualGenerationGwh, 0);
      drivers.generationGwh = number(body.annualGenerationGwh, 0);
      await this.prisma.iPPGenerationProfile.update({ where: { ippId }, data: { p50Gwh: number(body.annualGenerationGwh, 0) } });
    }
    if (body.p90Gwh != null) {
      ippData.p90Gwh = number(body.p90Gwh, 0);
      await this.prisma.iPPGenerationProfile.update({ where: { ippId }, data: { p90Gwh: number(body.p90Gwh, 0) } });
    }
    if (body.quotedTariff != null || body.tariff != null) {
      const quoted = number(body.quotedTariff ?? body.tariff, 0);
      ippData.indicativeTariffInrPerKwh = quoted;
      await this.prisma.iPPTariffModel.update({ where: { ippId }, data: { quotedTariff: quoted } });
    }
    if (body.capexInrCr != null && ipp.capex.totalInrCr > 0) {
      const target = number(body.capexInrCr, ipp.capex.totalInrCr);
      const factor = target / ipp.capex.totalInrCr;
      for (const item of ipp.capex.items) {
        await this.prisma.iPPCapexItem.update({ where: { id: item.id }, data: { amountInrCr: round(item.amountInrCr * factor, 2) } });
      }
      drivers.capexInrCr = target;
      drivers.bessCapexInrCr = round(drivers.bessCapexInrCr * factor, 2);
      await this.prisma.iPPCapexModel.update({ where: { ippId }, data: { totalInrCr: target } });
    }
    if (body.interestRate != null) {
      drivers.interestRate = number(body.interestRate, 0) / 100;
      await this.prisma.iPPFinancialModel.update({ where: { ippId }, data: { interestRate: drivers.interestRate } });
    }
    if (body.codYear != null) ippData.targetCodYear = number(body.codYear, ipp.targetCodYear);
    if (body.solarCufPct != null && ipp.solarProfile) {
      await this.prisma.iPPSolarProfile.update({ where: { ippId }, data: { cuf: number(body.solarCufPct, 0) / 100 } });
    }
    if (body.windCufPct != null && ipp.windProfile) {
      await this.prisma.iPPWindProfile.update({ where: { ippId }, data: { cuf: number(body.windCufPct, 0) / 100 } });
    }
    if (body.bessMw != null || body.bessMwh != null) {
      const power = body.bessMw == null ? ipp.bessMw : number(body.bessMw, 0);
      const energy = body.bessMwh == null ? ipp.bessMwh : number(body.bessMwh, 0);
      await this.prisma.iPPBESSProfile.update({
        where: { ippId },
        data: { powerMw: power, energyMwh: energy, usableEnergyMwh: energy * 0.9, durationHours: power > 0 ? energy / power : 0 },
      });
    }
    await this.prisma.iPPTariffModel.update({ where: { ippId }, data: { drivers: drivers as unknown as Prisma.InputJsonValue } });
    if (Object.keys(ippData).length) await this.prisma.iPP.update({ where: { id: ippId }, data: ippData });
    const links = await this.prisma.gESRequirementIPP.findMany({ where: { ippId }, include: { requirement: true } });
    for (const link of links) await rebuildPair(this.prisma, link.requirement.gesId, ippId);
    await this.audit.log({ entity: "IPP", entityId: ippId, action: "ASSUMPTIONS_UPDATED", newValue: body, userId: actor.id });
    return { recalculated: links.map((link) => link.requirement.gesId) };
  }

  async resetIpp(ippId: string, actor: Actor) {
    const ipp = await this.prisma.iPP.findUnique({ where: { id: ippId }, include: { capex: { include: { items: true } }, tariff: true } });
    if (!ipp?.capex || !ipp.tariff) throw new NotFoundException("IPP was not found");
    const baseline = ipp.baseline as { capexInrCr: number; interestRate: number; bessMw: number; bessMwh: number; solarCuf: number; windCuf: number; generationGwh: number };
    const factor = ipp.capex.totalInrCr > 0 ? baseline.capexInrCr / ipp.capex.totalInrCr : 1;
    for (const item of ipp.capex.items) {
      await this.prisma.iPPCapexItem.update({ where: { id: item.id }, data: { amountInrCr: round(item.amountInrCr * factor, 2) } });
    }
    const drivers = { ...(ipp.tariff.drivers as unknown as TariffDrivers), capexInrCr: baseline.capexInrCr, interestRate: baseline.interestRate, generationGwh: baseline.generationGwh };
    await this.prisma.iPPCapexModel.update({ where: { ippId }, data: { totalInrCr: baseline.capexInrCr } });
    await this.prisma.iPPFinancialModel.update({ where: { ippId }, data: { interestRate: baseline.interestRate } });
    await this.prisma.iPP.update({
      where: { id: ippId },
      data: { bessMw: baseline.bessMw, bessMwh: baseline.bessMwh, annualGenerationGwh: baseline.generationGwh },
    });
    await this.prisma.iPPSolarProfile.update({ where: { ippId }, data: { cuf: baseline.solarCuf } });
    await this.prisma.iPPWindProfile.update({ where: { ippId }, data: { cuf: baseline.windCuf } });
    await this.prisma.iPPBESSProfile.update({
      where: { ippId },
      data: { powerMw: baseline.bessMw, energyMwh: baseline.bessMwh, usableEnergyMwh: baseline.bessMwh * 0.9 },
    });
    await this.prisma.iPPTariffModel.update({ where: { ippId }, data: { drivers: drivers as unknown as Prisma.InputJsonValue } });
    await this.patchAssumptions(ippId, {}, actor);
    return { reset: true };
  }

  async tariffScenario(ippId: string, body: Record<string, unknown>, actor: Actor) {
    const ipp = await this.prisma.iPP.findUnique({
      where: { id: ippId },
      include: { tariff: true, financial: true },
    });
    if (!ipp?.tariff || !ipp.financial) throw new NotFoundException("Tariff model was not found");
    const drivers = ipp.tariff.drivers as unknown as TariffDrivers;
    const scenario = {
      capexChangePct: body.capexChangePct == null ? 0 : number(body.capexChangePct, 0),
      interestChangePctPoints: body.interestChangePctPoints == null ? number(body.interestChangePct, 0) : number(body.interestChangePctPoints, 0),
      codDelayMonths: body.codDelayMonths == null ? 0 : number(body.codDelayMonths, 0),
      cufReductionPct: body.cufReductionPct == null ? 0 : number(body.cufReductionPct, 0),
      bessCostChangePct: body.bessCostChangePct == null ? 0 : number(body.bessCostChangePct, 0),
    };
    const compared = this.tariffSensitivity.compare(drivers, scenario);
    const financial = this.finance.assess(drivers, ipp.tariff.quotedTariff, ipp.financial.lenderIdentified, ipp.financial.fundraisingDependency);
    const scenarioFinance = this.finance.assess(
      { ...drivers, capexInrCr: drivers.capexInrCr * (1 + scenario.capexChangePct / 100), interestRate: drivers.interestRate + scenario.interestChangePctPoints / 100, generationGwh: drivers.generationGwh * (1 - scenario.cufReductionPct / 100) },
      ipp.tariff.quotedTariff,
      ipp.financial.lenderIdentified,
      ipp.financial.fundraisingDependency,
    );
    const saved = await this.prisma.iPPTariffScenario.create({
      data: {
        modelId: ipp.tariff.id,
        name: scenarioName(scenario),
        assumptions: scenario,
        baseTariff: compared.baseTariff,
        scenarioTariff: compared.scenarioTariff,
        change: compared.change,
        changePct: compared.changePct,
        financial: {
          baseDscr: financial.dscr,
          scenarioDscr: scenarioFinance.dscr,
          scenarioEquityIrr: scenarioFinance.equityIrr,
          components: compared.scenario.components,
        } as unknown as Prisma.InputJsonValue,
      },
    });
    await this.audit.log({ entity: "IPPTariffScenario", entityId: saved.id, action: "SCENARIO", newValue: scenario, userId: actor.id });
    return {
      illustrative: true,
      unit: "INR/kWh",
      quotedTariff: ipp.tariff.quotedTariff,
      baseTariff: compared.baseTariff,
      scenarioTariff: compared.scenarioTariff,
      change: compared.change,
      changePct: compared.changePct,
      components: compared.scenario.components,
      baseComponents: compared.base.components,
      financial: { base: financial, scenario: scenarioFinance },
    };
  }

  async comparison(gesId: string, ippIds: string[], actor: Actor) {
    const unique = [...new Set(ippIds.filter(Boolean))];
    if (unique.length > 3) throw new BadRequestException("Compare a maximum of three IPPs");
    if (!unique.length) throw new BadRequestException("Select at least one IPP");
    const ges = await this.getGes(gesId);
    const rows = [];
    for (const ippId of unique) rows.push(await this.getIpp(gesId, ippId, actor));
    const profiles = await loadIppProfiles(this.prisma, unique);
    const existing = await this.prisma.comparison.findFirst({ where: { gesId, working: true } });
    if (existing) {
      await this.prisma.comparisonIPP.deleteMany({ where: { comparisonId: existing.id } });
      await this.prisma.comparisonIPP.createMany({ data: unique.map((ippId, position) => ({ comparisonId: existing.id, ippId, position })) });
    }
    return {
      illustrative: true,
      ges: {
        id: ges.id,
        name: ges.name,
        annualEnergyGwh: ges.requirement?.annualEnergyGwh,
        peakDemandMw: ges.requirement?.peakDemandMw,
        requiredCapacityGw: ges.requirement?.requiredCapacityGw,
        targetCodYear: ges.requirement?.targetCodYear,
        technologies: ges.requirement?.preferredTechnologies,
        bessPreference: ges.bessLabel,
        evaluationStage: ges.evaluationStage,
        crmStage: ges.crmStage,
      },
      ipps: rows.map((row) => ({
        id: row.id,
        name: row.name,
        technology: row.technologySummary,
        solarMw: row.solarMw,
        windMw: row.windMw,
        bessMw: row.bessMw,
        bessMwh: row.bessMwh,
        capacityMw: row.solarMw + row.windMw,
        generationGwh: row.annualGenerationGwh,
        p90Gwh: row.p90Gwh,
        tariff: row.indicativeTariffInrPerKwh,
        calculatedTariff: row.tariff?.calculatedTariff,
        sustainability: row.tariff?.sustainability,
        capexInrCr: row.capex?.totalInrCr,
        codYear: row.targetCodYear,
        evaluation: row.evaluation?.overallScore,
        suitability: row.link?.suitabilityScore,
        status: row.link?.compatibilityStatus,
        loadMatch: row.loadMatch,
        radar: row.radar,
        gates: row.gates,
        redFlags: row.redFlags,
        tariffComponents: row.tariff?.components ?? [],
        register: registerForComparison(row, profiles.get(row.id)),
      })),
    };
  }

  async setShortlist(gesId: string, ippId: string, shortlisted: boolean, actor: Actor) {
    const requirement = await this.prisma.gESRequirement.findUnique({ where: { gesId } });
    if (!requirement) throw new NotFoundException("GES requirement was not found");
    const current = await this.prisma.gESRequirementIPP.findUnique({ where: { gesRequirementId_ippId: { gesRequirementId: requirement.id, ippId } } });
    if (!current) throw new NotFoundException("This IPP is not linked to the selected GES");
    if (shortlisted) {
      const gates = await this.prisma.criticalGateResult.findMany({ where: { gesId, ippId } });
      const eligibility = eligibilityFromGates(gates);
      if (eligibility.status === "NOT_ELIGIBLE") throw new BadRequestException("Blocking required checks must pass before shortlisting.");
      if (eligibility.status === "PENDING_REVIEW") throw new BadRequestException("Required checks are still pending review.");
    }
    const updated = await this.prisma.gESRequirementIPP.update({
      where: { gesRequirementId_ippId: { gesRequirementId: requirement.id, ippId } },
      data: { shortlisted },
    });
    await this.audit.log({ entity: "GESRequirementIPP", entityId: updated.id, action: shortlisted ? "SHORTLIST" : "UNSHORTLIST", userId: actor.id, oldValue: { shortlisted: current.shortlisted }, newValue: { ippId, shortlisted } });
    return updated;
  }

  async listNegotiations(gesId: string) {
    return this.prisma.negotiation.findMany({
      where: { gesId },
      include: { ipp: true, offers: { orderBy: { version: "asc" }, include: { createdBy: true } } },
      orderBy: { updatedAt: "desc" },
    });
  }

  async addOfferToNegotiation(negotiationId: string, body: Record<string, unknown>, actor: Actor) {
    const negotiation = await this.prisma.negotiation.findUnique({ where: { id: negotiationId } });
    if (!negotiation) throw new NotFoundException("Negotiation was not found");
    return this.addOffer(negotiation.gesId, { ...body, ippId: body.ippId || negotiation.ippId }, actor);
  }

  async addOffer(gesId: string, body: Record<string, unknown>, actor: Actor) {
    const ippId = String(body.ippId || "");
    let negotiation = await this.prisma.negotiation.findUnique({ where: { gesId_ippId: { gesId, ippId } }, include: { offers: true } });
    if (!negotiation) {
      negotiation = await this.prisma.negotiation.create({
        data: { id: `neg_${gesId}_${ippId}`, gesId, ippId, status: "OPEN" },
        include: { offers: true },
      });
    }
    const version = negotiation.offers.reduce((max, offer) => Math.max(max, offer.version), 0) + 1;
    if (version > 1) {
      await this.prisma.negotiationOffer.updateMany({ where: { negotiationId: negotiation.id, status: "OPEN" }, data: { status: "SUPERSEDED" } });
    }
    const created = await this.prisma.negotiationOffer.create({
      data: {
        negotiationId: negotiation.id,
        version,
        offerType: (body.offerType as never) || "COUNTER_OFFER",
        tariff: number(body.tariff, 0),
        codYear: number(body.codYear, 2030),
        bessSummary: String(body.bessSummary || ""),
        paymentTerms: String(body.paymentTerms || ""),
        changeInLaw: String(body.changeInLaw || ""),
        curtailment: String(body.curtailment || ""),
        performanceGuarantee: String(body.performanceGuarantee || ""),
        riskAllocation: String(body.riskAllocation || ""),
        otherTerms: String(body.otherTerms || ""),
        status: "OPEN",
        createdById: actor.id,
      },
    });
    await this.prisma.negotiation.update({ where: { id: negotiation.id }, data: { status: String(body.offerType || "COUNTER_OFFER") } });
    await this.audit.log({ entity: "NegotiationOffer", entityId: created.id, action: "CREATE", newValue: created, userId: actor.id });
    return this.prisma.negotiation.findUnique({ where: { id: negotiation.id }, include: { ipp: true, offers: { orderBy: { version: "asc" } } } });
  }

  async getPsoa(gesId: string, ippId?: string) {
    return this.prisma.psoa.findMany({ where: { gesId, ...(ippId ? { ippId } : {}) }, include: { ipp: true } });
  }

  async savePsoa(gesId: string, body: Record<string, unknown>, actor: Actor) {
    const ippId = String(body.ippId);
    const saved = await this.prisma.psoa.upsert({
      where: { gesId_ippId: { gesId, ippId } },
      create: { id: `psoa_${gesId}_${ippId}`, gesId, ippId, items: (body.items ?? []) as Prisma.InputJsonValue, status: String(body.status || "IN_REVIEW") },
      update: { items: (body.items ?? []) as Prisma.InputJsonValue, status: String(body.status || "IN_REVIEW") },
    });
    await this.audit.log({ entity: "PSOA", entityId: saved.id, action: "UPDATE", newValue: body.items, userId: actor.id });
    return saved;
  }

  async dealbook(gesId: string, ippId: string, actor: Actor) {
    const comparison = await this.comparison(gesId, [ippId], actor);
    const [documents, negotiation, psoa, tasks, audits, stored] = await Promise.all([
      this.prisma.document.findMany({ where: { OR: [{ gesId }, { ippId }] }, include: { versions: true } }),
      this.listNegotiations(gesId),
      this.getPsoa(gesId, ippId),
      this.prisma.task.findMany({ where: { gesId, ippId } }),
      this.prisma.auditLog.findMany({ where: { OR: [{ entityId: gesId }, { entityId: ippId }] }, orderBy: { createdAt: "desc" }, take: 30 }),
      this.prisma.dealbook.findUnique({ where: { gesId_ippId: { gesId, ippId } } }),
    ]);
    return {
      illustrative: true,
      comparison,
      documents,
      negotiation: negotiation.filter((item) => item.ippId === ippId),
      psoa,
      tasks,
      audits,
      recommendation: stored?.recommendation ?? "No decision has been recorded yet.",
      conditions: stored?.conditions ?? "",
      approvals: stored?.approvals ?? [],
    };
  }

  async documents(gesId?: string, ippId?: string) {
    return this.prisma.document.findMany({
      where: { ...(gesId ? { gesId } : {}), ...(ippId ? { ippId } : {}) },
      include: { versions: true, ipp: true, ges: true },
      orderBy: { updatedAt: "desc" },
    });
  }

  tasks(gesId?: string) {
    return this.prisma.task.findMany({ where: gesId ? { gesId } : {}, include: { owner: true, ipp: true, ges: true }, orderBy: { dueDate: "asc" } });
  }

  listAudit(entity?: string) {
    return this.prisma.auditLog.findMany({ where: entity ? { entity } : {}, include: { user: true }, orderBy: { createdAt: "desc" }, take: 100 });
  }

  users() {
    return this.prisma.user.findMany({ include: { roles: { include: { role: true } } }, orderBy: { name: "asc" } }).then((rows) => rows.map((user) => ({
      id: user.id, name: user.name, email: user.email, title: user.title, roles: user.roles.map((role) => role.role.name),
    })));
  }

  roles() {
    return this.prisma.role.findMany({ include: { permissions: { include: { permission: true } } } });
  }

  toGesAccount(ges: {
    id: string;
    name: string;
    location: string;
    state: string;
    businessType: string;
    evaluationStage: string;
    requirement: {
      annualEnergyGwh: number;
      peakDemandMw: number;
      requiredCapacityGw: number;
      targetCodYear: number;
      preferredTechnologies: string[];
      bessPreference: string;
      bessHoursMin: number | null;
      bessHoursMax: number | null;
      renewableTargetPercent?: number | null;
      requiredRenewableGwh?: number | null;
      targetTariffInrPerKwh?: number | null;
      contractTenureYears?: number | null;
      commercialNotes?: string;
      notes?: string;
    } | null;
  }, averageSuitability = 0) {
    return {
      id: ges.id,
      code: GES_CODES[ges.id] ?? "GES",
      name: ges.name,
      location: `${ges.location}, ${ges.state}`,
      businessType: ges.businessType,
      stage: ges.evaluationStage,
      averageSuitability,
      candidateCount: undefined,
      requirement: {
        annualEnergyGwh: ges.requirement?.annualEnergyGwh ?? 0,
        peakDemandMw: ges.requirement?.peakDemandMw ?? 0,
        requiredCapacityGw: ges.requirement?.requiredCapacityGw ?? 0,
        targetCodYear: ges.requirement?.targetCodYear ?? 0,
        preferredTechnologies: ges.requirement?.preferredTechnologies ?? [],
        bessPreference: ges.requirement?.bessPreference ?? "OPTIONAL",
        bessHoursMin: ges.requirement?.bessHoursMin ?? null,
        bessHoursMax: ges.requirement?.bessHoursMax ?? null,
        renewableTargetPercent: ges.requirement?.renewableTargetPercent ?? null,
        requiredRenewableGwh: ges.requirement?.requiredRenewableGwh ?? null,
        targetTariffInrPerKwh: ges.requirement?.targetTariffInrPerKwh ?? null,
        contractTenureYears: ges.requirement?.contractTenureYears ?? null,
        commercialNotes: ges.requirement?.commercialNotes ?? "",
        notes: ges.requirement?.notes ?? "",
      },
    };
  }

  async providerOptions(gesId: string) {
    const board = await this.ippBoard(gesId);
    return board.map((row) => ({
      id: row.id,
      name: row.name,
      code: IPP_CODES[row.id] ?? "IPP",
      technology: row.technology.split(" + ").filter(Boolean),
      suitability: row.suitability,
    }));
  }

  async presentComparison(gesId: string, ippIds: string[], actor: Actor) {
    const unique = [...new Set(ippIds.filter(Boolean))].slice(0, 3);
    if (!unique.length) throw new BadRequestException("Select at least one IPP");
    const ges = await this.prisma.gES.findUnique({ where: { id: gesId }, include: { requirement: true } });
    if (!ges?.requirement) throw new NotFoundException("GES account was not found");
    const board = await this.ippBoard(gesId);
    const matches = await this.prisma.loadMatchResult.findMany({ where: { gesId } });
    const selected: Awaited<ReturnType<EnergyService["getIpp"]>>[] = [];
    for (const ippId of unique) selected.push(await this.getIpp(gesId, ippId, actor));
    const profiles = await loadIppProfiles(this.prisma, unique);
    const gesProfiles = await loadGesProfiles(this.prisma, [ges.id]);
    const gesProfile = gesProfiles.get(ges.id);
    const account = this.toGesAccount(ges, average(board.map((row) => row.suitability)));
    const radarData = (selected[0]?.radar ?? []).map((axis) => {
      const row: Record<string, string | number> = { factor: axis.axis };
      selected.forEach((ipp) => {
        row[ipp.id] = ipp.radar.find((item) => item.key === axis.key)?.normalized ?? 0;
      });
      return row;
    });
    const best = [...board].sort((left, right) => right.suitability - left.suitability)[0];
    return {
      illustrative: true,
      ges: {
        ...account,
        annualConsumptionGwh: ges.annualConsumptionGwh,
        existingRooftopMw: ges.existingRooftopMw,
        existingRenewableGwh: ges.existingRenewableGwh,
        contractDemandMw: ges.contractDemandMw,
        renewableEnergyTargetPercent: gesProfile?.renewableEnergyTargetPercent ?? null,
        peakRecordedDemandKva: gesProfile?.peakRecordedDemandKva ?? null,
        bessRequirement: gesProfile?.bessRequirement ?? null,
      },
      requirements: account.requirement,
      providerOptions: board.map((row) => ({
        id: row.id,
        name: row.name,
        code: IPP_CODES[row.id] ?? "IPP",
        technology: row.technology.split(" + ").filter(Boolean),
        suitability: row.suitability,
      })),
      selectedIpps: selected.map((ipp) => {
        const provider = this.toProvider(ipp);
        return {
          ...provider,
          ipp: { ...provider.ipp, register: registerForComparison(ipp, profiles.get(ipp.id)), shortlisted: Boolean(ipp.link?.shortlisted) },
          requirementComparison: explainRequirement(ges.requirement, ipp, provider.suitability.dimensions),
          shortlistEligibility: eligibilityFromGates(provider.gates),
        };
      }),
      radarData,
      technologyMix: board.map((row) => ({
        id: row.id,
        name: row.name,
        code: IPP_CODES[row.id] ?? "IPP",
        solarMw: row.solarMw,
        windMw: row.windMw,
        bessMw: row.bessMw,
      })),
      comparisonTable: board.map((row) => {
        const match = matches.find((item) => item.ippId === row.id);
        return {
          id: row.id,
          name: row.name,
          code: IPP_CODES[row.id] ?? "IPP",
          technology: row.technology,
          capacityMw: row.capacityMw,
          annualGenerationGwh: row.generationGwh,
          p90Gwh: row.p90Gwh,
          bessMw: row.bessMw,
          bessMwh: row.bessMwh,
          tariff: row.tariff,
          capexInrCr: row.capexInrCr,
          targetCodYear: row.codYear,
          evaluationScore: row.evaluation,
          suitability: row.suitability,
          loadMatchPct: match?.loadMatchPct ?? row.loadMatch,
          coveragePct: match?.coveragePct ?? 0,
          criticalGate: row.gate,
          shortlisted: row.shortlisted,
          riskCount: row.riskCount,
          financialScore: row.financialFit,
        };
      }),
      summary: {
        averageSuitability: average(board.map((row) => row.suitability)),
        bestSuitability: best?.suitability ?? 0,
        bestProviderId: best?.id ?? "",
        bestProviderName: best?.name ?? "",
      },
    };
  }

  toProvider(ipp: Awaited<ReturnType<EnergyService["getIpp"]>>) {
    const scenario = ipp.tariff?.scenarios?.[0];
    const scenarioFinancial = scenario?.financial as { components?: { label: string; amount: number }[]; baseDscr?: number; scenarioDscr?: number } | null;
    const financial = ipp.financial && !("restricted" in ipp.financial) ? ipp.financial : null;
    return {
      ipp: {
        id: ipp.id,
        code: IPP_CODES[ipp.id] ?? "IPP",
        name: ipp.name,
        technology: ipp.technologySummary.split(" + ").filter(Boolean),
        solarMw: ipp.solarMw,
        windMw: ipp.windMw,
        bessMw: ipp.bessMw,
        bessMwh: ipp.bessMwh,
        annualGenerationGwh: ipp.annualGenerationGwh,
        p90Gwh: ipp.p90Gwh,
        tariff: ipp.indicativeTariffInrPerKwh,
        targetCodYear: ipp.targetCodYear,
        scores: Object.fromEntries((ipp.evaluation?.parameters ?? []).map((parameter) => [parameter.key, parameter.score])),
        capexInrCr: ipp.capex?.totalInrCr ?? 0,
        interestRate: ipp.interestRatePct ?? 0,
        dscr: financial?.dscr ?? 0,
        bessDurationHours: ipp.bessProfile?.durationHours ?? 0,
        technologyDetails: {},
      },
      evaluation: {
        overallScore: ipp.evaluation?.overallScore ?? 0,
        parameters: (ipp.evaluation?.parameters ?? []).map((parameter) => ({
          key: parameter.key,
          label: parameter.name,
          shortLabel: parameter.shortLabel,
          score: parameter.score,
          normalizedScore: parameter.normalizedScore,
          weight: parameter.weight,
          weightedContribution: parameter.weightedContribution,
          evidence: parameter.evidence,
          status: parameter.status,
          reviewer: parameter.reviewer,
        })),
      },
      suitability: {
        overallPct: ipp.link?.suitabilityScore ?? 0,
        status: ipp.link?.compatibilityStatus ?? "CONDITIONAL",
        dimensions: ((ipp.suitabilityRecord?.dimensions as { key: string; label: string; weight: number; score: number; contribution: number }[] | null) ?? []).map((dimension) => ({
          key: dimension.key,
          label: dimension.label,
          weight: dimension.weight,
          score: dimension.score,
          weightedContribution: dimension.contribution,
        })),
      },
      loadMatch: {
        requiredGwh: ipp.loadMatch?.requiredGwh ?? 0,
        availableGwh: ipp.loadMatch?.availableGwh ?? 0,
        matchedGwh: ipp.loadMatch?.matchedGwh ?? 0,
        surplusGwh: ipp.loadMatch?.surplusGwh ?? 0,
        deficitGwh: ipp.loadMatch?.deficitGwh ?? 0,
        loadMatchPct: ipp.loadMatch?.loadMatchPct ?? 0,
        coveragePct: ipp.loadMatch?.coveragePct ?? 0,
        intervals: ((ipp.loadMatch?.series as { t: string; loadMw: number; generationMw: number; matchedMw: number; bessMw: number }[] | null) ?? []).map((point) => ({
          time: point.t,
          loadMw: point.loadMw,
          generationMw: point.generationMw,
          matchedMw: point.matchedMw,
          bessSupportMw: point.bessMw,
        })),
      },
      tariff: {
        baseTariff: ipp.tariff?.calculatedTariff ?? ipp.indicativeTariffInrPerKwh,
        scenarioTariff: scenario?.scenarioTariff ?? ipp.tariff?.calculatedTariff ?? ipp.indicativeTariffInrPerKwh,
        change: scenario?.change ?? 0,
        changePct: scenario?.changePct ?? 0,
        sustainability: ipp.tariff?.sustainability ?? "AGGRESSIVE",
        tariffScore: ipp.evaluation?.parameters.find((parameter) => parameter.key === "tariff")?.score ?? 0,
        baseDscr: scenarioFinancial?.baseDscr ?? financial?.dscr ?? 0,
        scenarioDscr: scenarioFinancial?.scenarioDscr ?? financial?.dscr ?? 0,
        buildUp: (scenarioFinancial?.components ?? ipp.tariff?.components ?? []).map((component) => ({
          label: component.label,
          amount: component.amount,
        })),
      },
      financial: {
        score: financial?.capabilityScore ?? ipp.evaluation?.parameters.find((parameter) => parameter.key === "financial")?.score ?? 0,
        interestRatePct: ipp.interestRatePct ?? 0,
        debtEquityRatio: financial?.debtEquityRatio ?? 0,
        dscr: financial?.dscr ?? 0,
        equitySharePct: financial ? round((1 / (1 + financial.debtEquityRatio)) * 100, 1) : 0,
        projectIrrPct: financial?.projectIrr ?? 0,
        equityIrrPct: financial?.equityIrr ?? 0,
        lender: financial?.lenderExperience ?? "Restricted",
        fundraisingDependency: financial?.fundraisingDependency ?? false,
      },
      gates: ipp.gates.map((gate) => ({ name: gate.gate.name, status: gate.status, rationale: gate.rationale, blocking: true })),
      redFlags: ipp.redFlags.map((flag) => ({ category: flag.category, severity: flag.severity, title: flag.title, detail: flag.detail })),
      technologyDetails: {},
      documents: ipp.documents.map((document) => ({
        id: document.id,
        title: document.title,
        category: document.category,
        status: document.status,
        version: document.versions.at(-1)?.version ?? 1,
        owner: document.pendingFrom,
        pendingFrom: document.pendingFrom,
        comments: document.comments,
      })),
      tasks: [],
    };
  }

  async flatOffers(gesId: string) {
    const negotiations = await this.listNegotiations(gesId);
    return negotiations.flatMap((negotiation) => negotiation.offers.map((offer) => ({
      id: offer.id,
      ippId: negotiation.ippId,
      version: offer.version,
      offerType: offer.offerType,
      tariff: offer.tariff,
      codYear: offer.codYear,
      status: offer.status,
      createdBy: offer.createdBy?.name ?? "NewRa",
      createdAt: offer.createdAt.toISOString(),
      paymentTerms: offer.paymentTerms,
      otherTerms: offer.otherTerms,
    })));
  }

  async psoaRecords(gesId: string, ippId?: string) {
    if (ippId) {
      const existing = await this.prisma.psoa.findUnique({ where: { gesId_ippId: { gesId, ippId } } });
      if (!existing) {
        const labels = ["Corporate credentials", "Comparable projects", "Financial evidence", "Technical evidence", "Generation methodology", "FDRE", "BESS", "EHV", "CAPEX", "Financial model", "Tariff", "Execution schedule", "Regulatory protection", "COD", "NewRa integration"];
        await this.prisma.psoa.create({
          data: {
            id: `psoa_${gesId}_${ippId}`,
            gesId,
            ippId,
            status: "IN_REVIEW",
            items: labels.map((name) => ({ name, status: "PENDING" })),
          },
        });
      }
    }
    const rows = await this.getPsoa(gesId, ippId);
    return rows.map((row) => ({
      ippId: row.ippId,
      ippName: row.ipp.name,
      status: row.status,
      items: ((row.items as { label?: string; name?: string; status: string }[]) ?? []).map((item) => ({
        name: item.name ?? item.label ?? "Item",
        status: item.status,
      })),
    }));
  }

  async updatePsoaItem(gesId: string, ippId: string, body: { item?: string; status?: string }, actor: Actor) {
    const current = await this.prisma.psoa.findUnique({ where: { gesId_ippId: { gesId, ippId } } });
    const items = ((current?.items as { label?: string; name?: string; status: string; note?: string }[]) ?? []).map((item) => {
      const name = item.name ?? item.label;
      if (name === body.item) return { ...item, name, status: body.status ?? item.status };
      return { ...item, name };
    });
    return this.savePsoa(gesId, { ippId, items, status: current?.status ?? "IN_REVIEW" }, actor);
  }

  async documentRows(gesId: string) {
    const rows = await this.prisma.document.findMany({
      where: { OR: [{ gesId }, { ipp: { links: { some: { requirement: { gesId } } } } }] },
      include: { versions: true, owner: true },
      orderBy: { title: "asc" },
    });
    return rows.map((document) => ({
      id: document.id,
      category: document.category,
      title: document.title,
      status: document.status,
      version: document.versions.at(-1)?.version ?? 1,
      owner: document.owner?.name ?? "Unassigned",
      pendingFrom: document.pendingFrom,
      location: document.location,
      comments: document.comments,
    }));
  }

  async updateDocument(id: string, status: string, actor: Actor) {
    const updated = await this.prisma.document.update({ where: { id }, data: { status: status as never } });
    await this.audit.log({ entity: "Document", entityId: id, action: "STATUS", newValue: { status }, userId: actor.id });
    return updated;
  }

  async dealbooks(gesId: string, actor: Actor) {
    const board = await this.ippBoard(gesId);
    const focus = board.filter((row) => row.shortlisted).slice(0, 4);
    const chosen = focus.length ? focus : board.slice(0, 3);
    const ges = await this.prisma.gES.findUnique({ where: { id: gesId }, include: { requirement: true } });
    if (!ges) throw new NotFoundException("GES account was not found");
    const records = [];
    for (const row of chosen) {
      const ipp = await this.getIpp(gesId, row.id, actor);
      const provider = this.toProvider(ipp);
      const negotiations = await this.flatOffers(gesId);
      records.push({
        ges: {
          code: GES_CODES[gesId] ?? "GES",
          name: ges.name,
          requirement: {
            annualEnergyGwh: ges.requirement?.annualEnergyGwh ?? 0,
            peakDemandMw: ges.requirement?.peakDemandMw ?? 0,
            targetCodYear: ges.requirement?.targetCodYear ?? 0,
          },
        },
        ipp: { id: ipp.id, code: IPP_CODES[ipp.id] ?? "IPP", name: ipp.name },
        evaluation: provider.evaluation,
        suitability: provider.suitability,
        gates: provider.gates,
        redFlags: provider.redFlags,
        technical: { solarMw: ipp.solarMw, windMw: ipp.windMw, engineeringScore: provider.ipp.scores.engineering ?? 0 },
        commercial: {
          tariff: { scenarioTariff: provider.tariff.scenarioTariff, sustainability: provider.tariff.sustainability },
          capexInrCr: provider.ipp.capexInrCr,
          annualGenerationGwh: ipp.annualGenerationGwh,
          p90Gwh: ipp.p90Gwh,
          codYear: ipp.targetCodYear,
        },
        financial: { score: provider.financial.score, dscr: provider.financial.dscr, interestRatePct: provider.financial.interestRatePct, lender: provider.financial.lender },
        generation: provider.loadMatch,
        bess: {
          powerMw: ipp.bessMw,
          energyMwh: ipp.bessMwh,
          durationHours: ipp.bessProfile?.durationHours ?? 0,
          yearSnapshots: (ipp.bessProfile?.yearSnapshots as { year: number; usableMwh: number }[]) ?? [],
        },
        ehv: { status: ipp.ehv?.connectivityStatus ?? "PRELIMINARY", capabilityScore: ipp.ehv?.capabilityScore ?? 0, projectApprovalConfirmed: ipp.ehv?.connectivityStatus === "APPROVED" },
        negotiationHistory: negotiations.filter((offer) => offer.ippId === ipp.id),
        documents: provider.documents,
        tasks: [],
        conditions: provider.gates.filter((gate) => gate.status !== "PASS"),
      });
    }
    return records;
  }

  async comparisonWorkbook(payload: Awaited<ReturnType<EnergyService["comparison"]>>) {
    const workbook = new Workbook();
    const sheet = workbook.addWorksheet("Comparison");
    sheet.addRow(["NEWRA GES IPP Comparator"]);
    sheet.addRow(["Illustrative demo data"]);
    sheet.addRow(["GES", payload.ges.name, payload.ges.annualEnergyGwh, "GWh", payload.ges.peakDemandMw, "MW peak"]);
    sheet.addRow([]);
    sheet.addRow(["IPP", "Technology", "Capacity MW", "Generation GWh", "P90 GWh", "BESS MW", "Tariff", "CAPEX INR Cr", "COD", "Evaluation", "Suitability", "Load match", "Coverage", "Gate", "Risks"]);
    payload.ipps.forEach((ipp) => {
      const gate = rollup(ipp.gates.map((item) => item.status));
      sheet.addRow([
        ipp.name, ipp.technology, ipp.capacityMw, ipp.generationGwh, ipp.p90Gwh, ipp.bessMw, ipp.tariff, ipp.capexInrCr, ipp.codYear,
        ipp.evaluation, ipp.suitability, ipp.loadMatch?.loadMatchPct, ipp.loadMatch?.coveragePct, gate, ipp.redFlags.length,
      ]);
    });
    const radar = workbook.addWorksheet("Radar");
    radar.addRow(["Axis", ...payload.ipps.map((ipp) => ipp.name)]);
    const axes = payload.ipps[0]?.radar ?? [];
    axes.forEach((axis) => {
      radar.addRow([axis.name, ...payload.ipps.map((ipp) => ipp.radar.find((item) => item.key === axis.key)?.normalized ?? "")]);
    });
    return Buffer.from(await workbook.xlsx.writeBuffer());
  }

  async comparisonPdf(payload: Awaited<ReturnType<EnergyService["comparison"]>>) {
    return this.renderPdf(`${payload.ges.name} comparison`, [
      "Illustrative demo data. Not a market quote.",
      `${payload.ges.annualEnergyGwh} GWh · ${payload.ges.peakDemandMw} MW peak · ${payload.ges.requiredCapacityGw} GW · COD ${payload.ges.targetCodYear}`,
      ...payload.ipps.flatMap((ipp) => [
        `${ipp.name}: evaluation ${ipp.evaluation}/100, suitability ${ipp.suitability}%, tariff ₹${ipp.tariff}/kWh, gate ${rollup(ipp.gates.map((gate) => gate.status))}`,
        `Radar: ${ipp.radar.map((item) => `${item.axis} ${item.normalized}`).join(", ")}`,
        `Flags: ${ipp.redFlags.map((flag) => flag.title).join("; ") || "None"}`,
      ]),
    ]);
  }

  private renderPdf(title: string, lines: string[]) {
    return new Promise<Buffer>((resolve, reject) => {
      const document = new PDFDocument({ margin: 48 });
      const chunks: Buffer[] = [];
      document.on("data", (chunk) => chunks.push(chunk as Buffer));
      document.on("end", () => resolve(Buffer.concat(chunks)));
      document.on("error", reject);
      document.fontSize(18).text("NEWRA — GES IPP Comparator");
      document.moveDown(0.4);
      document.fontSize(14).text(title);
      document.moveDown();
      document.fontSize(10);
      lines.forEach((line) => {
        document.text(line, { width: 500 });
        document.moveDown(0.4);
      });
      document.end();
    });
  }
}

type IppProfileWrite = {
  projectDistrict: string | null;
  projectLocation: string | null;
  generationData15Min: string | null;
  fdreCapability: string | null;
  gridVoltage: string | null;
  gridConnectivity: string | null;
  openAccessReadiness: string | null;
  tariffType: string | null;
  contractTenureYears: number | null;
  codConfidence: string | null;
  financialModelAvailable: string | null;
  fundingStatus: string | null;
};

type IppDraftWrite = {
  name: string;
  projectName: string;
  headquarters: string;
  projectState: string;
  projectStatus: string;
  technology: string;
  solarMw: number;
  windMw: number;
  bessMw: number;
  bessMwh: number;
  annualGenerationGwh: number;
  p90Gwh: number | null;
  tariff: number;
  codYear: number | null;
  estimatedCapexCr: number | null;
  profile: IppProfileWrite;
};

function emptyIppProfile(): IppProfileWrite {
  return {
    projectDistrict: null,
    projectLocation: null,
    generationData15Min: null,
    fdreCapability: null,
    gridVoltage: null,
    gridConnectivity: null,
    openAccessReadiness: null,
    tariffType: null,
    contractTenureYears: null,
    codConfidence: null,
    financialModelAvailable: null,
    fundingStatus: null,
  };
}

function technologyParts(label: string) {
  const parts = label.split("+").map((part) => part.trim().toUpperCase());
  return { solar: parts.includes("SOLAR"), wind: parts.includes("WIND"), bess: parts.includes("BESS") };
}

function choice(value: unknown, allowed: string[]): string | null {
  const text = String(value ?? "").trim();
  if (!text) return null;
  if (!allowed.includes(text)) throw new BadRequestException("Select one of the listed options");
  return text;
}

function ippWrite(body: Record<string, unknown>, current?: IppDraftWrite): IppDraftWrite {
  const name = String(body.name ?? current?.name ?? "").trim();
  if (!name) throw new BadRequestException("IPP name is required");
  const projectName = String(body.projectName ?? current?.projectName ?? "").trim();
  if (!projectName) throw new BadRequestException("Project name is required");
  const projectState = String(body.projectState ?? current?.projectState ?? "").trim();
  if (!projectState) throw new BadRequestException("Project state is required");
  const technology = String(body.technology ?? current?.technology ?? "").trim();
  const parts = technologyParts(technology);
  if (!parts.solar && !parts.wind) throw new BadRequestException("Select a technology");
  const solarMw = parts.solar ? optionalNumber(body.solarMw) ?? current?.solarMw ?? 0 : 0;
  const windMw = parts.wind ? optionalNumber(body.windMw) ?? current?.windMw ?? 0 : 0;
  if (parts.solar && solarMw <= 0) throw new BadRequestException("Solar capacity is required");
  if (parts.wind && windMw <= 0) throw new BadRequestException("Wind capacity is required");
  const bessMw = parts.bess ? optionalNumber(body.bessMw) ?? 0 : 0;
  const bessMwh = parts.bess ? optionalNumber(body.bessMwh) ?? 0 : 0;
  const annualGenerationGwh = optionalNumber(body.annualGenerationGwh) ?? current?.annualGenerationGwh ?? 0;
  if (annualGenerationGwh <= 0) throw new BadRequestException("Annual generation is required");
  const tariff = optionalNumber(body.quotedTariff ?? body.tariff) ?? current?.tariff ?? 0;
  if (tariff <= 0) throw new BadRequestException("Tariff is required");
  const codYear = "codYear" in body ? optionalNumber(body.codYear) : current?.codYear ?? null;
  const capex = "estimatedCapexCr" in body ? optionalNumber(body.estimatedCapexCr) : current?.estimatedCapexCr ?? null;
  const previous = current?.profile ?? emptyIppProfile();
  return {
    name,
    projectName,
    headquarters: String(body.headquarters ?? current?.headquarters ?? "").trim(),
    projectState,
    projectStatus: choice(body.projectStatus ?? current?.projectStatus, ["Concept", "Land Secured", "Development", "Under Construction", "Commissioned", "Operational", "On Hold", "Unknown"]) ?? "",
    technology: [parts.solar ? "Solar" : null, parts.wind ? "Wind" : null, parts.bess ? "BESS" : null].filter(Boolean).join(" + "),
    solarMw,
    windMw,
    bessMw,
    bessMwh,
    annualGenerationGwh,
    p90Gwh: "p90Gwh" in body ? optionalNumber(body.p90Gwh) : current?.p90Gwh ?? null,
    tariff,
    codYear,
    estimatedCapexCr: capex,
    profile: {
      projectDistrict: "projectDistrict" in body ? optionalText(body.projectDistrict) : previous.projectDistrict,
      projectLocation: "projectLocation" in body ? optionalText(body.projectLocation) : previous.projectLocation,
      generationData15Min: "generationData15Min" in body ? choice(body.generationData15Min, ["Available", "Not Available"]) : previous.generationData15Min,
      fdreCapability: "fdreCapability" in body ? choice(body.fdreCapability, ["Yes", "No", "To Be Evaluated"]) : previous.fdreCapability,
      gridVoltage: "gridVoltage" in body ? choice(body.gridVoltage, ["33 kV", "66 kV", "110 kV", "132 kV", "220 kV", "400 kV", "Other"]) : previous.gridVoltage,
      gridConnectivity: "gridConnectivity" in body ? choice(body.gridConnectivity, ["Not Applied", "Application Submitted", "Under Approval", "Approved", "Connected", "Unknown"]) : previous.gridConnectivity,
      openAccessReadiness: "openAccessReadiness" in body ? choice(body.openAccessReadiness, ["Ready", "In Progress", "Not Ready", "Unknown"]) : previous.openAccessReadiness,
      tariffType: "tariffType" in body ? choice(body.tariffType, ["Fixed", "Escalable", "Negotiable", "Other"]) : previous.tariffType,
      contractTenureYears: "contractTenureYears" in body ? optionalNumber(body.contractTenureYears) : previous.contractTenureYears,
      codConfidence: "codConfidence" in body ? choice(body.codConfidence, ["High", "Medium", "Low", "Unknown"]) : previous.codConfidence,
      financialModelAvailable: "financialModelAvailable" in body ? choice(body.financialModelAvailable, ["Yes", "No", "In Progress"]) : previous.financialModelAvailable,
      fundingStatus: "fundingStatus" in body ? choice(body.fundingStatus, ["Fully Funded", "Partially Funded", "Funding Required", "Unknown"]) : previous.fundingStatus,
    },
  };
}

function factorResult(score: number): "PASS" | "PARTIAL" | "FAIL" | "PENDING" {
  if (!Number.isFinite(score)) return "PENDING";
  if (score >= 85) return "PASS";
  if (score >= 55) return "PARTIAL";
  return "FAIL";
}

function eligibilityFromGates(gates: { status: string }[]) {
  if (!gates.length) return { status: "PENDING_REVIEW" as const, blockingIssues: 0, pendingChecks: 0, passed: 0 };
  const failed = gates.filter((gate) => gate.status === "FAIL").length;
  const pending = gates.filter((gate) => gate.status !== "PASS" && gate.status !== "FAIL").length;
  const passed = gates.filter((gate) => gate.status === "PASS").length;
  return {
    status: failed ? "NOT_ELIGIBLE" as const : pending ? "PENDING_REVIEW" as const : "ELIGIBLE" as const,
    blockingIssues: failed,
    pendingChecks: pending,
    passed,
  };
}

function explainRequirement(
  requirement: { annualEnergyGwh: number; peakDemandMw: number; targetCodYear: number; preferredTechnologies: string[]; bessPreference: string } | null,
  ipp: {
    annualGenerationGwh: number;
    p90Gwh: number;
    technologySummary: string;
    solarMw: number;
    windMw: number;
    bessMw: number;
    bessMwh: number;
    targetCodYear: number | null;
    indicativeTariffInrPerKwh: number;
    ehv?: { connectivityStatus: string } | null;
    capex?: { totalInrCr: number } | null;
    loadMatch?: { coveragePct: number; loadMatchPct: number; series?: unknown } | null;
    project?: { status: string } | null;
    regulatory?: unknown | null;
  },
  dimensions: { key: string; weight: number; score: number; weightedContribution: number }[],
) {
  const dimension = (key: string) => dimensions.find((item) => item.key === key);
  const technologies = requirement?.preferredTechnologies?.length ? requirement.preferredTechnologies.join(", ") : "Not configured";
  const p90 = ipp.p90Gwh > 0 ? `${ipp.p90Gwh} GWh P90` : "P90 generation data is not available";
  const codYear = ipp.targetCodYear && ipp.targetCodYear > 0 ? String(ipp.targetCodYear) : "Not specified";
  const gesCod = requirement?.targetCodYear && requirement.targetCodYear > 0 ? String(requirement.targetCodYear) : "Not configured";
  const bess = ipp.bessMw > 0 || ipp.bessMwh > 0 ? `${ipp.bessMw} MW / ${ipp.bessMwh} MWh` : "None";
  const rows = [
    dimension("energyCoverage") && {
      key: "energyCoverage",
      name: "Energy coverage",
      term: "P90",
      weight: dimension("energyCoverage")!.weight,
      score: dimension("energyCoverage")!.score,
      contribution: dimension("energyCoverage")!.weightedContribution,
      gesValue: requirement ? `${requirement.annualEnergyGwh} GWh stored requirement` : "Not configured",
      ippValue: `${ipp.annualGenerationGwh} GWh annual · ${p90}`,
      status: factorResult(dimension("energyCoverage")!.score),
      evidence: ipp.p90Gwh > 0 ? "Stored annual and P90 generation" : "P90 generation data is not available",
    },
    dimension("technologyFit") && {
      key: "technologyFit",
      name: "Technology match",
      term: null,
      weight: dimension("technologyFit")!.weight,
      score: dimension("technologyFit")!.score,
      contribution: dimension("technologyFit")!.weightedContribution,
      gesValue: technologies,
      ippValue: ipp.technologySummary || "Not specified",
      status: technologies === "Not configured" ? "PENDING" : factorResult(dimension("technologyFit")!.score),
      evidence: "Project technology",
    },
    dimension("bessFit") && {
      key: "bessFit",
      name: "BESS match",
      term: "BESS",
      weight: dimension("bessFit")!.weight,
      score: dimension("bessFit")!.score,
      contribution: dimension("bessFit")!.weightedContribution,
      gesValue: requirement?.bessPreference ?? "Not configured",
      ippValue: bess,
      status: factorResult(dimension("bessFit")!.score),
      evidence: requirement?.bessPreference === "OPTIONAL" ? "BESS is not required for this GES" : "Stored storage capacity",
    },
    dimension("codFit") && {
      key: "codFit",
      name: "COD match",
      term: "COD",
      weight: dimension("codFit")!.weight,
      score: dimension("codFit")!.score,
      contribution: dimension("codFit")!.weightedContribution,
      gesValue: gesCod,
      ippValue: codYear,
      status: gesCod === "Not configured" || codYear === "Not specified" ? "PENDING" : factorResult(dimension("codFit")!.score),
      evidence: "Target supply start and expected COD year",
    },
    dimension("tariffFit") && {
      key: "tariffFit",
      name: "Tariff fit",
      term: null,
      weight: dimension("tariffFit")!.weight,
      score: dimension("tariffFit")!.score,
      contribution: dimension("tariffFit")!.weightedContribution,
      gesValue: "No GES commercial threshold has been configured",
      ippValue: `₹${ipp.indicativeTariffInrPerKwh.toFixed(2)}/kWh`,
      status: factorResult(dimension("tariffFit")!.score),
      evidence: "Platform tariff band used by the evaluation service",
    },
    dimension("loadMatch") && {
      key: "loadMatch",
      name: "Load profile match",
      term: "FDRE",
      weight: dimension("loadMatch")!.weight,
      score: dimension("loadMatch")!.score,
      contribution: dimension("loadMatch")!.weightedContribution,
      gesValue: Array.isArray(ipp.loadMatch?.series) && ipp.loadMatch.series.length ? "Stored interval profile" : "Load profile data is required to calculate interval-level load matching",
      ippValue: ipp.loadMatch ? `${ipp.loadMatch.loadMatchPct}% interval match · ${ipp.loadMatch.coveragePct}% coverage` : "Not calculated",
      status: Array.isArray(ipp.loadMatch?.series) && ipp.loadMatch.series.length ? factorResult(dimension("loadMatch")!.score) : "PENDING",
      evidence: Array.isArray(ipp.loadMatch?.series) && ipp.loadMatch.series.length ? "DEMO / ILLUSTRATIVE stored interval profile" : "Load profile data is required to calculate interval-level load matching",
    },
    dimension("technicalFit") && {
      key: "technicalFit",
      name: "Execution readiness",
      term: "COD",
      weight: dimension("technicalFit")!.weight,
      score: dimension("technicalFit")!.score,
      contribution: dimension("technicalFit")!.weightedContribution,
      gesValue: gesCod,
      ippValue: ipp.project?.status ? `${ipp.project.status} · COD ${codYear}` : codYear,
      status: codYear === "Not specified" ? "PENDING" : factorResult(dimension("technicalFit")!.score),
      evidence: "Project status and expected COD",
    },
    dimension("regulatoryFit") && {
      key: "regulatoryFit",
      name: "Regulatory readiness",
      term: "Open Access",
      weight: dimension("regulatoryFit")!.weight,
      score: dimension("regulatoryFit")!.score,
      contribution: dimension("regulatoryFit")!.weightedContribution,
      gesValue: "Not configured as a separate GES rule",
      ippValue: ipp.regulatory ? "Stored regulatory assessment" : "Not specified",
      status: ipp.regulatory ? factorResult(dimension("regulatoryFit")!.score) : "PENDING",
      evidence: ipp.regulatory ? "Stored regulatory profile" : "Regulatory information is not available",
    },
    dimension("connectivityFit") && {
      key: "connectivityFit",
      name: "Grid and connectivity",
      term: "EHV",
      weight: dimension("connectivityFit")!.weight,
      score: dimension("connectivityFit")!.score,
      contribution: dimension("connectivityFit")!.weightedContribution,
      gesValue: "Connectivity is assessed per project",
      ippValue: ipp.ehv?.connectivityStatus ?? "Not specified",
      status: ipp.ehv?.connectivityStatus ? factorResult(dimension("connectivityFit")!.score) : "PENDING",
      evidence: "Stored connectivity status",
    },
    dimension("financialFit") && {
      key: "financialFit",
      name: "Financial readiness",
      term: "CAPEX",
      weight: dimension("financialFit")!.weight,
      score: dimension("financialFit")!.score,
      contribution: dimension("financialFit")!.weightedContribution,
      gesValue: "No separate GES financial threshold",
      ippValue: ipp.capex && ipp.capex.totalInrCr > 0 ? `₹${ipp.capex.totalInrCr} crore estimated CAPEX` : "CAPEX not available",
      status: factorResult(dimension("financialFit")!.score),
      evidence: "Stored project cost and funding assessment",
    },
  ].filter(Boolean);
  return rows;
}

function registerForComparison(row: { project?: { name: string; state: string; status: string } | null; headquarters: string; capex?: { totalInrCr: number } | null; ehv?: { connectivityStatus: string } | null }, profile?: IppProfileWrite) {
  return {
    projectName: row.project?.name ?? null,
    headquarters: row.headquarters,
    projectState: row.project?.state ?? null,
    projectStatus: row.project?.status ?? null,
    projectDistrict: profile?.projectDistrict ?? null,
    projectLocation: profile?.projectLocation ?? null,
    generationData15Min: profile?.generationData15Min ?? null,
    fdreCapability: profile?.fdreCapability ?? null,
    gridVoltage: profile?.gridVoltage ?? null,
    gridConnectivity: profile?.gridConnectivity ?? null,
    engineConnectivity: row.ehv?.connectivityStatus ?? null,
    openAccessReadiness: profile?.openAccessReadiness ?? null,
    tariffType: profile?.tariffType ?? null,
    contractTenureYears: profile?.contractTenureYears ?? null,
    codConfidence: profile?.codConfidence ?? null,
    financialModelAvailable: profile?.financialModelAvailable ?? null,
    fundingStatus: profile?.fundingStatus ?? null,
    estimatedCapexCr: row.capex && row.capex.totalInrCr > 0 ? row.capex.totalInrCr : null,
  };
}

async function saveIppProfile(prisma: PrismaService, id: string, profile: IppProfileWrite) {
  await prisma.$executeRaw`
    UPDATE "IPP" SET
      "projectDistrict" = ${profile.projectDistrict},
      "projectLocation" = ${profile.projectLocation},
      "generationData15Min" = ${profile.generationData15Min},
      "fdreCapability" = ${profile.fdreCapability},
      "gridVoltage" = ${profile.gridVoltage},
      "gridConnectivity" = ${profile.gridConnectivity},
      "openAccessReadiness" = ${profile.openAccessReadiness},
      "tariffType" = ${profile.tariffType},
      "contractTenureYears" = ${profile.contractTenureYears},
      "codConfidence" = ${profile.codConfidence},
      "financialModelAvailable" = ${profile.financialModelAvailable},
      "fundingStatus" = ${profile.fundingStatus}
    WHERE id = ${id}
  `;
}

async function loadIppProfiles(prisma: PrismaService, ids: string[]) {
  if (!ids.length) return new Map<string, IppProfileWrite>();
  const rows = await prisma.$queryRaw<Array<IppProfileWrite & { id: string }>>`
    SELECT id,
      "projectDistrict",
      "projectLocation",
      "generationData15Min",
      "fdreCapability",
      "gridVoltage",
      "gridConnectivity",
      "openAccessReadiness",
      "tariffType",
      "contractTenureYears",
      "codConfidence",
      "financialModelAvailable",
      "fundingStatus"
    FROM "IPP"
    WHERE id IN (${Prisma.join(ids)})
  `;
  return new Map(rows.map((row) => [row.id, row]));
}

async function syncConnectivity(prisma: PrismaService, id: string, label: string | null) {
  const engine: Record<string, "APPLICATION_SUBMITTED" | "APPROVAL_PENDING" | "APPROVED"> = {
    "Application Submitted": "APPLICATION_SUBMITTED",
    "Under Approval": "APPROVAL_PENDING",
    Approved: "APPROVED",
  };
  const status = label ? engine[label] : undefined;
  if (!status) return;
  await prisma.iPPEHVProfile.updateMany({ where: { ippId: id }, data: { connectivityStatus: status } });
}

function number(value: unknown, fallback: number) {
  const parsed = typeof value === "number" ? value : Number(value);
  return Number.isFinite(parsed) ? parsed : fallback;
}

function round(value: number, digits = 1) {
  const factor = 10 ** digits;
  return Math.round(value * factor) / factor;
}

function average(values: number[]) {
  if (!values.length) return 0;
  return round(values.reduce((total, value) => total + value, 0) / values.length);
}

function rollup(statuses: string[]) {
  if (statuses.includes("FAIL")) return "FAIL";
  if (statuses.includes("CONDITIONAL")) return "CONDITIONAL";
  if (statuses.includes("PASS")) return "PASS";
  return "PENDING";
}

const GES_CODES: Record<string, string> = {
  ges_aster: "GES 01",
  ges_nova: "GES 02",
  ges_vertex: "GES 03",
  ges_helix: "GES 04",
};

const IPP_CODES: Record<string, string> = {
  ipp_sungrid: "IPP 01",
  ipp_greenvolt: "IPP 02",
  ipp_windcore: "IPP 03",
  ipp_hybridgreen: "IPP 04",
  ipp_repower: "IPP 05",
  ipp_novarenewable: "IPP 06",
  ipp_aerosun: "IPP 07",
  ipp_terragrid: "IPP 08",
  ipp_eastwind: "IPP 09",
  ipp_solstice: "IPP 10",
};

function gesCode(id: string, createdOrder: string[]) {
  if (GES_CODES[id]) return GES_CODES[id];
  const extras = createdOrder.filter((item) => !GES_CODES[item]);
  return `GES ${String(Object.keys(GES_CODES).length + Math.max(extras.indexOf(id), 0) + 1).padStart(2, "0")}`;
}

interface GesWrite {
  name: string;
  legalName: string;
  businessType: string;
  city: string;
  state: string;
  discom: string;
  consumerNumbers: string;
  contractDemandMw: number;
  billedDemandMw: number;
  existingRooftopMw: number;
  existingRenewableGwh: number;
  annualConsumptionGwh: number;
  notes: string;
  annualEnergyGwh: number;
  peakDemandMw: number;
  requiredCapacityGw: number;
  targetCodYear: number;
  preferredTechnologies: string[];
  bessPreference: "OPTIONAL" | "HOURS_2_TO_4" | "HOURS_4";
  bessHoursMin: number;
  bessHoursMax: number | null;
  profile: GesProfileWrite;
}

interface GesProfileWrite {
  renewableEnergyTargetPercent: number | null;
  sanctionedLoadKw: number | null;
  solarConnectionType: string | null;
  peakRecordedDemandKva: number | null;
  bessRequirement: string | null;
}

function optionalNumber(value: unknown): number | null {
  if (value === null || value === undefined || value === "") return null;
  const parsed = typeof value === "number" ? value : Number(value);
  return Number.isFinite(parsed) ? parsed : null;
}

function technologiesFromPreference(value: unknown, current?: string[]): string[] {
  const key = String(value ?? "").trim().toUpperCase();
  const choices: Record<string, string[]> = {
    SOLAR: ["SOLAR"],
    WIND: ["WIND"],
    "SOLAR+WIND": ["SOLAR", "WIND"],
    "SOLAR+BESS": ["SOLAR", "BESS"],
    "WIND+BESS": ["WIND", "BESS"],
    "SOLAR+WIND+BESS": ["SOLAR", "WIND", "BESS"],
    NONE: [],
  };
  if (key in choices) return choices[key];
  if (Array.isArray(value)) return normalizeTechnologies(value);
  return current ?? [];
}

function gesInput(body: Record<string, unknown>, current?: Partial<GesWrite>): GesWrite {
  const name = String(body.name ?? current?.name ?? "").trim();
  if (!name) throw new BadRequestException("GES name is required");
  const legalName = String(body.legalName ?? current?.legalName ?? "").trim();
  if (!legalName) throw new BadRequestException("Legal name is required");
  const businessType = String(body.businessType ?? current?.businessType ?? "").trim();
  if (!businessType) throw new BadRequestException("Business type is required");
  const city = String(body.location ?? body.city ?? current?.city ?? "").trim();
  const state = String(body.state ?? current?.state ?? "").trim();
  const discom = String(body.discom ?? current?.discom ?? "").trim();
  if (!city || !state) throw new BadRequestException("City and state are required");
  if (!discom) throw new BadRequestException("DISCOM is required");
  const annualConsumptionGwh = "annualConsumptionGwh" in body
    ? optionalNumber(body.annualConsumptionGwh) ?? 0
    : current?.annualConsumptionGwh ?? 0;
  const targetPercent = "renewableEnergyTargetPercent" in body
    ? optionalNumber(body.renewableEnergyTargetPercent)
    : current?.profile?.renewableEnergyTargetPercent ?? null;
  const calculatedEnergy = targetPercent !== null && annualConsumptionGwh > 0
    ? round(annualConsumptionGwh * (targetPercent / 100), 4)
    : null;
  const annualEnergyGwh = calculatedEnergy ?? current?.annualEnergyGwh ?? 0;
  const peakKva = "peakRecordedDemandKva" in body
    ? optionalNumber(body.peakRecordedDemandKva)
    : current?.profile?.peakRecordedDemandKva ?? null;
  const peakDemandMw = peakKva !== null ? round(peakKva / 1000, 4) : current?.peakDemandMw ?? 0;
  const preferredTechnologies = technologiesFromPreference(body.preferredTechnology ?? body.preferredTechnologies, current?.preferredTechnologies);
  const bessRequirement = "bessRequirement" in body ? optionalText(body.bessRequirement) : current?.profile?.bessRequirement ?? null;
  const bessPreference = bessRequirement
    ? engineBess(bessRequirement)
    : normalizeBess("bessRequirement" in body ? current?.bessPreference : body.bessPreference ?? current?.bessPreference);
  const hours = bessPreference === "HOURS_4" ? { min: 4, max: 4 as number | null } : bessPreference === "HOURS_2_TO_4" ? { min: 2, max: 4 } : { min: 0, max: null };
  const contractKva = "contractDemandKva" in body ? optionalNumber(body.contractDemandKva) : null;
  const rooftopKw = "existingRooftopSolarKw" in body ? optionalNumber(body.existingRooftopSolarKw) : null;
  const supplyYear = "targetSupplyStartYear" in body || "targetCodYear" in body
    ? optionalNumber(body.targetSupplyStartYear ?? body.targetCodYear)
    : null;
  return {
    name,
    legalName,
    businessType,
    city,
    state,
    discom,
    consumerNumbers: String(body.consumerNumbers ?? current?.consumerNumbers ?? "").trim(),
    contractDemandMw: "contractDemandKva" in body ? (contractKva === null ? 0 : round(contractKva / 1000, 4)) : current?.contractDemandMw ?? 0,
    billedDemandMw: "billedDemandMw" in body ? optionalNumber(body.billedDemandMw) ?? 0 : current?.billedDemandMw ?? 0,
    existingRooftopMw: "existingRooftopSolarKw" in body ? (rooftopKw === null ? 0 : round(rooftopKw / 1000, 4)) : current?.existingRooftopMw ?? 0,
    existingRenewableGwh: optionalNumber(body.existingRenewableGwh) ?? current?.existingRenewableGwh ?? 0,
    annualConsumptionGwh,
    notes: String(body.notes ?? current?.notes ?? "").trim(),
    annualEnergyGwh,
    peakDemandMw,
    requiredCapacityGw: current?.requiredCapacityGw ?? 0,
    targetCodYear: "targetSupplyStartYear" in body || "targetCodYear" in body ? supplyYear ?? 0 : current?.targetCodYear ?? 0,
    preferredTechnologies,
    bessPreference,
    bessHoursMin: hours.min,
    bessHoursMax: hours.max,
    profile: {
      renewableEnergyTargetPercent: targetPercent,
      sanctionedLoadKw: "sanctionedLoadKw" in body ? optionalNumber(body.sanctionedLoadKw) : current?.profile?.sanctionedLoadKw ?? null,
      solarConnectionType: "solarConnectionType" in body ? optionalText(body.solarConnectionType) : current?.profile?.solarConnectionType ?? null,
      peakRecordedDemandKva: peakKva,
      bessRequirement,
    },
  };
}

function optionalText(value: unknown): string | null {
  const text = String(value ?? "").trim();
  return text ? text : null;
}

function engineBess(requirement: string): GesWrite["bessPreference"] {
  if (requirement === "REQUIRED") return "HOURS_4";
  if (requirement === "PREFERRED") return "HOURS_2_TO_4";
  return "OPTIONAL";
}

async function saveGesProfile(prisma: PrismaService, id: string, profile: GesProfileWrite) {
  await prisma.$executeRaw`
    UPDATE "GES" SET
      "renewableEnergyTargetPercent" = ${profile.renewableEnergyTargetPercent},
      "sanctionedLoadKw" = ${profile.sanctionedLoadKw},
      "solarConnectionType" = ${profile.solarConnectionType},
      "peakRecordedDemandKva" = ${profile.peakRecordedDemandKva},
      "bessRequirement" = ${profile.bessRequirement}
    WHERE id = ${id}
  `;
}

async function loadGesProfiles(prisma: PrismaService, ids: string[]) {
  if (!ids.length) return new Map<string, GesProfileWrite>();
  const rows = await prisma.$queryRaw<Array<GesProfileWrite & { id: string }>>`
    SELECT id,
      "renewableEnergyTargetPercent",
      "sanctionedLoadKw",
      "solarConnectionType",
      "peakRecordedDemandKva",
      "bessRequirement"
    FROM "GES"
    WHERE id IN (${Prisma.join(ids)})
  `;
  return new Map(rows.map((row) => [row.id, row]));
}

function normalizeBess(value: unknown): GesWrite["bessPreference"] {
  const text = String(value || "OPTIONAL");
  if (text === "HOURS_4" || text === "HOURS_2_TO_4" || text === "OPTIONAL") return text;
  return "OPTIONAL";
}

function normalizeTechnologies(values: unknown[]) {
  return values
    .map((value) => String(value).trim().toUpperCase())
    .map((value) => (value === "STORAGE" ? "BESS" : value))
    .filter((value) => ["SOLAR", "WIND", "BESS"].includes(value));
}

function scenarioName(scenario: { capexChangePct: number; interestChangePctPoints: number; codDelayMonths: number; cufReductionPct: number; bessCostChangePct: number }) {
  const parts = [];
  if (scenario.capexChangePct) parts.push(`CAPEX ${scenario.capexChangePct}%`);
  if (scenario.interestChangePctPoints) parts.push(`Interest ${scenario.interestChangePctPoints} pt`);
  if (scenario.codDelayMonths) parts.push(`COD +${scenario.codDelayMonths} months`);
  if (scenario.cufReductionPct) parts.push(`CUF -${scenario.cufReductionPct}%`);
  if (scenario.bessCostChangePct) parts.push(`BESS cost ${scenario.bessCostChangePct}%`);
  return parts.join(", ") || "Base case";
}
