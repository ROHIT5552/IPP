'use client';

import { useEffect } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { AppShell } from '../../../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../../../components/DataState';
import { useAuth } from '../../../../features/auth/AuthProvider';
import { IppAccountForm } from '../../../../features/ipp/IppForm';
import { api, listQuery } from '../../../../services/api';
import { IppCatalogRow } from '../../../../types/api';

export default function EditIppPage() {
  const { ippId } = useParams<{ ippId: string }>();
  const { user } = useAuth();
  const router = useRouter();
  const canEdit = user?.permissions.includes('IPP_EDIT') ?? false;
  const query = useQuery({ queryKey: ['ipp-catalog'], queryFn: () => api.get<IppCatalogRow[]>('/ipp-catalog'), ...listQuery });
  const account = query.data?.find((ipp) => ipp.id === ippId);

  useEffect(() => {
    if (user && !canEdit) router.replace('/ipps');
  }, [user, canEdit, router]);

  if (!canEdit) return <AppShell />;
  if (query.isLoading) return <AppShell><PageSkeleton variant="form" /></AppShell>;
  if (!account) return <AppShell><ErrorState message="This independent power producer was not found." /></AppShell>;
  return <AppShell><IppAccountForm account={account} /></AppShell>;
}
