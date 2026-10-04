import { Prisma, PrismaClient } from "@prisma/client";
import * as bcrypt from "bcrypt";
import {
  DEMO_PASSWORD,
  GES_SEED,
  LINK_SEED,
  ROLE_PERMISSIONS,
  SUITABILITY_CONFIG,
  SeedIpp,
  USERS,
  buildIppCases,
} from "../src/demo/catalog";
import { CRITICAL_GATES } from "../src/domain/parameters";
import { monthlyGeneration, technologyEnergySplit } from "../src/domain/profiles";
import { rebuildAll } from "../src/persistence/rebuild";

const prisma = new PrismaClient();

const PERMISSION_LABELS: Record<string, string> = {
  IPP_VIEW: "View IPP records",
  IPP_CREATE: "Create IPP records",
  IPP_EDIT: "Edit IPP records",
  GES_VIEW: "View GES accounts",
  GES_CREATE: "Create GES accounts",
  GES_EDIT: "Edit GES accounts",
  EVALUATION_VIEW: "View evaluations",
  EVALUATION_EDIT: "Edit evaluations",
  TECHNICAL_REVIEW: "Review technical inputs",
  FINANCIAL_REVIEW: "Review financial inputs",
  COMMERCIAL_REVIEW: "Review commercial terms",
  TARIFF_REVIEW: "Review tariffs",
  NEGOTIATION_CREATE: "Create negotiation offers",
  NEGOTIATION_APPROVE: "Approve negotiation offers",
  PSOA_VIEW: "View PSOA checklists",
  PSOA_CREATE: "Update PSOA checklists",
  DEALBOOK_VIEW: "View dealbooks",
  DEALBOOK_CREATE: "Create dealbooks",
  DOCUMENT_VIEW: "View documents",
  DOCUMENT_UPLOAD: "Upload documents",
  AUDIT_VIEW: "View the audit log",
  GES_PROFILE_EDIT: "Edit allowed GES profile fields",
  REQUIREMENT_VIEW: "View GES requirements",
  REQUIREMENT_EDIT: "Edit GES requirements",
  SELECTION_VIEW: "View GES IPP selections",
  SELECTION_CREATE: "Select an IPP for a GES requirement",
  COMMERCIAL_REQUIREMENT_VIEW: "View commercial requirements",
  COMMERCIAL_REQUIREMENT_CREATE: "Submit a commercial requirement",
};

const ROLE_COPY: Record<string, string> = {
  ADMIN: "Super Admin. Full access to GES, IPP, evaluation, commercial requirements and audit.",
  NEWRA_ADMIN: "NewRa operations. Creates GES accounts and global IPP records, and can act on behalf of a GES.",
  EVALUATOR: "Runs evaluations and keeps GES and IPP inputs current.",
  COMMERCIAL_REVIEWER: "Reviews tariff, negotiation and commercial terms.",
  TECHNICAL_REVIEWER: "Reviews generation, BESS, EHV and engineering evidence.",
  FINANCE_REVIEWER: "Reviews CAPEX, financing and tariff sustainability.",
  VIEWER: "Read-only access to GES, IPP, evaluation and dealbook.",
  GES_ADMIN: "Manages one GES account, its requirement, IPP selections and commercial requirements.",
  GES_USER: "Uses one GES account: profile, requirement, IPP catalogue, selections and commercial requirements.",
};

const DOC_CATEGORIES = [
  "IPP_COMPANY_PROFILE",
  "PROJECT_DETAILS",
  "COD_CERTIFICATES",
  "GENERATION_REPORTS",
  "P50_P75_P90",
  "EHV_DOCUMENTS",
  "TECHNICAL_DOCUMENTS",
  "BESS_DOCUMENTS",
  "CAPEX_DOCUMENTS",
  "FINANCIAL_DOCUMENTS",
  "TARIFF_PROPOSAL",
  "PPA_DRAFT",
  "REGULATORY_DOCUMENTS",
  "CLIENT_REFERENCES",
  "APPROVALS",
] as const;

