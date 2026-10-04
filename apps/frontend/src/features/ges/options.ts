export const BUSINESS_TYPES = ['Industrial Consumer', 'Commercial Consumer', 'Residential'];

export const STATES = [
  'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana',
  'Himachal Pradesh', 'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur',
  'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana',
  'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Delhi', 'Jammu and Kashmir', 'Ladakh',
  'Puducherry', 'Chandigarh',
];

export const DISCOMS = [
  'MSEDCL', 'UGVCL', 'MGVCL', 'DGVCL', 'PGVCL', 'GESCOM', 'BESCOM', 'MESCOM', 'HESCOM', 'CESCOM',
  'TANGEDCO', 'APEPDCL', 'APSPDCL', 'TSSPDCL', 'TSNPDCL', 'KSEB', 'CSPDCL', 'MPPKVVCL', 'PSPCL',
  'JVVNL', 'AVVNL', 'JDVVNL', 'UHBVN', 'DHBVN', 'WBSEDCL', 'TPDDL', 'BRPL', 'BYPL',
  'Adani Electricity Mumbai', 'Tata Power Mumbai',
];

export const TECHNOLOGIES = [
  { value: 'SOLAR', label: 'Solar' },
  { value: 'WIND', label: 'Wind' },
  { value: 'SOLAR+WIND', label: 'Solar + Wind' },
  { value: 'SOLAR+BESS', label: 'Solar + BESS' },
  { value: 'WIND+BESS', label: 'Wind + BESS' },
  { value: 'SOLAR+WIND+BESS', label: 'Solar + Wind + BESS' },
  { value: 'NONE', label: 'No preference' },
];

export const BESS_REQUIREMENTS = [
  { value: 'REQUIRED', label: 'Required' },
  { value: 'PREFERRED', label: 'Preferred' },
  { value: 'OPTIONAL', label: 'Optional' },
  { value: 'NOT_REQUIRED', label: 'Not required' },
  { value: 'TO_BE_EVALUATED', label: 'To be evaluated' },
];

export const SOLAR_CONNECTIONS = ['Net Metering', 'Gross Metering', 'Net Billing', 'Behind the Meter', 'Open Access'];

export function technologyKey(technologies: string[]): string {
  const solar = technologies.includes('SOLAR');
  const wind = technologies.includes('WIND');
  const bess = technologies.includes('BESS');
  if (solar && wind && bess) return 'SOLAR+WIND+BESS';
  if (solar && wind) return 'SOLAR+WIND';
  if (solar && bess) return 'SOLAR+BESS';
  if (wind && bess) return 'WIND+BESS';
  if (solar) return 'SOLAR';
  if (wind) return 'WIND';
  if (!solar && !wind && !bess) return '';
  return '';
}

export function technologyLabel(technologies: string[]): string {
  const key = technologyKey(technologies);
  return TECHNOLOGIES.find((item) => item.value === key)?.label || 'Not specified';
}

export function bessKey(stored: string | null | undefined, preference: string): string {
  if (stored) return stored;
  if (preference === 'HOURS_4') return 'REQUIRED';
  if (preference === 'HOURS_2_TO_4') return 'PREFERRED';
  if (preference === 'OPTIONAL') return 'OPTIONAL';
  return '';
}

export function bessLabel(stored: string | null | undefined, preference: string): string {
  const key = bessKey(stored, preference);
  return BESS_REQUIREMENTS.find((item) => item.value === key)?.label || 'Not specified';
}

export function withCurrent(options: string[], current?: string | null): string[] {
  if (current && !options.includes(current)) return [current, ...options];
  return options;
}
