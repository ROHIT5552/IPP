import { BadRequestException, ForbiddenException, Injectable, NotFoundException } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { rebuildPair } from "../persistence/rebuild";
import { PrismaService } from "../prisma/prisma.service";
import { AuditService } from "./audit.service";

export type Actor = {
  id: string;
  name?: string;
  permissions: string[];
  roles?: string[];
  gesId?: string | null;
};

const CLIENT_MATCH_KEYS = new Set(["loadMatch", "technologyFit", "bessFit", "codFit", "tariffFit"]);

const PROVENANCE = {
  accountName: "CLIENT_PROVIDED",
  legalName: "CLIENT_PROVIDED",
  businessType: "CLIENT_PROVIDED",
  consumerNumbers: "BILL_VERIFIED",
  city: "CLIENT_PROVIDED",
  state: "CLIENT_PROVIDED",
  discom: "BILL_VERIFIED",
  annualConsumptionGwh: "BILL_VERIFIED",
  averageMonthlyConsumptionGwh: "CALCULATED",
  peakRecordedDemandKva: "BILL_VERIFIED",
  contractDemandMw: "BILL_VERIFIED",
  billedDemandMw: "BILL_VERIFIED",
  sanctionedLoadKw: "BILL_VERIFIED",
  existingRooftopMw: "BILL_VERIFIED",
  existingRenewableGwh: "BILL_VERIFIED",
  renewableTargetPercent: "CLIENT_PROVIDED",
  requiredRenewableGwh: "CALCULATED",
  targetCodYear: "CLIENT_PROVIDED",
  preferredTechnologies: "CLIENT_PROVIDED",
  bessPreference: "CLIENT_PROVIDED",
  targetTariffInrPerKwh: "CLIENT_PROVIDED",
  contractTenureYears: "CLIENT_PROVIDED",
  contactName: "CLIENT_PROVIDED",
  contactEmail: "CLIENT_PROVIDED",
  contactPhone: "CLIENT_PROVIDED",
  notes: "CLIENT_PROVIDED",
} as const;