const PSOA_ITEMS = [
  "Corporate credentials",
  "Comparable projects",
  "Financial evidence",
  "Technical evidence",
  "Generation methodology",
  "FDRE",
  "BESS",
  "EHV",
  "CAPEX",
  "Financial model",
  "Tariff",
  "Execution schedule",
  "Regulatory protection",
  "COD",
  "NewRa integration",
];

async function main() {
  const ipps = buildIppCases();
  await prisma.$executeRawUnsafe(`
    DO $$ DECLARE row RECORD;
    BEGIN
      FOR row IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename <> '_prisma_migrations') LOOP
        EXECUTE 'TRUNCATE TABLE ' || quote_ident(row.tablename) || ' CASCADE';
      END LOOP;
    END $$;
  `);

  const passwordHash = await bcrypt.hash(DEMO_PASSWORD, 10);
  for (const [key, description] of Object.entries(PERMISSION_LABELS)) {
    await prisma.permission.create({ data: { id: `perm_${key.toLowerCase()}`, key: key as never, description } });
  }
  for (const [role, permissions] of Object.entries(ROLE_PERMISSIONS)) {
    await prisma.role.create({
      data: {
        id: `role_${role.toLowerCase()}`,
        name: role as never,
        description: ROLE_COPY[role],
        permissions: { create: permissions.map((permission) => ({ permissionId: `perm_${permission.toLowerCase()}` })) },
      },
    });
  }
  for (const user of USERS.filter((item) => !item.gesId)) {
    await prisma.user.create({
      data: {
        id: user.id,
        email: user.email,
        name: user.name,
        title: user.title,
        passwordHash,
        roles: { create: [{ roleId: `role_${user.role.toLowerCase()}` }] },
      },
    });
  }

  await prisma.suitabilityConfig.create({
    data: {
      id: SUITABILITY_CONFIG.id,
      name: SUITABILITY_CONFIG.name,
      weights: SUITABILITY_CONFIG.weights as unknown as Prisma.InputJsonValue,
      tariffFloor: SUITABILITY_CONFIG.tariffFloor,
      tariffCeiling: SUITABILITY_CONFIG.tariffCeiling,
      active: true,
      illustrative: true,
    },
  });
  for (const gate of CRITICAL_GATES) {
    await prisma.criticalGate.create({
      data: { id: gate.key, key: gate.key, name: gate.name, description: gate.description, sortOrder: CRITICAL_GATES.indexOf(gate) + 1 },
    });
  }

  for (const ges of GES_SEED) {
    await prisma.gES.create({
      data: {
        id: ges.id,
        name: ges.name,
        legalName: ges.legalName,
        businessType: ges.businessType,
        location: ges.location,
        state: ges.state,
        discom: ges.discom,
        consumerNumbers: ges.consumerNumbers,
        contractDemandMw: ges.contractDemandMw,
        billedDemandMw: ges.billedDemandMw,
        existingRooftopMw: ges.existingRooftopMw,
        existingRenewableGwh: ges.existingRenewableGwh,
        annualConsumptionGwh: ges.annualConsumptionGwh,
        notes: ges.notes,
        crmStage: ges.crmStage,
        evaluationStage: ges.evaluationStage,
        illustrative: true,
        consumers: {
          create: ges.consumerNumbers.split(",").map((consumerNumber, index) => ({
            consumerNumber: consumerNumber.trim(),
            discom: ges.discom,
            contractDemandMw: index === 0 ? ges.contractDemandMw : Math.round(ges.contractDemandMw * 0.35),
            billedDemandMw: index === 0 ? ges.billedDemandMw : Math.round(ges.billedDemandMw * 0.35),
            voltageLevel: "33 kV",
          })),
        },
        requirement: {
          create: {
            id: `req_${ges.id}`,
            annualEnergyGwh: ges.annualEnergyGwh,
            peakDemandMw: ges.peakDemandMw,
            requiredCapacityGw: ges.requiredCapacityGw,
            targetCodYear: ges.targetCodYear,
            preferredTechnologies: ges.preferredTechnologies,
            bessPreference: ges.bessPreference,
            bessHoursMin: ges.bessHoursMin,
            bessHoursMax: ges.bessHoursMax,
            notes: ges.requirementNotes,
            dataQuality: "COMPLETE",
            illustrative: true,
          },
        },
        loadProfiles: {
          create: {
            id: `load_${ges.id}`,
            name: "Illustrative 15-minute operating day",
            intervalMinutes: 15,
            intervals: [],
            annualEnergyGwh: ges.annualEnergyGwh,
            peakMw: ges.peakDemandMw,
            dataQuality: "COMPLETE",
            source: "Demo load shape scaled to the annual requirement",
            evidenceStatus: "VERIFIED",
            illustrative: true,
          },
        },
      },
    });
  }

  for (const user of USERS.filter((item) => item.gesId)) {
    await prisma.user.create({
      data: {
        id: user.id,
        email: user.email,
        name: user.name,
        title: user.title,
        passwordHash,
        gesId: user.gesId,
        roles: { create: [{ roleId: `role_${user.role.toLowerCase()}` }] },
      },
    });
  }

  for (const ipp of ipps) {
    await createIpp(ipp);
  }

  for (const [gesId, links] of Object.entries(LINK_SEED)) {
    for (const [ippId, status] of Object.entries(links)) {
      await prisma.gESRequirementIPP.create({
        data: {
          id: `link_${gesId}_${ippId}`,
          gesRequirementId: `req_${gesId}`,
          ippId,
          compatibilityStatus: status,
          illustrativeSeedStatus: status,
          shortlisted: status === "HIGHLY_SUITABLE",
        },
      });
    }
  }

  const defaults: Record<string, string[]> = {
    ges_aster: ["ipp_sungrid", "ipp_hybridgreen", "ipp_terragrid"],
    ges_nova: ["ipp_greenvolt", "ipp_repower", "ipp_novarenewable"],
    ges_vertex: ["ipp_sungrid", "ipp_aerosun", "ipp_terragrid"],
    ges_helix: ["ipp_greenvolt", "ipp_eastwind", "ipp_terragrid"],
  };
  for (const [gesId, ippIds] of Object.entries(defaults)) {
    await prisma.comparison.create({
      data: {
        gesId,
        name: "Working comparison",
        working: true,
        createdById: "usr_evaluator",
        ipps: { create: ippIds.map((ippId, position) => ({ ippId, position })) },
      },
    });
  }

  await prisma.negotiation.create({
    data: {
      id: "neg_aster_hybrid",
      gesId: "ges_aster",
      ippId: "ipp_hybridgreen",
      status: "COUNTERED",
      offers: {
        create: [
          offer(1, "IPP_OFFER", 4.05, 2031, "OPEN", "usr_commercial", "Initial illustrative offer"),
          offer(2, "COUNTER_OFFER", 3.92, 2030, "OPEN", "usr_commercial", "NewRa counter on tariff and COD"),
        ],
      },
    },
  });
  await prisma.negotiation.create({
    data: {
      id: "neg_aster_sungrid",
      gesId: "ges_aster",
      ippId: "ipp_sungrid",
      status: "OPEN",
      offers: { create: [offer(1, "IPP_OFFER", 3.85, 2029, "OPEN", "usr_evaluator", "Opening illustrative offer")] },
    },
  });

  await prisma.psoa.create({
    data: {
      id: "psoa_aster_terra",
      gesId: "ges_aster",
      ippId: "ipp_terragrid",
      status: "IN_REVIEW",
      items: PSOA_ITEMS.map((label, index) => ({
        label,
        status: index < 8 ? "VERIFIED" : index < 12 ? "RECEIVED" : index === 13 ? "EXCEPTION" : "PENDING",
        note: "Illustrative checklist item",
      })) as unknown as Prisma.InputJsonValue,
    },
  });
  await prisma.dealbook.create({
    data: {
      id: "deal_aster_terra",
      gesId: "ges_aster",
      ippId: "ipp_terragrid",
      recommendation: "Hold for negotiation. Illustrative record only.",
      conditions: "Connectivity approval, verified P90 and a firm BESS warranty remain open.",
      summary: { illustrative: true },
      approvals: [{ role: "COMMERCIAL_REVIEWER", status: "PENDING" }, { role: "FINANCE_REVIEWER", status: "PENDING" }],
      illustrative: true,
    },
  });

  await prisma.task.createMany({
    data: [
      task("task_bess", "ges_aster", "ipp_hybridgreen", "Review HybridGreen Power BESS guarantee", "usr_technical", "Technical reviewer", "HIGH"),
      task("task_capex", "ges_aster", "ipp_hybridgreen", "Request updated CAPEX", "usr_finance", "Finance reviewer", "HIGH"),
      task("task_p90", "ges_nova", "ipp_windcore", "Validate P90 generation", "usr_technical", "IPP", "MEDIUM"),
      task("task_ehv", "ges_vertex", "ipp_aerosun", "Review EHV methodology", "usr_technical", "Technical reviewer", "MEDIUM"),
      task("task_counter", "ges_aster", "ipp_hybridgreen", "Send tariff counter offer", "usr_commercial", "Commercial reviewer", "CRITICAL"),
    ],
  });
  await prisma.activity.createMany({
    data: [
      { gesId: "ges_aster", ippId: "ipp_sungrid", actorId: "usr_evaluator", message: "Opened the Aster shortlist against eight illustrative IPPs." },
      { gesId: "ges_aster", ippId: "ipp_hybridgreen", actorId: "usr_commercial", message: "Logged a counter offer without overwriting the original IPP offer." },
      { gesId: "ges_nova", actorId: "usr_technical", message: "Nova Industrial Works moved to IPP evaluation. Document review continues in parallel." },
    ],
  });
  await prisma.auditLog.create({
    data: {
      entity: "GES",
      entityId: "ges_aster",
      action: "SEED",
      newValue: { name: "Aster Manufacturing Group", illustrative: true },
      userId: "usr_admin",
    },
  });

  await rebuildAll(prisma);
  console.log("NEWRA comparator demo data calculated and stored.");
}

