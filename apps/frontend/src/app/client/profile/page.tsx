'use client';

import { AppShell } from '../../../components/AppShell';
import { useAuth } from '../../../features/auth/AuthProvider';
import { GesProfileScreen } from '../../../features/procurement/screens';

export default function ClientProfilePage() {
  const { user } = useAuth();
  return (
    <AppShell>
      {user?.gesId ? <GesProfileScreen gesId={user.gesId} /> : <p>This page is for a GES login. Open a GES account from the GES list to work on its profile.</p>}
    </AppShell>
  );
}
