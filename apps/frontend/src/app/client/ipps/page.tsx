'use client';

import { AppShell } from '../../../components/AppShell';
import { useAuth } from '../../../features/auth/AuthProvider';
import { IppCatalogueScreen } from '../../../features/procurement/screens';

export default function ClientIppCataloguePage() {
  const { user } = useAuth();
  return (
    <AppShell>
      {user?.gesId ? <IppCatalogueScreen gesId={user.gesId} detailBase="/client/ipps" /> : <p>This page is for a GES login.</p>}
    </AppShell>
  );
}
