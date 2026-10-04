import { AlertTriangle, RefreshCw } from 'lucide-react';

export function LoadingState({ label = 'Loading portfolio data' }: { label?: string }) {
  return (
    <div className="loading-state">
      <div><div className="spinner" />{label}…</div>
    </div>
  );
}

export function ErrorState({ message, retry }: { message: string; retry?: () => void }) {
  return (
    <div className="empty-state">
      <AlertTriangle size={22} />
      <div><strong>We couldn't load this view</strong><span>{message}</span></div>
      {retry && <button className="secondary-button" onClick={retry}><RefreshCw size={13} /> Try again</button>}
    </div>
  );
}
