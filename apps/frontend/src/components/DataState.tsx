import { AlertTriangle, RefreshCw, Zap } from 'lucide-react';

export function NewraLoader({ label = 'Preparing your workspace' }: { label?: string }) {
  return (
    <div className="newra-loader" role="status" aria-live="polite">
      <div className="newra-loader-mark" aria-hidden="true">
        <span className="newra-loader-ring" />
        <Zap size={28} fill="currentColor" />
      </div>
      <strong>NewRa Grids</strong>
      <span>{label}</span>
    </div>
  );
}

export function LoadingState({ label = 'Preparing your workspace' }: { label?: string }) {
  return <NewraLoader label={label} />;
}

function Bone({ width = '100%', height = 14 }: { width?: string | number; height?: number }) {
  return <span className="skeleton" style={{ width, height }} aria-hidden="true" />;
}

function HeadingSkeleton() {
  return (
    <div className="skeleton-heading">
      <Bone width={128} height={12} />
      <Bone width="68%" height={30} />
      <Bone width="88%" height={14} />
    </div>
  );
}

function MetricSkeleton() {
  return (
    <div className="skeleton-card skeleton-metric">
      <Bone width="48%" height={12} />
      <Bone width="36%" height={28} />
      <Bone width="72%" height={12} />
    </div>
  );
}

function TableSkeleton({ rows = 6 }: { rows?: number }) {
  return (
    <section className="skeleton-card">
      <div className="skeleton-toolbar">
        <Bone width="34%" height={18} />
        <Bone width={210} height={36} />
      </div>
      {Array.from({ length: rows }, (_, index) => (
        <div className="skeleton-row" key={index}>
          <Bone height={16} />
          <Bone height={16} />
          <Bone height={16} />
          <Bone width="70%" height={16} />
        </div>
      ))}
    </section>
  );
}

function ChartCard() {
  return (
    <section className="skeleton-card">
      <Bone width="42%" height={18} />
      <Bone width="70%" height={12} />
      <Bone height={240} />
    </section>
  );
}

export function PageSkeleton({
  variant = 'table',
  heading = true,
}: {
  variant?: 'dashboard' | 'table' | 'comparison' | 'detail' | 'form' | 'split' | 'cards';
  heading?: boolean;
}) {
  return (
    <div className="skeleton-page" role="status" aria-live="polite" aria-busy="true">
      <span className="sr-only">NewRa Grids is loading this page</span>
      {heading && <HeadingSkeleton />}
      {variant === 'dashboard' && (
        <>
          <div className="skeleton-metrics">{Array.from({ length: 4 }, (_, index) => <MetricSkeleton key={index} />)}</div>
          <div className="skeleton-metrics">{Array.from({ length: 4 }, (_, index) => <MetricSkeleton key={`b-${index}`} />)}</div>
          <section className="skeleton-card">
            <Bone width="28%" height={18} />
            <div className="skeleton-metrics">{Array.from({ length: 4 }, (_, index) => <Bone key={index} height={72} />)}</div>
            <Bone height={92} />
          </section>
          <div className="skeleton-grid">
            <ChartCard />
            <ChartCard />
          </div>
        </>
      )}
      {variant === 'table' && <TableSkeleton />}
      {variant === 'comparison' && (
        <>
          <TableSkeleton rows={3} />
          <div className="skeleton-grid">
            <ChartCard />
            <ChartCard />
          </div>
          <TableSkeleton rows={5} />
        </>
      )}
      {variant === 'detail' && (
        <section className="skeleton-card">
          <div className="skeleton-fields">
            {Array.from({ length: 8 }, (_, index) => (
              <div key={index} className="skeleton-field">
                <Bone width="46%" height={12} />
                <Bone height={18} />
              </div>
            ))}
          </div>
        </section>
      )}
      {variant === 'form' && (
        <section className="skeleton-card">
          <div className="skeleton-fields">
            {Array.from({ length: 6 }, (_, index) => (
              <div key={index} className="skeleton-field">
                <Bone width="40%" height={12} />
                <Bone height={44} />
              </div>
            ))}
          </div>
          <Bone width={180} height={44} />
        </section>
      )}
      {variant === 'split' && (
        <div className="skeleton-grid">
          <TableSkeleton rows={4} />
          <ChartCard />
        </div>
      )}
      {variant === 'cards' && (
        <div className="skeleton-stack">
          {Array.from({ length: 3 }, (_, index) => (
            <section className="skeleton-card" key={index}>
              <Bone width="36%" height={18} />
              <Bone width="80%" height={14} />
              <div className="skeleton-metrics">
                <MetricSkeleton />
                <MetricSkeleton />
              </div>
            </section>
          ))}
        </div>
      )}
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
