'use client';

import { useQuery } from '@tanstack/react-query';
import { AppShell } from '../../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../../components/DataState';
import { useAuth } from '../../../features/auth/AuthProvider';
import { GesAccountForm } from '../../../features/ges/GesForm';
import { api, listQuery } from '../../../services/api';
import { GesAccount } from '../../../types/api';

export default function ClientProfilePage() {
  const { user } = useAuth();
  const query = useQuery({ queryKey: ['ges'], queryFn: () => api.get<GesAccount[]>('/ges'), enabled: Boolean(user?.gesId), ...listQuery });
  const account = query.data?.find((item) => item.id === user?.gesId);
  return (
    <AppShell>
      {query.isLoading && <PageSkeleton variant="form" />}
      {query.isError && <ErrorState message="Your GES profile could not be loaded." retry={() => void query.refetch()} />}
      {account && <GesAccountForm account={account} />}
    </AppShell>
  );
}