function offer(version: number, offerType: "IPP_OFFER" | "COUNTER_OFFER", tariff: number, codYear: number, status: "OPEN", createdById: string, otherTerms: string) {
  return {
    version,
    offerType,
    tariff,
    codYear,
    bessSummary: "As offered in the illustrative BESS sheet",
    paymentTerms: "Monthly, 30 days from invoice",
    changeInLaw: "Shared above an agreed threshold",
    curtailment: "Deemed generation for grid unavailability beyond the agreed band",
    performanceGuarantee: "P90 generation with liquidated damages",
    riskAllocation: "IPP retains resource and plant performance risk",
    otherTerms,
    status,
    createdById,
  };
}

function task(id: string, gesId: string, ippId: string, title: string, ownerId: string, pendingFrom: string, priority: "HIGH" | "MEDIUM" | "CRITICAL") {
  return {
    id,
    gesId,
    ippId,
    title,
    dueDate: new Date("2026-10-20"),
    ownerId,
    pendingFrom,
    priority,
    status: "OPEN" as const,
  };
}

async function createIpp(ipp: SeedIpp) {
  const meta = ipp.meta;
  const split = technologyEnergySplit({ solarMw: ipp.solarMw, windMw: ipp.windMw, annualGenerationGwh: ipp.annualGenerationGwh });
  const tech = [ipp.solarMw ? "Solar" : null, ipp.windMw ? "Wind" : null, ipp.bessMw ? "BESS" : null].filter(Boolean).join(" + ");
  const cod = new Date(Date.UTC(ipp.codYear, 2, 31));
  const statuses = ["VERIFIED", "RECEIVED", "UNDER_REVIEW", "PENDING", "REQUESTED", "VERIFIED", "RECEIVED"] as const;
  await prisma.iPP.create({
    data: {
      id: ipp.id,
      name: ipp.name,
      legalName: meta.legalName,
      headquarters: meta.headquarters,
      technologySummary: tech,
      solarMw: ipp.solarMw,
      windMw: ipp.windMw,
      bessMw: ipp.bessMw,
      bessMwh: ipp.bessMwh,
      annualGenerationGwh: ipp.annualGenerationGwh,
      p90Gwh: ipp.p90Gwh,
      indicativeTariffInrPerKwh: ipp.quotedTariff,
      targetCodYear: ipp.codYear,
      evaluationStage: "IPP_EVALUATION",
      pendingFrom: meta.pendingFrom,
      illustrative: true,
      baseline: {
        ...ipp.baseline,
        baseScores: ipp.baseScores,
        scadaIntegration: ipp.scadaIntegration,
        weakSystemStudy: ipp.weakSystemStudy,
        dataQualityFactor: ipp.dataQualityFactor,
      } as unknown as Prisma.InputJsonValue,
      project: { create: { name: `${ipp.name} illustrative portfolio`, state: meta.headquarters, capacityMw: ipp.solarMw + ipp.windMw, codYear: ipp.codYear, status: "Development" } },
      experience: { create: { commissionedMw: meta.experienceMw, yearsOperating: meta.years, projectsCompleted: meta.projects, notableProjects: meta.notable } },
      technology: { create: { solar: ipp.solarMw > 0, wind: ipp.windMw > 0, bess: ipp.bessMw > 0, hybrid: [ipp.solarMw, ipp.windMw, ipp.bessMw].filter((value) => value > 0).length > 1 } },
      solarProfile: {
        create: {
          acMw: ipp.solarMw,
          dcMw: round(ipp.solarMw * 1.35),
          dcAcRatio: ipp.solarMw > 0 ? 1.35 : 0,
          moduleTechnology: meta.module,
          inverterPhilosophy: meta.inverter,
          cuf: round(ipp.solarCuf, 4),
          degradation: 0.004,
          clipping: 0.015,
          auxiliaryConsumption: 0.012,
          availability: 0.985,
          evidences: evidence("Solar CUF", ipp.solarCuf, "%"),
          dataQuality: ipp.solarMw > 0 ? "COMPLETE" : "MISSING",
        },
      },
      windProfile: {
        create: {
          wtgRatingMw: ipp.windMw > 0 ? 4.2 : 0,
          hubHeightM: ipp.windMw > 0 ? 140 : 0,
          rotorDiameterM: ipp.windMw > 0 ? 160 : 0,
          resourceMethodology: ipp.windMw > 0 ? (ipp.weakSystemStudy ? "Desktop mesoscale only" : "Mesoscale plus on-site mast") : "Not applicable",
          cuf: round(ipp.windCuf, 4),
          wakeLoss: ipp.windMw > 0 ? 0.08 : 0,
          availability: ipp.windMw > 0 ? 0.97 : 0,
          evidences: evidence("Wind CUF", ipp.windCuf, "%"),
          dataQuality: ipp.windMw > 0 ? "COMPLETE" : "MISSING",
        },
      },
      bessProfile: {
        create: {
          powerMw: ipp.bessMw,
          energyMwh: ipp.bessMwh,
          usableEnergyMwh: ipp.usableEnergyMwh,
          durationHours: ipp.bessMw > 0 ? ipp.bessMwh / ipp.bessMw : 0,
          chemistry: meta.chemistry,
          oem: meta.oem,
          pcs: ipp.bessMw > 0 ? "Central PCS" : "Not applicable",
          ems: ipp.bessMw > 0 ? "Plant EMS with AGC interface" : "Not applicable",
          roundTripEfficiency: ipp.roundTripEfficiency,
          depthOfDischarge: ipp.depthOfDischarge,
          cycleCapability: ipp.bessMw > 0 ? 6000 : 0,
          availability: ipp.bessMw > 0 ? 0.97 : 0,
          degradation: ipp.bessDegradation,
          augmentation: ipp.bessMw > 0 ? "Augmentation reserved at year 10" : "Not applicable",
          yearSnapshots: [],
          augmentationPayer: ipp.bessMw > 0 ? "IPP" : "Not applicable",
          dispatchOwner: ipp.bessMw > 0 ? "NewRa scheduling, IPP asset owner" : "Not applicable",
          socMin: 0.1,
          socMax: 0.9,
          warranty: ipp.bessMw > 0 ? "15-year capacity warranty (illustrative)" : "Not applicable",
          performanceGuarantee: ipp.bessMw > 0 ? "Availability and round-trip efficiency" : "Not applicable",
          evidences: evidence("BESS duration", ipp.bessMw > 0 ? ipp.bessMwh / ipp.bessMw : 0, "hours"),
          dataQuality: ipp.bessMw > 0 ? "COMPLETE" : "MISSING",
        },
      },
      generation: {
        create: {
          p50Gwh: ipp.p50Gwh,
          p75Gwh: ipp.p75Gwh,
          p90Gwh: ipp.p90Gwh,
          resourceDatabase: "Illustrative mesoscale archive",
          siteMeasurements: ipp.generationValidation === "VERIFIED" ? "On-site measurements referenced" : "Site campaign incomplete",
          independentValidation: ipp.generationValidation === "MISSING" ? "PENDING" : ipp.generationValidation,
          monthly: monthlyGeneration(ipp.annualGenerationGwh, split.solarGwh / Math.max(ipp.annualGenerationGwh, 1)) as unknown as Prisma.InputJsonValue,
          intervals: [],
          evidences: evidence("P90 generation", ipp.p90Gwh, "GWh"),
          dataQuality: ipp.generationValidation === "VERIFIED" ? "COMPLETE" : "PARTIAL",
        },
      },
      ehv: {
        create: {
          kv132Experience: true,
          kv220Experience: ipp.baseScores.ehv >= 4.3,
          stuCoordination: "Experience stated, project consent not assumed",
          sldcCoordination: "Scheduling interface described",
          discomCoordination: "Consumer interconnection to be studied",
          systemStudies: ipp.weakSystemStudy ? "Desktop load-flow only" : "Load-flow, short-circuit and stability scoped",
          bay: "Bay scope identified, not granted",
          pooling: "Pooling substation in the CAPEX",
          protection: "Line and transformer protection specified",
          metering: "ABT metering specified",
          communication: "FOTE and SCADA gateway specified",
          rowStatus: ipp.connectivityStatus === "PRELIMINARY" ? "Route options open" : "Preferred route under survey",
          transmissionRouting: "Illustrative corridor only",
          connectivityStatus: ipp.connectivityStatus,
          capabilityScore: ipp.baseScores.ehv,
          connectivityRisk: "Pending calculation",
          evidenceStatus: ipp.connectivityStatus === "APPROVED" ? "VERIFIED" : "UNDER_REVIEW",
          evidences: evidence("Connectivity status", 0, ipp.connectivityStatus),
          dataQuality: ipp.connectivityStatus === "PRELIMINARY" ? "PARTIAL" : "COMPLETE",
        },
      },
      epc: { create: { contractor: ipp.epcCommitted ? "Named EPC under term sheet" : "EPC not appointed", commitment: ipp.epcCommitted ? "Term sheet" : "Indicative", procurementStrategy: "Owner-procured long-lead plus EPC balance", score: ipp.baseScores.epc } },
      execution: {
        create: {
          milestones: ipp.milestones as unknown as Prisma.InputJsonValue,
          criticalPath: [],
          longestLeadItem: "Pending calculation",
          regulatoryDependency: "Connectivity approval",
          procurementDependency: "Main transformers and, where offered, BESS cells",
          financingDependency: ipp.fundraisingDependency ? "Future equity raise" : "Lender sanction",
          projectBufferMonths: ipp.projectBufferMonths,
          internalCod: cod,
          contractualCod: cod,
          downsideCod: new Date(Date.UTC(ipp.codYear, 8, 30)),
          hasCpm: ipp.hasCpm,
          procurementAligned: ipp.procurementAligned,
          connectivityAssumed: ipp.connectivityAssumed,
          epcCommitted: ipp.epcCommitted,
        },
      },
      capex: {
        create: {
          totalInrCr: ipp.drivers.capexInrCr,
          credibilityScore: ipp.baseline.capexCredibility,
          dataQuality: ipp.lines.some((line) => line.assumptionType === "BUDGETARY") ? "PARTIAL" : "COMPLETE",
          items: {
            create: ipp.lines.map((line) => ({
              category: line.category,
              amountInrCr: line.amountInrCr,
              unit: "INR Cr",
              source: line.assumptionType === "FIRM" ? "Supplier term sheet" : "Internal estimate",
              evidence: `${line.category} ${line.assumptionType.toLowerCase()} support`,
              assumptionType: line.assumptionType,
              evidenceStatus: line.assumptionType === "FIRM" || line.assumptionType === "QUOTATION_SUPPORTED" ? "VERIFIED" : "UNDER_REVIEW",
            })),
          },
        },
      },
      financial: {
        create: {
          debtInrCr: 0,
          equityInrCr: 0,
          debtEquityRatio: round(ipp.drivers.debtRatio / (1 - ipp.drivers.debtRatio), 2),
          interestRate: ipp.drivers.interestRate,
          loanTenureYears: ipp.drivers.loanTenureYears,
          moratoriumYears: ipp.drivers.moratoriumYears,
          dscr: 0,
          equityRequirementInrCr: 0,
          projectIrr: 0,
          equityIrr: 0,
          financialClosureDate: ipp.financingScheduleMismatch ? null : new Date(Date.UTC(ipp.codYear - 2, 5, 30)),
          lenderExperience: ipp.lenderIdentified ? "Infrastructure lender engaged" : "Lender not identified",
          lenderIdentified: ipp.lenderIdentified,
          fundraisingDependency: ipp.fundraisingDependency,
          refinancingAssumptions: "No refinance assumed in the base case",
          capabilityScore: ipp.baseScores.financial,
          dataQuality: ipp.lenderIdentified ? "COMPLETE" : "PARTIAL",
          financingScheduleMismatch: ipp.financingScheduleMismatch,
        },
      },
      tariff: {
        create: {
          quotedTariff: ipp.quotedTariff,
          calculatedTariff: 0,
          sustainability: "SUSTAINABLE",
          escalationClear: ipp.escalationClear,
          evacuationExcluded: ipp.evacuationExcluded,
          bessExcluded: ipp.bessExcluded,
          drivers: ipp.drivers as unknown as Prisma.InputJsonValue,
        },
      },
      regulatory: {
        create: {
          items: regulatoryItems(ipp) as unknown as Prisma.InputJsonValue,
          protectionScore: ipp.baseScores.regulatory,
          changeInLaw: ipp.changeInLaw,
          curtailment: ipp.curtailment,
          indemnity: ipp.indemnity,
          complianceBearer: ipp.complianceBearer,
          delayBearer: ipp.delayBearer,
          dataQuality: ipp.changeInLaw === "UNLIMITED" ? "PARTIAL" : "COMPLETE",
        },
      },
      documents: {
        create: DOC_CATEGORIES.map((category, index) => ({
          id: `doc_${ipp.id}_${index}`,
          category,
          title: category.replaceAll("_", " "),
          status: statuses[index % statuses.length],
          ownerId: index % 2 === 0 ? "usr_technical" : "usr_finance",
          pendingFrom: statuses[index % statuses.length] === "VERIFIED" ? "None" : "IPP",
          location: "Illustrative data room",
          comments: "Document status is tracked separately from the evaluation stage.",
          versions: {
            create: [{
              version: 1,
              sentDate: new Date("2026-09-12"),
              receivedDate: statuses[index % statuses.length] === "REQUESTED" ? null : new Date("2026-09-28"),
              notes: "Illustrative version",
            }],
          },
        })),
      },
    },
  });
}

