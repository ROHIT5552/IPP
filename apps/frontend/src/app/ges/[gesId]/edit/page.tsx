'use client';

import { useEffect } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { AppShell } from '../../../../components/AppShell';
import { ErrorState, LoadingState } from '../../../../components/DataState';
import { useAuth } from '../../../../features/auth/AuthProvider';
import { GesAccountForm } from '../../../../features/ges/GesForm';
import { api } from '../../../../services/api';
import { GesAccount } from '../../../../types/api';

export default function EditGesPage() {
  const { gesId } = useParams<{ gesId: string }>();
  const { user } = useAuth();
  const router = useRouter();
  const canEdit = user?.permissions.includes('GES_EDIT') ?? false;
  const query = useQuery({ queryKey: ['ges'], queryFn: () => api.get<GesAccount[]>('/ges') });
  const account = query.data?.find((ges) => ges.id === gesId);

  useEffect(() => {
    if (user && !canEdit) router.replace('/ges');
  }, [user, canEdit, router]);

  if (!canEdit) return <AppShell />;
  if (query.isLoading) return <AppShell><LoadingState /></AppShell>;
  if (!account) return <AppShell><ErrorState message="This GES account was not found." /></AppShell>;
  return <AppShell><GesAccountForm account={account} /></AppShell>;
}
