import clsx from 'clsx';

const ACRONYMS = new Set(['ipp', 'ges', 'bess', 'ehv', 'cod', 'capex', 'fdre', 'ppa', 'psoa', 'dscr', 'epc', 'nda']);

const STATUS_LABELS: Record<string, string> = {
  highly_suitable: 'Strong match',
  suitable: 'Match',
  conditional: 'Partial match',
  not_suitable: 'Weak match',
  gate_failed: 'Check failed',
  pending_review: 'Pending review',
  not_eligible: 'Not eligible',
  eligible: 'Eligible',
};

export function StatusPill({ status }: { status: string }) {
  const normalized = status.toLowerCase().replaceAll('_', ' ');
  const mapped = STATUS_LABELS[status.toLowerCase()] ?? STATUS_LABELS[normalized.replaceAll(' ', '_')];
  const label = normalized.split(' ').map((word) => ACRONYMS.has(word) ? word.toUpperCase() : word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
  return (
    <span
      className={clsx('status-pill', {
        'status-good': ['pass', 'verified', 'sustainable', 'ready', 'received', 'highly suitable'].includes(normalized),
        'status-warn': ['conditional', 'under review', 'pending', 'aggressive', 'in progress', 'suitable'].includes(normalized),
        'status-risk': ['fail', 'gate failed', 'rejected', 'unsustainable', 'critical', 'not suitable'].includes(normalized),
        'status-neutral': !['pass', 'verified', 'sustainable', 'ready', 'received', 'highly suitable', 'conditional', 'under review', 'pending', 'aggressive', 'in progress', 'suitable', 'fail', 'gate failed', 'rejected', 'unsustainable', 'critical', 'not suitable'].includes(normalized),
      })}
    >
      {mapped ?? label}
    </span>
  );
}
