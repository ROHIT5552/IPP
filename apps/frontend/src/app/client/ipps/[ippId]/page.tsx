'use client';

import { useParams } from 'next/navigation';
import { AppShell } from '../../../../components/AppShell';
import { useAuth } from '../../../../features/auth/AuthProvider';
import { ClientIppScreen } from '../../../../features/procurement/screens';

export default function ClientIppDetailPage() {
  const { user } = useAuth();
  const { ippId } = useParams<{ ippId: string }>();
  return (
    <AppShell>
      {user?.gesId ? <ClientIppScreen gesId={user.gesId} ippId={ippId} /> : <p>This page is for a GES login.</p>}
    </AppShell>
  );
}
