'use client';

import { AppShell } from '../../../components/AppShell';
import { useAuth } from '../../../features/auth/AuthProvider';
import { GesRequirementScreen } from '../../../features/procurement/screens';

export default function ClientRequirementPage() {
  const { user } = useAuth();
  return (
    <AppShell>
      {user?.gesId ? <GesRequirementScreen gesId={user.gesId} /> : <p>This page is for a GES login.</p>}
    </AppShell>
  );
}
