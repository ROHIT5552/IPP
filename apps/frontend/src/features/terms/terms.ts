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
    description: 'Capital expenditure. The cost to develop and build the project.',
    why: 'It is one input to financial readiness. A missing cost figure is shown as unavailable, not as a zero.',
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
    title: 'Required checks',
    description: 'Checks that must be reviewed before an IPP can move further in the decision workflow.',
    why: 'A high requirement match does not clear a failed check. Only a failed check blocks shortlist eligibility. A conditional result stays in review.',
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
};
