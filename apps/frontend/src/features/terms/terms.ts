export const TERMS: Record<string, { title: string; description: string; why: string }> = {
  P90: {
    title: 'P90 generation',
    description: 'P90 is a conservative estimate of the energy a project is expected to generate. It is a level expected to be exceeded in about 90% of modeled cases.',
    why: 'It shows how much dependable generation the IPP can offer against the GES requirement. Annual generation alone is not treated as dependable supply.',
  },
  FDRE: {
    title: 'FDRE',
    description: 'Firm and Dispatchable Renewable Energy. Renewable supply designed to follow a more controlled delivery profile, which may use generation and storage together.',
    why: 'A GES that needs firmer supply places more importance on this capability. Storage by itself is not treated as FDRE.',
  },
  BESS: {
    title: 'BESS',
    description: 'Battery Energy Storage System. It stores electricity and can release it later.',
    why: 'Storage can help an IPP follow a GES load. If the GES does not require storage, the absence of BESS is not treated as a failure by itself.',
  },
  COD: {
    title: 'COD',
    description: 'Commercial Operation Date. The year the project is expected to start supplying power.',
    why: 'The IPP needs to be ready in time for the GES target supply start.',
  },
  EHV: {
    title: 'EHV',
    description: 'Extra High Voltage grid connection.',
    why: 'Connectivity is reviewed from the project record. It is not assumed to be approved.',
  },
  CAPEX: {
    title: 'CAPEX',
    description: 'Capital expenditure. The money required to develop and build the power project, before it starts supplying electricity.',
    why: 'An indicative cost still leaves the IPP able to match a GES. A quotation or firm figure makes that match stronger. A missing cost is shown as unavailable, not as zero.',
  },
  'Credible CAPEX': {
    title: 'Credible CAPEX',
    description: 'Whether the project cost is firm, backed by a quotation, or still an estimate.',
    why: 'An indicative cost means the IPP can still match the GES. The check asks for a firmer cost later. It does not mean the IPP cannot supply.',
  },
  DSCR: {
    title: 'DSCR',
    description: 'Debt Service Coverage Ratio. It indicates whether project cash flow can cover debt payments.',
    why: 'It is used only when a financial assessment already exists.',
  },
  IRR: {
    title: 'IRR',
    description: 'Internal Rate of Return. A measure of investment return.',
    why: 'It is shown only when the stored financial model contains it.',
  },
  'Open Access': {
    title: 'Open Access',
    description: 'The arrangement that lets eligible consumers and generators use the network, subject to the applicable rules.',
    why: 'Readiness is taken from the IPP record. It is not assumed.',
  },
  'Requirement Match': {
    title: 'Requirement match',
    description: 'How closely this IPP satisfies the selected GES requirement, using the configured factor weights.',
    why: 'It is a decision-support measure. It is not a recommendation to award the supply.',
  },
  'Required Checks': {
    title: 'Evidence notes',
    description: 'Items that can make an already capable IPP a firmer match, such as a quotation for CAPEX or a confirmed grid connection.',
    why: 'These notes do not cancel the requirement match. An IPP can match the GES while one piece of evidence is still being strengthened.',
  },
  Matchability: {
    title: 'Matchability',
    description: 'How capable this IPP is of meeting this GES requirement. It follows the requirement match.',
    why: 'A strong match means the IPP can supply this GES. Remaining evidence, such as an indicative CAPEX, is a way to strengthen that match.',
  },
  'Load match': {
    title: 'Load match',
    description: 'How closely the IPP’s generation follows the GES electricity use, interval by interval.',
    why: 'Annual energy can be enough while the hourly shape still differs. Both figures are shown.',
  },
  'IPP Evaluation': {
    title: 'IPP evaluation',
    description: 'The detailed assessment of an IPP against the selected GES requirement.',
    why: 'Generation, technology, storage, COD, tariff, grid, execution, finance, and evidence are reviewed separately.',
  },
  Shortlist: {
    title: 'Shortlist',
    description: 'A workflow step. An authorized user moves an IPP into the next decision stage.',
    why: 'The highest requirement match is not shortlisted automatically.',
  },
  EPC: {
    title: 'EPC',
    description: 'Engineering, Procurement and Construction. The contractor that designs, buys equipment, and builds the project.',
    why: 'A capable EPC partner is part of whether the IPP can actually deliver the plant.',
  },
  Execution: {
    title: 'Execution',
    description: 'The IPP’s record of building plants and keeping to a delivery plan.',
    why: 'A strong generation offer still needs a developer who has delivered comparable projects.',
  },
  Financial: {
    title: 'Financial strength',
    description: 'Whether the IPP has the balance sheet, equity, and funding path to build the project.',
    why: 'A project that cannot be financed cannot supply the GES.',
  },
  Engineering: {
    title: 'Engineering',
    description: 'The technical design capability behind the plant, including studies and detailed engineering.',
    why: 'It shows whether the offered design can be built and operated as described.',
  },
  Tariff: {
    title: 'Tariff',
    description: 'The price of electricity in the power purchase agreement, usually shown in rupees per kWh.',
    why: 'The price has to stay payable after construction cost, finance, and operating cost.',
  },
  Regulatory: {
    title: 'Regulatory protection',
    description: 'How the contract handles changes in law, grid rules, curtailment, and compliance.',
    why: 'A low tariff is less useful if regulatory risk sits entirely with the buyer.',
  },
  CUF: {
    title: 'CUF',
    description: 'Capacity Utilisation Factor. The share of a plant’s rated capacity that it actually generates over a period.',
    why: 'A lower CUF means less energy from the same installed capacity.',
  },
  PPA: {
    title: 'PPA',
    description: 'Power Purchase Agreement. The contract to buy electricity from the project.',
    why: 'Price, term, and delivery obligations in the PPA decide whether the supply fits the GES.',
  },
  P50: {
    title: 'P50 generation',
    description: 'A central estimate of energy output. About half of modeled years are expected to generate at least this much.',
    why: 'P50 is the typical case. P90 is the more conservative case used for dependable supply.',
  },
  SCADA: {
    title: 'SCADA',
    description: 'Supervisory Control and Data Acquisition. The system that monitors and controls the plant and its schedule.',
    why: 'NewRa needs this link so generation can be scheduled and seen in operation.',
  },
};

export function findTerm(label: string) {
  const trimmed = label.trim();
  if (TERMS[trimmed]) return TERMS[trimmed];
  const lower = trimmed.toLowerCase();
  const exact = Object.keys(TERMS).find((key) => key.toLowerCase() === lower);
  if (exact) return TERMS[exact];
  const contained = Object.keys(TERMS)
    .filter((key) => key.length >= 3 && new RegExp(`(?:^|[^a-z0-9])${key.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}(?:[^a-z0-9]|$)`, 'i').test(trimmed))
    .sort((left, right) => right.length - left.length)[0];
  return contained ? TERMS[contained] : undefined;
}