function regulatoryItems(ipp: SeedIpp) {
  const topics = ["Change in Law", "Open Access", "Transmission", "Wheeling", "Banking", "Scheduling", "DSM", "Metering", "Connectivity", "Grid compliance", "Captive qualification", "Taxes", "BESS treatment", "Curtailment"];
  return topics.map((topic) => ({
    topic,
    risk: topic === "Change in Law" && ipp.changeInLaw === "UNLIMITED" ? "High" : "Moderate",
    responsibility: topic === "Curtailment" ? ipp.curtailment : ipp.complianceBearer,
    ippExposure: ipp.complianceBearer === "IPP" ? "Primary" : "Shared",
    gesExposure: ipp.complianceBearer === "GES" ? "Primary" : "Limited",
    protection: ipp.changeInLaw,
    indemnity: ipp.indemnity,
  }));
}

function evidence(field: string, value: number, unit: string) {
  return [{ field, value: String(Math.round(value * 1000) / 1000), unit, source: "Illustrative IPP submission", evidence: `${field} sheet`, status: "RECEIVED", uploadedAt: "2026-10-01", reviewedBy: "Technical reviewer" }];
}

function round(value: number, digits = 2) {
  const factor = 10 ** digits;
  return Math.round(value * factor) / factor;
}

main()
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
