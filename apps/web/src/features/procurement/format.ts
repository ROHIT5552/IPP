export type Provenance = 'BILL_VERIFIED' | 'CALCULATED' | 'CLIENT_PROVIDED' | string;

export function provenanceLabel(value?: string) {
  if (value === 'BILL_VERIFIED') return 'Bill verified';
  if (value === 'CALCULATED') return 'Calculated';
  if (value === 'CLIENT_PROVIDED') return 'Client provided';
  return value || '';
}

export function provenanceKind(value?: string): 'verified' | 'calculated' | 'customer' {
  if (value === 'BILL_VERIFIED') return 'verified';
  if (value === 'CALCULATED') return 'calculated';
  return 'customer';
}

export function amount(value: number | null | undefined, digits = 2) {
  if (value == null || Number.isNaN(value)) return '—';
  return value.toLocaleString('en-IN', { maximumFractionDigits: digits });
}

export function inr(value: number | null | undefined) {
  if (value == null || Number.isNaN(value)) return '—';
  return `₹${value.toFixed(2)}/kWh`;
}

export function selectionStatus(status: string) {
  const labels: Record<string, string> = {
    CONSIDERED: 'Considered',
    UNDER_REVIEW: 'Under review',
    SELECTED: 'Selected',
    COMMERCIAL_DISCUSSION: 'Commercial discussion',
    CLOSED: 'Closed',
  };
  return labels[status] ?? status;
}

export function commercialStatus(status: string) {
  if (status === 'SUBMITTED') return 'Submitted';
  if (status === 'UPDATED') return 'Updated';
  return status;
}

export function when(value: string) {
  return new Date(value).toLocaleString('en-IN', { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' });
}
