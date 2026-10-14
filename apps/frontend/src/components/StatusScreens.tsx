'use client';

import Link from 'next/link';
import { PropsWithChildren, ReactNode } from 'react';
import { ArrowRight } from 'lucide-react';
import { AppShell } from './AppShell';
import { BrandLockup } from './BrandLockup';
import { NewraLoader } from './DataState';
import { destinationFor, useAuth } from '../features/auth/AuthProvider';

export function StatusCard({
  code,
  title,
  message,
  actions,
}: {
  code: string;
  title: string;
  message: string;
  actions: ReactNode;
}) {
  return (
    <section className="status-card">
      <div className="gate-brand"><BrandLockup priority /></div>
      <p className="eyebrow">{code}</p>
      <h1>{title}</h1>
      <p>{message}</p>
      <div className="status-actions">{actions}</div>
    </section>
  );
}

function Framed({ children }: PropsWithChildren) {
  const { user, ready } = useAuth();
  if (!ready) return <NewraLoader label="Preparing your workspace" />;
  if (user) return <AppShell>{children}</AppShell>;
  return <main id="main" className="signin-page">{children}</main>;
}

export function NotFoundScreen() {
  const { user } = useAuth();
  const home = user ? destinationFor(user) : '/login';
  return (
    <Framed>
      <StatusCard
        code="404"
        title="This page is not on the map."
        message="That address is not part of NewRa IPP Comparator. Check the link, or return to a page you can open."
        actions={(
          <Link className="primary-button" href={home}>
            {user ? 'Back to workspace' : 'Sign in'}
            <ArrowRight size={18} />
          </Link>
        )}
      />
    </Framed>
  );
}

export function RouteErrorScreen({ reset }: { reset: () => void }) {
  const { user } = useAuth();
  const home = user ? destinationFor(user) : '/login';
  return (
    <main id="main" className="signin-page">
      <StatusCard
        code="Error"
        title="This view could not finish."
        message="The page stopped before it could load. Try again, or return to a page that is already open."
        actions={(
          <>
            <button className="primary-button" type="button" onClick={reset}>Try again</button>
            <Link className="secondary-button" href={home}>{user ? 'Back to workspace' : 'Sign in'}</Link>
          </>
        )}
      />
    </main>
  );
}
