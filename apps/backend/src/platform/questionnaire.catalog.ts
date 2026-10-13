export type QuestionKind = "numeric" | "text" | "long";

export interface QuestionnaireQuestion {
  key: string;
  prompt: string;
  kind: QuestionKind;
  unit?: string;
}

export interface QuestionnaireSection {
  id: string;
  title: string;
  intro?: string;
  questions: QuestionnaireQuestion[];
}

function slug(value: string) {
  return value
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "")
    .slice(0, 80);
}

function fields(
  section: string,
  rows: Array<[string, QuestionKind, string?]>,
): QuestionnaireQuestion[] {
  return rows.map(([prompt, kind, unit]) => ({
    key: `${section}-${slug(prompt)}`,
    prompt,
    kind,
    ...(unit ? { unit } : {}),
  }));
}

const MILESTONES = [
  "Detailed engineering",
  "Connectivity application",
  "System studies",
  "Connectivity approval",
  "Financial closure",
  "EPC appointment",
  "Major procurement",
  "Civil commencement",
  "Evacuation construction",
  "Major equipment delivery",
  "Substation/bay readiness",
  "Mechanical completion",
  "Electrical completion",
  "Synchronisation",
  "Trial operation",
  "COD",
];

export const QUESTIONNAIRE: QuestionnaireSection[] = [
  {
    id: "experience",
    title: "1. Experience and execution capability",
    intro: "Commissioned capacity and delivery record.",
    questions: fields("experience", [
      ["Solar capacity commissioned", "numeric", "MW"],
      ["Wind capacity commissioned", "numeric", "MW"],
      ["Hybrid capacity commissioned", "numeric", "MW"],
      ["Hydro capacity commissioned", "numeric", "MW"],
      ["Any other renewable resource", "text"],
      ["BESS power commissioned", "numeric", "MW"],
      ["BESS energy commissioned", "numeric", "MWh"],
      ["Captive / group captive capacity", "numeric", "MW"],
      ["Industrial open access capacity", "numeric", "MW"],
      ["Capacity commissioned in the last five years", "numeric", "MW"],
      ["Projects that achieved COD on the original timeline", "numeric"],
      ["Average delay on delayed projects", "numeric", "months"],
      ["Major causes of delay", "long"],
      ["At least three comparable projects supplied to industrial consumers", "long"],
      ["Largest single project executed", "numeric", "MW"],
      ["Capacity currently under construction", "numeric", "MW"],
      ["Projects being executed at the same time", "numeric"],
      ["Project-management team allocated to this project", "long"],
    ]),
  },
  {
    id: "ehv",
    title: "2. EHV connectivity and evacuation",
    intro: "Ability to execute connectivity, not whether the project already owns it.",
    questions: fields("ehv", [
      ["Experience with 132 kV / 220 kV / EHV project evacuation", "long"],
      ["Projects where new connectivity was obtained rather than existing connectivity", "long"],
      ["Experience coordinating with STU, transmission licensee, SLDC and DISCOM", "long"],
      ["Information required to start connectivity studies once project details are available", "long"],
      ["Studies performed before filing for connectivity", "long"],
      ["Time to prepare and submit the connectivity application after complete inputs", "text"],
      ["Methodology for network capacity, voltage, injection, bay, pooling, protection, metering, communication, RoW and line routing", "long"],
      ["What decides direct 220 kV connectivity, pooling, or another arrangement", "long"],
      ["Principal connectivity risks that can affect COD", "long"],
      ["How augmentation would be managed", "long"],
      ["Who owns connectivity until commissioning", "text"],
    ]),
  },
  {
    id: "technical",
    title: "3. Technical design and generation performance",
    questions: fields("technical", [
      ["Solar AC capacity", "numeric", "MW"],
      ["Solar DC capacity", "numeric", "MW"],
      ["DC/AC ratio", "numeric"],
      ["Module technology", "text"],
      ["Module manufacturer criteria", "text"],
      ["Inverter philosophy", "text"],
      ["Expected solar CUF", "numeric", "%"],
      ["Solar degradation", "text"],
      ["Clipping losses", "numeric", "%"],
      ["Auxiliary consumption", "numeric", "%"],
      ["Solar availability assumption", "numeric", "%"],
      ["Proposed WTG technology", "text"],
      ["Turbine rating", "numeric", "MW"],
      ["Hub height", "numeric", "m"],
      ["Rotor diameter", "numeric", "m"],
      ["Wind resource assessment methodology", "long"],
      ["Expected wind CUF", "numeric", "%"],
      ["Wake losses", "numeric", "%"],
      ["Wind availability assumption", "numeric", "%"],
      ["Methodology for P50 generation", "long"],
      ["Methodology for P75 generation", "long"],
      ["Methodology for P90 generation", "long"],
      ["Resource databases and site measurements used", "long"],
      ["Independent energy-yield validation normally obtained", "long"],
      ["How aggressive CUF assumptions are kept from being used only to cut the tariff", "long"],
      ["Month-wise expected generation", "long"],
      ["Expected 15-minute generation characteristics", "long"],
    ]),
  },
  {
    id: "fdre",
    title: "4. FDRE and load matching",
    intro: "Engineering against an industrial load curve, not only annual energy.",
    questions: fields("fdre", [
      ["How solar, wind and BESS would be sized against a 15-minute demand profile", "long"],
      ["Optimisation methodology", "long"],
      ["How annual generation, 15-minute fulfilment, surplus, deficit, CAPEX and BESS cycling are balanced", "long"],
      ["How the solar : wind : BESS mix is chosen", "long"],
      ["Parameters that set the optimum BESS capacity", "long"],
      ["Behaviour in low-solar, low-wind, monsoon, outage and P90 conditions", "long"],
      ["Generation and load matching that can be supported contractually", "long"],
    ]),
  },
  {
    id: "bess",
    title: "5. BESS capability",
    questions: fields("bess", [
      ["BESS power", "numeric", "MW"],
      ["BESS energy", "numeric", "MWh"],
      ["Usable energy", "numeric", "MWh"],
      ["Duration", "numeric", "hours"],
      ["Chemistry", "text"],
      ["OEM", "text"],
      ["PCS", "text"],
      ["EMS", "text"],
      ["Round-trip efficiency", "numeric", "%"],
      ["Depth of discharge", "numeric", "%"],
      ["Cycle capability", "numeric"],
      ["BESS availability", "numeric", "%"],
      ["BESS degradation", "text"],
      ["Augmentation requirement", "text"],
      ["Guaranteed usable capacity at years 1, 5, 10 and 15", "long"],
      ["Augmentation assumed", "text"],
      ["Who bears augmentation cost", "text"],
      ["Operating state-of-charge range", "text"],
      ["BESS dispatch philosophy", "long"],
      ["Can dispatch respond to NewRa portfolio scheduling", "text"],
      ["What happens if BESS availability falls below the guarantee", "long"],
    ]),
  },
  {
    id: "epc",
    title: "6. EPC, procurement and execution",
    questions: fields("epc", [
      ["Will EPC be internal or external", "text"],
      ["Preferred EPC contractors", "long"],
      ["Their execution record", "long"],
      ["Proposed or acceptable OEMs for modules, inverters, WTGs, transformers, BESS, PCS and switchgear", "long"],
      ["Equipment with the longest procurement lead time", "text"],
      ["Procurement that can start before financial closure", "long"],
      ["How manufacturing slots are secured", "long"],
      ["How the project is protected against equipment price escalation", "long"],
      ["EPC delay liquidated damages normally obtained", "text"],
      ["Equipment performance guarantees that will support the PPA", "long"],
    ]),
  },
  {
    id: "programme",
    title: "7. Project execution programme",
    intro: "For each milestone, give the target, who is responsible, and what it depends on.",
    questions: MILESTONES.flatMap((milestone) =>
      fields(`programme-${slug(milestone)}`, [
        [`${milestone} — target`, "text"],
        [`${milestone} — responsibility`, "text"],
        [`${milestone} — dependency`, "text"],
      ]),
    ).concat(
      fields("programme", [
        ["Critical-path activities", "long"],
        ["Longest-lead item", "text"],
        ["Regulatory dependencies", "long"],
        ["Procurement dependencies", "long"],
        ["Financing dependencies", "long"],
        ["Project buffer", "text"],
        ["Internal target COD", "text"],
        ["Contractual COD", "text"],
        ["Realistic downside COD", "text"],
      ]),
    ),
  },
  {
    id: "capex",
    title: "8. Project CAPEX model",
    questions: fields("capex", [
      ["Solar CAPEX", "numeric", "₹ crore"],
      ["Wind CAPEX", "numeric", "₹ crore"],
      ["BESS CAPEX", "numeric", "₹ crore"],
      ["EPC cost", "numeric", "₹ crore"],
      ["Pooling substation", "numeric", "₹ crore"],
      ["Transmission / evacuation", "numeric", "₹ crore"],
      ["Bay / interconnection", "numeric", "₹ crore"],
      ["SCADA / EMS", "numeric", "₹ crore"],
      ["Metering", "numeric", "₹ crore"],
      ["Civil works", "numeric", "₹ crore"],
      ["Development cost", "numeric", "₹ crore"],
      ["Interest during construction", "numeric", "₹ crore"],
      ["Taxes and duties", "numeric", "₹ crore"],
      ["Insurance", "numeric", "₹ crore"],
      ["Contingency", "numeric", "₹ crore"],
      ["Other material CAPEX", "numeric", "₹ crore"],
      ["Solar CAPEX per MW", "numeric", "₹ / MW"],
      ["Wind CAPEX per MW", "numeric", "₹ / MW"],
      ["BESS CAPEX per MWh", "numeric", "₹ / MWh"],
      ["Evacuation CAPEX assumed", "numeric", "₹ crore"],
      ["Which costs are firm, quoted, indicative or budgetary", "long"],
      ["Contingency percentage in the model", "numeric", "%"],
      ["Escalation assumed between proposal and procurement", "numeric", "%"],
      ["Costs currently excluded from CAPEX", "long"],
      ["Cost items that could reopen the tariff", "long"],
    ]),
  },
  {
    id: "finance",
    title: "9. Financial structure",
    questions: fields("finance", [
      ["Debt / equity ratio", "text"],
      ["Interest rate", "numeric", "%"],
      ["Loan tenure", "numeric", "years"],
      ["Moratorium", "numeric", "months"],
      ["DSCR", "numeric"],
      ["Equity requirement", "numeric", "₹ crore"],
      ["Project IRR", "numeric", "%"],
      ["Equity IRR", "numeric", "%"],
      ["Refinancing assumption", "text"],
      ["How soon after PPA financial closure can be achieved", "text"],
      ["Lenders that have previously financed your projects", "long"],
      ["Does the project need a signed PPA before lender sanction", "text"],
      ["Development expenditure that can be committed before financial closure", "numeric", "₹ crore"],
      ["Lender requirements that could delay COD", "long"],
      ["Equity that can be deployed without further fundraising", "numeric", "₹ crore"],
    ]),
  },
  {
    id: "tariff",
    title: "10. PPA pricing model",
    intro: "Show how the quoted ₹/unit tariff is built up.",
    questions: fields("tariff", [
      ["Generation CAPEX recovery in the tariff", "numeric", "₹/kWh"],
      ["Debt servicing in the tariff", "numeric", "₹/kWh"],
      ["Equity return in the tariff", "numeric", "₹/kWh"],
      ["O&M in the tariff", "numeric", "₹/kWh"],
      ["Insurance in the tariff", "numeric", "₹/kWh"],
      ["Land-related cost in the tariff", "numeric", "₹/kWh"],
      ["Evacuation in the tariff", "numeric", "₹/kWh"],
      ["BESS in the tariff", "numeric", "₹/kWh"],
      ["Replacement / augmentation in the tariff", "numeric", "₹/kWh"],
      ["Degradation in the tariff", "numeric", "₹/kWh"],
      ["Development cost in the tariff", "numeric", "₹/kWh"],
      ["Regulatory risk in the tariff", "numeric", "₹/kWh"],
      ["Contingency in the tariff", "numeric", "₹/kWh"],
      ["Returns in the tariff", "numeric", "₹/kWh"],
      ["Generation denominator used to derive the tariff", "text"],
      ["Is the tariff based on P50, P75 or another case", "text"],
      ["CUF assumed for the tariff", "numeric", "%"],
      ["Project IRR that supports the tariff", "numeric", "%"],
      ["Equity IRR that supports the tariff", "numeric", "%"],
      ["Portion of the tariff that relates to BESS", "numeric", "₹/kWh"],
      ["Is BESS augmentation included", "text"],
      ["Is the tariff completely fixed", "text"],
      ["If not, which components are variable", "long"],
      ["Is any component indexed", "text"],
      ["Events that permit repricing", "long"],
      ["Pricing assumptions that could change between PSOA and PPA", "long"],
      ["Effect if CAPEX rises 5%", "text"],
      ["Effect if interest rates rise 1%", "text"],
      ["Effect if COD is delayed six months", "text"],
      ["Effect if CUF reduces", "text"],
      ["Effect if BESS cost increases", "text"],
    ]),
  },
  {
    id: "sustainability",
    title: "11. Pricing sustainability",
    questions: fields("sustainability", [
      ["How the quoted ₹/unit tariff was arrived at, from CAPEX through financing, generation, operating cost, return and regulatory risk", "long"],
    ]),
  },
  {
    id: "regulatory",
    title: "12. Regulatory risk and protection",
    questions: fields("regulatory", [
      ["How the PPA allocates change-in-law risk", "long"],
      ["Which events qualify as change in law", "long"],
      ["Does change in law permit automatic tariff reopening", "text"],
      ["Is there a materiality threshold", "text"],
      ["Is there a cap", "text"],
      ["Is regulatory protection symmetrical", "text"],
      ["If a regulatory change reduces cost, does the consumer receive the benefit", "text"],
      ["How changes to open access, transmission, wheeling, banking, scheduling, DSM, metering, connectivity, Grid Code, captive status, taxes, BESS and renewable compliance are addressed", "long"],
      ["Costs that stay with the generator regardless of regulatory change", "long"],
      ["Costs proposed as consumer statutory pass-throughs", "long"],
      ["What happens if connectivity methodology changes after the PPA", "long"],
      ["What happens if augmentation becomes necessary", "long"],
      ["How grid curtailment is treated", "long"],
      ["How deemed generation is treated", "long"],
      ["How a transmission-system outage is treated", "long"],
      ["How a generator outage is treated", "long"],
      ["How regulatory delay is treated for COD", "long"],
    ]),
  },
  {
    id: "captive",
    title: "13. Group captive regulatory protection",
    questions: fields("captive", [
      ["Ownership-compliance mechanism", "long"],
      ["Consumption-compliance mechanism", "long"],
      ["Annual monitoring", "long"],
      ["Consumer allocation", "long"],
      ["Corrective mechanism", "long"],
      ["Equity transfer process", "long"],
      ["Exit mechanism", "long"],
      ["Who monitors continuing captive compliance", "text"],
      ["What happens if another captive consumer affects proportional compliance", "long"],
      ["Who bears the cost if captive qualification is lost because of the generator or SPV", "long"],
      ["Indemnity offered against generator-side non-compliance", "long"],
    ]),
  },
  {
    id: "operations",
    title: "14. Operations, SCADA and NewRa integration",
    questions: fields("operations", [
      ["Who will undertake O&M", "text"],
      ["Plant availability guaranteed", "numeric", "%"],
      ["BESS availability guaranteed", "numeric", "%"],
      ["Is 24x7 remote monitoring available", "text"],
      ["Can NewRa receive live SCADA data", "text"],
      ["Can data be provided at 15-minute or finer resolution", "text"],
      ["Can the plant EMS interface with NewRa scheduling", "text"],
      ["How forecasting and scheduling will be coordinated", "long"],
      ["Response mechanism for generation deviations", "long"],
      ["Spare-parts strategy", "long"],
      ["Guaranteed restoration time for major equipment failure", "text"],
    ]),
  },
];

export const QUESTION_INDEX = new Map(
  QUESTIONNAIRE.flatMap((section) => section.questions.map((question) => [question.key, question] as const)),
);

export const QUESTION_SECTION = new Map(
  QUESTIONNAIRE.flatMap((section) => section.questions.map((question) => [question.key, section.id] as const)),
);

export const FACTOR_SECTIONS: Record<string, string[]> = {
  execution: ["experience"],
  financial: ["finance"],
  ehv: ["ehv"],
  engineering: ["technical", "operations"],
  fdre: ["fdre", "bess"],
  epc: ["epc"],
  cod: ["programme"],
  capex: ["capex"],
  tariff: ["tariff", "sustainability"],
  regulatory: ["regulatory", "captive"],
};

export function suggestedRating(kind: QuestionKind, value: string): number | null {
  const text = value.trim();
  if (!text) return null;
  if (kind === "numeric") {
    const number = Number(text);
    if (!Number.isFinite(number)) return null;
    if (number <= 0) return 3;
    if (number < 10) return 6;
    if (number < 100) return 8;
    return 10;
  }
  if (text.length < 20) return 5;
  if (text.length < 120) return 7;
  return 9;
}