@Injectable()
export class ProcurementService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
  ) {}

  async profile(gesId: string) {
    const ges = await this.ges(gesId);
    const annual = ges.annualConsumptionGwh;
    const target = ges.requirement?.renewableTargetPercent ?? ges.renewableEnergyTargetPercent;
    const required = ges.requirement?.requiredRenewableGwh
      ?? (target != null && annual > 0 ? round(annual * (target / 100), 6) : null);
    const contact = ges.users[0];
    return {
      id: ges.id,
      name: ges.name,
      legalName: ges.legalName,
      businessType: ges.businessType,
      consumerNumbers: ges.consumerNumbers,
      city: ges.location,
      state: ges.state,
      discom: ges.discom,
      annualConsumptionGwh: annual,
      averageMonthlyConsumptionGwh: annual > 0 ? round(annual / 12, 6) : null,
      peakRecordedDemandKva: ges.peakRecordedDemandKva,
      contractDemandMw: ges.contractDemandMw,
      billedDemandMw: ges.billedDemandMw,
      sanctionedLoadKw: ges.sanctionedLoadKw,
      existingRooftopMw: ges.existingRooftopMw,
      existingRenewableGwh: ges.existingRenewableGwh,
      contactName: ges.contactName || contact?.name || "",
      contactEmail: ges.contactEmail || contact?.email || "",
      contactPhone: ges.contactPhone,
      notes: ges.notes,
      procurement: this.requirementBody(ges, target, required),
      provenance: PROVENANCE,
    };
  }

  async patchProfile(gesId: string, body: Record<string, unknown>, actor: Actor) {
    const ges = await this.ges(gesId);
    const customer = Boolean(actor.gesId);
    if (!customer && !actor.permissions.includes("GES_EDIT")) {
      throw new ForbiddenException("You do not have permission to edit this GES profile");
    }
    const data: Prisma.GESUpdateInput = {};
    if ("contactName" in body) data.contactName = text(body.contactName);
    if ("contactEmail" in body) data.contactEmail = text(body.contactEmail);
    if ("contactPhone" in body) data.contactPhone = text(body.contactPhone);
    if ("notes" in body) data.notes = text(body.notes);
    if (!customer) {
      if ("name" in body) data.name = requiredText(body.name, "Account name");
      if ("legalName" in body) data.legalName = requiredText(body.legalName, "Legal name");
      if ("businessType" in body) data.businessType = requiredText(body.businessType, "Business type");
      if ("city" in body || "location" in body) data.location = text(body.city ?? body.location);
      if ("state" in body) data.state = text(body.state);
      if ("discom" in body) data.discom = text(body.discom);
      if ("consumerNumbers" in body) data.consumerNumbers = text(body.consumerNumbers);
      if ("annualConsumptionGwh" in body) data.annualConsumptionGwh = number(body.annualConsumptionGwh, ges.annualConsumptionGwh);
      if ("contractDemandMw" in body) data.contractDemandMw = number(body.contractDemandMw, ges.contractDemandMw);
      if ("billedDemandMw" in body) data.billedDemandMw = number(body.billedDemandMw, ges.billedDemandMw);
      if ("existingRooftopMw" in body) data.existingRooftopMw = number(body.existingRooftopMw, ges.existingRooftopMw);
      if ("existingRenewableGwh" in body) data.existingRenewableGwh = number(body.existingRenewableGwh, ges.existingRenewableGwh);
      if ("sanctionedLoadKw" in body) data.sanctionedLoadKw = optionalNumber(body.sanctionedLoadKw);
      if ("peakRecordedDemandKva" in body) data.peakRecordedDemandKva = optionalNumber(body.peakRecordedDemandKva);
      if ("solarConnectionType" in body) data.solarConnectionType = text(body.solarConnectionType) || null;
    }
    if (Object.keys(data).length) {
      await this.prisma.gES.update({ where: { id: gesId }, data });
      await this.audit.log({
        entity: "GES",
        entityId: gesId,
        action: "PROFILE_UPDATE",
        newValue: { fields: Object.keys(data), actingOnBehalfOfGes: !actor.gesId, createdByRole: this.roleLabel(actor) },
        userId: actor.id,
      });
    }
    return this.profile(gesId);
  }

  async requirement(gesId: string) {
    const ges = await this.ges(gesId);
    const target = ges.requirement?.renewableTargetPercent ?? ges.renewableEnergyTargetPercent;
    const required = ges.requirement?.requiredRenewableGwh
      ?? (target != null && ges.annualConsumptionGwh > 0 ? round(ges.annualConsumptionGwh * (target / 100), 6) : null);
    return {
      gesId: ges.id,
      gesName: ges.name,
      annualConsumptionGwh: ges.annualConsumptionGwh,
      ...this.requirementBody(ges, target, required),
      provenance: {
        renewableTargetPercent: "CLIENT_PROVIDED",
        requiredRenewableGwh: "CALCULATED",
        annualEnergyGwh: "CLIENT_PROVIDED",
        peakDemandMw: "BILL_VERIFIED",
        targetCodYear: "CLIENT_PROVIDED",
        preferredTechnologies: "CLIENT_PROVIDED",
        bessPreference: "CLIENT_PROVIDED",
        targetTariffInrPerKwh: "CLIENT_PROVIDED",
        contractTenureYears: "CLIENT_PROVIDED",
        notes: "CLIENT_PROVIDED",
        commercialNotes: "CLIENT_PROVIDED",
      },
    };
  }

  async consider(gesId: string, ippId: string, actor: Actor) {
    const ges = await this.ges(gesId);
    if (!ges.requirement) throw new NotFoundException("GES requirement was not found");
    const ipp = await this.prisma.iPP.findUnique({ where: { id: ippId }, select: { id: true, name: true } });
    if (!ipp) throw new NotFoundException("Independent power producer was not found");
    const existing = await this.prisma.gESIPPSelection.findUnique({ where: { gesId_ippId: { gesId, ippId } } });
    if (!existing) {
      const meta = this.auditMeta(actor);
      await this.prisma.gESIPPSelection.create({
        data: {
          gesId,
          ippId,
          gesRequirementId: ges.requirement.id,
          status: "CONSIDERED",
          ...meta,
          updatedById: actor.id,
        },
      });
      const link = await this.prisma.gESRequirementIPP.findUnique({
        where: { gesRequirementId_ippId: { gesRequirementId: ges.requirement.id, ippId } },
      });
      if (!link) {
        await this.prisma.gESRequirementIPP.create({
          data: {
            id: `link_${gesId}_${ippId}`,
            gesRequirementId: ges.requirement.id,
            ippId,
            compatibilityStatus: "CONDITIONAL",
            illustrativeSeedStatus: "CONDITIONAL",
          },
        });
      }
      try {
        await rebuildPair(this.prisma, gesId, ippId);
      } catch {
        // The selection is the business record. A missing score must not roll it back.
      }
      await this.audit.log({
        entity: "GESIPPSelection",
        entityId: `${gesId}:${ippId}`,
        action: "CONSIDER",
        newValue: { gesId, ippId, ippName: ipp.name, ...meta },
        userId: actor.id,
      });
    }
    return this.selections(gesId);
  }

  async selections(gesId: string) {
    const ges = await this.ges(gesId);
    const rows = await this.prisma.gESIPPSelection.findMany({
      where: { gesId },
      include: {
        ipp: { select: { id: true, name: true, technologySummary: true, indicativeTariffInrPerKwh: true, annualGenerationGwh: true, p90Gwh: true, targetCodYear: true, solarMw: true, windMw: true, bessMw: true, bessMwh: true } },
        createdBy: { select: { id: true, name: true } },
        updatedBy: { select: { id: true, name: true } },
        commercialRequirements: { orderBy: { createdAt: "desc" }, include: { createdBy: { select: { id: true, name: true } } } },
        requirement: { select: { id: true } },
      },
      orderBy: { updatedAt: "desc" },
    });
    const links = await this.prisma.gESRequirementIPP.findMany({
      where: { gesRequirementId: ges.requirement?.id ?? "" },
      select: { ippId: true, suitabilityScore: true, generationFit: true, technicalFit: true, commercialFit: true },
    });
    const suitabilities = await this.prisma.iPPSuitability.findMany({
      where: { gesRequirementId: ges.requirement?.id ?? "" },
      select: { ippId: true, overallPct: true, dimensions: true },
    });
    const targetTariff = ges.requirement?.targetTariffInrPerKwh ?? null;
    return {
      gesId: ges.id,
      gesName: ges.name,
      targetTariffInrPerKwh: targetTariff,
      selections: rows.map((row) => {
        const link = links.find((item) => item.ippId === row.ippId);
        const suitability = suitabilities.find((item) => item.ippId === row.ippId);
        const latest = row.commercialRequirements[0] ?? null;
        return {
          id: row.id,
          ippId: row.ippId,
          ippName: row.ipp.name,
          technology: row.ipp.technologySummary,
          solarMw: row.ipp.solarMw,
          windMw: row.ipp.windMw,
          bessMw: row.ipp.bessMw,
          bessMwh: row.ipp.bessMwh,
          annualGenerationGwh: row.ipp.annualGenerationGwh,
          p90Gwh: row.ipp.p90Gwh > 0 ? row.ipp.p90Gwh : null,
          codYear: row.ipp.targetCodYear > 0 ? row.ipp.targetCodYear : null,
          ippTariff: row.ipp.indicativeTariffInrPerKwh,
          requirementMatch: suitability?.overallPct ?? (link ? round(link.suitabilityScore, 1) : null),
          generationMatch: link?.generationFit ?? null,
          technologyMatch: dimensionScore(suitability?.dimensions, "technologyFit"),
          bessMatch: dimensionScore(suitability?.dimensions, "bessFit"),
          codMatch: dimensionScore(suitability?.dimensions, "codFit"),
          myTargetTariff: latest?.targetTariffInrPerKwh ?? targetTariff,
          status: row.status,
          createdBy: row.createdBy?.name ?? null,
          createdByRole: row.createdByRole,
          actingOnBehalfOfGes: row.actingOnBehalfOfGes,
          onBehalfOf: row.actingOnBehalfOfGes ? ges.name : null,
          createdAt: row.createdAt.toISOString(),
          updatedAt: row.updatedAt.toISOString(),
          updatedBy: row.updatedBy?.name ?? null,
          commercialRequirements: row.commercialRequirements.map((item) => ({
            id: item.id,
            targetTariffInrPerKwh: item.targetTariffInrPerKwh,
            requiredEnergyGwh: item.requiredEnergyGwh,
            requiredLoadMw: item.requiredLoadMw,
            contractTenureYears: item.contractTenureYears,
            targetSupplyYear: item.targetSupplyYear,
            notes: item.notes,
            status: item.status,
            createdBy: item.createdBy?.name ?? null,
            createdByRole: item.createdByRole,
            actingOnBehalfOfGes: item.actingOnBehalfOfGes,
            onBehalfOf: item.actingOnBehalfOfGes ? ges.name : null,
            createdAt: item.createdAt.toISOString(),
          })),
        };
      }),
    };
  }

  async addCommercial(gesId: string, selectionId: string, body: Record<string, unknown>, actor: Actor) {
    const selection = await this.prisma.gESIPPSelection.findFirst({ where: { id: selectionId, gesId } });
    if (!selection) throw new NotFoundException("IPP selection was not found");
    const prior = await this.prisma.commercialRequirement.count({ where: { selectionId } });
    const meta = this.auditMeta(actor);
    const created = await this.prisma.commercialRequirement.create({
      data: {
        selectionId,
        gesId,
        ippId: selection.ippId,
        targetTariffInrPerKwh: optionalNumber(body.targetTariffInrPerKwh),
        requiredEnergyGwh: optionalNumber(body.requiredEnergyGwh),
        requiredLoadMw: optionalNumber(body.requiredLoadMw),
        contractTenureYears: optionalNumber(body.contractTenureYears),
        targetSupplyYear: optionalNumber(body.targetSupplyYear) == null ? null : Math.round(optionalNumber(body.targetSupplyYear) as number),
        notes: text(body.notes),
        status: prior > 0 ? "UPDATED" : "SUBMITTED",
        ...meta,
      },
    });
    await this.prisma.gESIPPSelection.update({
      where: { id: selectionId },
      data: { updatedById: actor.id },
    });
    await this.audit.log({
      entity: "CommercialRequirement",
      entityId: created.id,
      action: "CREATE",
      newValue: { gesId, selectionId, ippId: selection.ippId, status: created.status, ...meta },
      userId: actor.id,
    });
    return this.selections(gesId);
  }

  async clientIpp(gesId: string, ippId: string) {
    const ges = await this.ges(gesId);
    const ipp = await this.prisma.iPP.findUnique({
      where: { id: ippId },
      include: { project: true, bessProfile: true },
    });
    if (!ipp) throw new NotFoundException("Independent power producer was not found");
    const [link, suitability, gates, selection] = await Promise.all([
      ges.requirement
        ? this.prisma.gESRequirementIPP.findUnique({ where: { gesRequirementId_ippId: { gesRequirementId: ges.requirement.id, ippId } } })
        : null,
      ges.requirement
        ? this.prisma.iPPSuitability.findUnique({ where: { gesRequirementId_ippId: { gesRequirementId: ges.requirement.id, ippId } } })
        : null,
      this.prisma.criticalGateResult.findMany({ where: { gesId, ippId }, include: { gate: true }, orderBy: { gate: { sortOrder: "asc" } } }),
      this.prisma.gESIPPSelection.findUnique({ where: { gesId_ippId: { gesId, ippId } }, select: { id: true, status: true } }),
    ]);
    const duration = ipp.bessMw > 0 && ipp.bessMwh > 0 ? round(ipp.bessMwh / ipp.bessMw, 2) : ipp.bessProfile?.durationHours || null;
    const dimensions = matchDimensions(suitability?.dimensions).filter((item) => CLIENT_MATCH_KEYS.has(item.key));
    return {
      id: ipp.id,
      selected: Boolean(selection),
      selectionId: selection?.id ?? null,
      selectionStatus: selection?.status ?? null,
      requirement: ges.requirement ? {
        renewableTargetPercent: ges.requirement.renewableTargetPercent,
        requiredRenewableGwh: ges.requirement.requiredRenewableGwh,
        annualEnergyGwh: ges.requirement.annualEnergyGwh,
        targetCodYear: ges.requirement.targetCodYear,
        preferredTechnologies: ges.requirement.preferredTechnologies,
        bessPreference: ges.requirement.bessPreference,
        targetTariffInrPerKwh: ges.requirement.targetTariffInrPerKwh,
        contractTenureYears: ges.requirement.contractTenureYears,
      } : null,
      overview: {
        name: ipp.name,
        projectName: ipp.project?.name ?? "",
        location: [ipp.projectLocation, ipp.projectDistrict, ipp.project?.state].filter(Boolean).join(", "),
        technology: ipp.technologySummary,
        projectStatus: ipp.project?.status ?? "",
      },
      capacity: {
        solarMw: ipp.solarMw,
        windMw: ipp.windMw,
        bessMw: ipp.bessMw,
        bessMwh: ipp.bessMwh,
        bessDurationHours: duration,
      },
      generation: {
        annualGenerationGwh: ipp.annualGenerationGwh,
        p90Gwh: ipp.p90Gwh > 0 ? ipp.p90Gwh : null,
        fdreCapability: ipp.fdreCapability,
      },
      commercial: {
        tariff: ipp.indicativeTariffInrPerKwh,
        tariffType: ipp.tariffType,
        contractTenureYears: ipp.contractTenureYears,
      },
      execution: {
        codYear: ipp.targetCodYear > 0 ? ipp.targetCodYear : null,
        codConfidence: ipp.codConfidence,
      },
      grid: {
        gridVoltage: ipp.gridVoltage,
        connectivityStatus: ipp.gridConnectivity,
        openAccessReadiness: ipp.openAccessReadiness,
      },
      requirementMatch: suitability?.overallPct ?? (link ? round(link.suitabilityScore, 1) : null),
      matches: dimensions,
      requiredChecks: gates.map((gate) => ({ name: gate.gate.name, status: gate.status })),
    };
  }

  private async ges(gesId: string) {
    const ges = await this.prisma.gES.findUnique({
      where: { id: gesId },
      include: { requirement: true, users: { select: { name: true, email: true }, orderBy: { createdAt: "asc" }, take: 1 } },
    });
    if (!ges) throw new NotFoundException("GES account was not found");
    return ges;
  }

  private requirementBody(
    ges: { requirement: { annualEnergyGwh: number; peakDemandMw: number; requiredCapacityGw: number; targetCodYear: number; preferredTechnologies: string[]; bessPreference: string; bessHoursMin: number | null; bessHoursMax: number | null; notes: string; targetTariffInrPerKwh: number | null; contractTenureYears: number | null; commercialNotes: string; renewableTargetPercent: number | null; requiredRenewableGwh: number | null } | null; bessRequirement: string | null },
    target: number | null,
    required: number | null,
  ) {
    return {
      renewableTargetPercent: target,
      requiredRenewableGwh: required,
      annualEnergyGwh: ges.requirement?.annualEnergyGwh ?? 0,
      peakDemandMw: ges.requirement?.peakDemandMw ?? 0,
      requiredCapacityGw: ges.requirement?.requiredCapacityGw ?? 0,
      targetCodYear: ges.requirement?.targetCodYear ?? 0,
      preferredTechnologies: ges.requirement?.preferredTechnologies ?? [],
      bessPreference: ges.requirement?.bessPreference ?? "OPTIONAL",
      bessRequirement: ges.bessRequirement,
      targetTariffInrPerKwh: ges.requirement?.targetTariffInrPerKwh ?? null,
      contractTenureYears: ges.requirement?.contractTenureYears ?? null,
      notes: ges.requirement?.notes ?? "",
      commercialNotes: ges.requirement?.commercialNotes ?? "",
    };
  }

  private auditMeta(actor: Actor) {
    return {
      createdById: actor.id,
      createdByRole: this.roleLabel(actor),
      actingOnBehalfOfGes: !actor.gesId,
    };
  }

  private roleLabel(actor: Actor) {
    const role = ["ADMIN", "NEWRA_ADMIN", "GES_ADMIN", "GES_USER", "EVALUATOR"].find((item) => actor.roles?.includes(item)) ?? actor.roles?.[0] ?? "";
    if (role === "ADMIN") return "Super Admin";
    if (role === "NEWRA_ADMIN") return "NewRa Admin";
    if (role === "GES_ADMIN") return "GES Admin";
    if (role === "GES_USER") return "GES User";
    return role.replaceAll("_", " ");
  }
}

