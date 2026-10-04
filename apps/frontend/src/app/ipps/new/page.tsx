'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { AppShell } from '../../../components/AppShell';
import { useAuth } from '../../../features/auth/AuthProvider';
import { IppAccountForm } from '../../../features/ipp/IppForm';

export default function NewIppPage() {
  const { user } = useAuth();
  const router = useRouter();
  const canCreate = user?.permissions.includes('IPP_CREATE') ?? false;

  useEffect(() => {
    if (user && !canCreate) router.replace('/ipps');
  }, [user, canCreate, router]);

  if (!canCreate) return <AppShell />;
  return <AppShell><IppAccountForm /></AppShell>;
}