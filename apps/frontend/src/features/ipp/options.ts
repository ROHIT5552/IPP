import { STATES } from '../ges/options';

export { STATES };

export const IPP_TECHNOLOGIES = [
  'Solar',
  'Wind',
  'Solar + Wind',
  'Solar + BESS',
  'Wind + BESS',
  'Solar + Wind + BESS',
];

export const GENERATION_INTERVALS = ['Available', 'Not Available'];
export const FDRE_OPTIONS = ['Yes', 'No', 'To Be Evaluated'];
export const GRID_VOLTAGES = ['33 kV', '66 kV', '110 kV', '132 kV', '220 kV', '400 kV', 'Other'];
export const GRID_CONNECTIVITY = ['Not Applied', 'Application Submitted', 'Under Approval', 'Approved', 'Connected', 'Unknown'];
export const OPEN_ACCESS = ['Ready', 'In Progress', 'Not Ready', 'Unknown'];
export const TARIFF_TYPES = ['Fixed', 'Escalable', 'Negotiable', 'Other'];
export const PROJECT_STATUSES = ['Concept', 'Land Secured', 'Development', 'Under Construction', 'Commissioned', 'Operational', 'On Hold', 'Unknown'];
export const COD_CONFIDENCE = ['High', 'Medium', 'Low', 'Unknown'];
export const FINANCIAL_MODEL = ['Yes', 'No', 'In Progress'];
export const FUNDING_STATUS = ['Fully Funded', 'Partially Funded', 'Funding Required', 'Unknown'];

const ENGINE_CONNECTIVITY: Record<string, string> = {
  APPLICATION_SUBMITTED: 'Application Submitted',
  APPROVAL_PENDING: 'Under Approval',
  APPROVED: 'Approved',
};

export function includesBess(technology: string) {
  return technology.split('+').some((part) => part.trim().toUpperCase() === 'BESS');
}

export function connectivityValue(stored: string | null | undefined, engine: string | null | undefined) {
  if (stored) return stored;
  if (engine && ENGINE_CONNECTIVITY[engine]) return ENGINE_CONNECTIVITY[engine];
  return '';
}

export function withCurrent(options: string[], current?: string | null) {
  if (current && !options.includes(current)) return [current, ...options];
  return options;
}
