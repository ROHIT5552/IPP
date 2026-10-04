import { Prisma, PrismaClient } from "@prisma/client";
import { SeedIpp } from "../demo/catalog";
import { monthlyGeneration, technologyEnergySplit } from "../domain/profiles";

function round(value: number, digits = 2) {
  const factor = 10 ** digits;
  return Math.round(value * factor) / factor;
}

function evidence(field: string, value: number, unit: string) {
  return [{ field, value: String(round(value, 3)), unit, source: "Illustrative IPP submission", evidence: `${field} sheet`, status: "RECEIVED", uploadedAt: "2026-10-01", reviewedBy: "Technical reviewer" }];
}

export async function storeIpp(prisma: PrismaClient, ipp: SeedIpp) {
  const meta = ipp.meta;
  const split = technologyEnergySplit({ solarMw: ipp.solarMw, windMw: ipp.windMw, annualGenerationGwh: ipp.annualGenerationGwh });
  const tech = [ipp.solarMw ? "Solar" : null, ipp.windMw ? "Wind" : null, ipp.bessMw ? "BESS" : null].filter(Boolean).join(" + ");
  const cod = new Date(Date.UTC(ipp.codYear, 2, 31));
  await prisma.iPP.create({
    data: {
      id: ipp.id,
      name: ipp.name,
      legalName: meta.legalName,
      headquarters: meta.headquarters,
      technologySummary: tech || "Solar",
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
          acMw: ipp.solarMw, dcMw: round(ipp.solarMw * 1.35), dcAcRatio: ipp.solarMw > 0 ? 1.35 : 0,
          moduleTechnology: meta.module, inverterPhilosophy: meta.inverter, cuf: round(ipp.solarCuf, 4),
          degradation: 0.004, clipping: 0.015, auxiliaryConsumption: 0.012, availability: 0.985,
          evidences: evidence("Solar CUF", ipp.solarCuf, "%"), dataQuality: ipp.solarMw > 0 ? "COMPLETE" : "MISSING",
        },
      },
      windProfile: {
        create: {
          wtgRatingMw: ipp.windMw > 0 ? 4.2 : 0, hubHeightM: ipp.windMw > 0 ? 140 : 0, rotorDiameterM: ipp.windMw > 0 ? 160 : 0,
          resourceMethodology: ipp.windMw > 0 ? "Mesoscale plus on-site mast" : "Not applicable", cuf: round(ipp.windCuf, 4),
          wakeLoss: ipp.windMw > 0 ? 0.08 : 0, availability: ipp.windMw > 0 ? 0.97 : 0,
          evidences: evidence("Wind CUF", ipp.windCuf, "%"), dataQuality: ipp.windMw > 0 ? "COMPLETE" : "MISSING",
        },
      },
      bessProfile: {
        create: {
          powerMw: ipp.bessMw, energyMwh: ipp.bessMwh, usableEnergyMwh: ipp.usableEnergyMwh,
          durationHours: ipp.bessMw > 0 ? ipp.bessMwh / ipp.bessMw : 0, chemistry: meta.chemistry, oem: meta.oem,
          pcs: ipp.bessMw > 0 ? "Central PCS" : "Not applicable", ems: ipp.bessMw > 0 ? "Plant EMS" : "Not applicable",
          roundTripEfficiency: ipp.roundTripEfficiency, depthOfDischarge: ipp.depthOfDischarge,
          cycleCapability: ipp.bessMw > 0 ? 6000 : 0, availability: ipp.bessMw > 0 ? 0.97 : 0, degradation: ipp.bessDegradation,
          augmentation: ipp.bessMw > 0 ? "Augmentation reserved at year 10" : "Not applicable", yearSnapshots: [],
          augmentationPayer: ipp.bessMw > 0 ? "IPP" : "Not applicable", dispatchOwner: ipp.bessMw > 0 ? "IPP asset owner" : "Not applicable",
          socMin: 0.1, socMax: 0.9, warranty: ipp.bessMw > 0 ? "Illustrative capacity warranty" : "Not applicable",
          performanceGuarantee: ipp.bessMw > 0 ? "Availability and round-trip efficiency" : "Not applicable",
          evidences: evidence("BESS duration", ipp.bessMw > 0 ? ipp.bessMwh / ipp.bessMw : 0, "hours"),
          dataQuality: ipp.bessMw > 0 ? "COMPLETE" : "MISSING",
        },
      },
      generation: {
        create: {
          p50Gwh: ipp.p50Gwh, p75Gwh: ipp.p75Gwh, p90Gwh: ipp.p90Gwh,
          resourceDatabase: "Illustrative mesoscale archive", siteMeasurements: "Entered with the IPP record",
          independentValidation: ipp.generationValidation === "MISSING" ? "PENDING" : ipp.generationValidation,
          monthly: monthlyGeneration(ipp.annualGenerationGwh, split.solarGwh / Math.max(ipp.annualGenerationGwh, 1)) as unknown as Prisma.InputJsonValue,
          intervals: [], evidences: evidence("P90 generation", ipp.p90Gwh, "GWh"), dataQuality: "PARTIAL",
        },
      },
      ehv: {
        create: {
          kv132Experience: true, kv220Experience: ipp.baseScores.ehv >= 4.3, stuCoordination: "To be studied", sldcCoordination: "To be studied",
          discomCoordination: "To be studied", systemStudies: "Scoped with the new record", bay: "Bay scope identified", pooling: "Pooling in CAPEX",
          protection: "Specified", metering: "ABT metering specified", communication: "SCADA gateway specified", rowStatus: "Route options open",
          transmissionRouting: "Illustrative corridor", connectivityStatus: ipp.connectivityStatus, capabilityScore: ipp.baseScores.ehv,
          connectivityRisk: "Pending calculation", evidenceStatus: "UNDER_REVIEW", evidences: evidence("Connectivity", 0, ipp.connectivityStatus), dataQuality: "PARTIAL",
        },
      },
      epc: { create: { contractor: ipp.epcCommitted ? "Named at entry" : "Not appointed", commitment: "Indicative", procurementStrategy: "Owner-procured long-lead", score: ipp.baseScores.epc } },
      execution: {
        create: {
          milestones: ipp.milestones as unknown as Prisma.InputJsonValue, criticalPath: [], longestLeadItem: "Pending calculation",
          regulatoryDependency: "Connectivity approval", procurementDependency: "Main equipment", financingDependency: "Lender sanction",
          projectBufferMonths: ipp.projectBufferMonths, internalCod: cod, contractualCod: cod, downsideCod: new Date(Date.UTC(ipp.codYear, 8, 30)),
          hasCpm: ipp.hasCpm, procurementAligned: ipp.procurementAligned, connectivityAssumed: ipp.connectivityAssumed, epcCommitted: ipp.epcCommitted,
        },
      },
      capex: {
        create: {
          totalInrCr: ipp.drivers.capexInrCr, credibilityScore: ipp.baseline.capexCredibility, dataQuality: "PARTIAL",
          items: { create: ipp.lines.map((line) => ({ category: line.category, amountInrCr: line.amountInrCr, unit: "INR Cr", source: "Entered with the IPP", evidence: line.category, assumptionType: line.assumptionType, evidenceStatus: "UNDER_REVIEW" })) },
        },
      },
      financial: {
        create: {
          debtInrCr: 0, equityInrCr: 0, debtEquityRatio: round(ipp.drivers.debtRatio / (1 - ipp.drivers.debtRatio), 2),
          interestRate: ipp.drivers.interestRate, loanTenureYears: ipp.drivers.loanTenureYears, moratoriumYears: ipp.drivers.moratoriumYears,
          dscr: 0, equityRequirementInrCr: 0, projectIrr: 0, equityIrr: 0, financialClosureDate: new Date(Date.UTC(ipp.codYear - 2, 5, 30)),
          lenderExperience: "Entered with the IPP", lenderIdentified: ipp.lenderIdentified, fundraisingDependency: ipp.fundraisingDependency,
          refinancingAssumptions: "No refinance assumed", capabilityScore: ipp.baseScores.financial, dataQuality: "PARTIAL", financingScheduleMismatch: ipp.financingScheduleMismatch,
        },
      },
      tariff: {
        create: {
          quotedTariff: ipp.quotedTariff, calculatedTariff: 0, sustainability: "SUSTAINABLE", escalationClear: ipp.escalationClear,
          evacuationExcluded: ipp.evacuationExcluded, bessExcluded: ipp.bessExcluded, drivers: ipp.drivers as unknown as Prisma.InputJsonValue,
        },
      },
      regulatory: {
        create: {
          items: [] as unknown as Prisma.InputJsonValue, protectionScore: ipp.baseScores.regulatory, changeInLaw: ipp.changeInLaw,
          curtailment: ipp.curtailment, indemnity: ipp.indemnity, complianceBearer: ipp.complianceBearer, delayBearer: ipp.delayBearer, dataQuality: "PARTIAL",
        },
      },
    },
  });
}