function text(value: unknown) {
  return String(value ?? "").trim();
}

function requiredText(value: unknown, label: string) {
  const next = text(value);
  if (!next) throw new BadRequestException(`${label} is required`);
  return next;
}

function optionalNumber(value: unknown): number | null {
  if (value === null || value === undefined || value === "") return null;
  const parsed = typeof value === "number" ? value : Number(value);
  return Number.isFinite(parsed) ? parsed : null;
}

function number(value: unknown, fallback: number) {
  return optionalNumber(value) ?? fallback;
}

function round(value: number, digits = 2) {
  const factor = 10 ** digits;
  return Math.round((value + Number.EPSILON) * factor) / factor;
}

function matchDimensions(value: Prisma.JsonValue | null | undefined) {
  if (!Array.isArray(value)) return [] as { key: string; label: string; score: number }[];
  return value.flatMap((item) => {
    if (!item || typeof item !== "object" || Array.isArray(item)) return [];
    const row = item as { key?: string; label?: string; score?: number };
    if (!row.key || typeof row.score !== "number") return [];
    return [{ key: row.key, label: row.label ?? row.key, score: row.score }];
  });
}

function dimensionScore(value: Prisma.JsonValue | null | undefined, key: string) {
  return matchDimensions(value).find((item) => item.key === key)?.score ?? null;
}
