'use client';

import { AppShell } from '../../../components/AppShell';
import { useAuth } from '../../../features/auth/AuthProvider';
import { MyIppsScreen } from '../../../features/procurement/screens';

export default function ClientMyIppsPage() {
  const { user } = useAuth();
  return (
    <AppShell>
      {user?.gesId ? <MyIppsScreen gesId={user.gesId} /> : <p>This page is for a GES login.</p>}
    </AppShell>
  );
}
