'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { AppShell } from '../../../components/AppShell';
import { useAuth } from '../../../features/auth/AuthProvider';
import { GesAccountForm } from '../../../features/ges/GesForm';

export default function NewGesPage() {
  const { user } = useAuth();
  const router = useRouter();
  const canCreate = user?.permissions.includes('GES_CREATE') ?? false;

  useEffect(() => {
    if (user && !canCreate) router.replace('/ges');
  }, [user, canCreate, router]);

  if (!canCreate) return <AppShell />;
  return <AppShell><GesAccountForm /></AppShell>;
}
