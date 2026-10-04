'use client';

import { useParams } from 'next/navigation';
import { AppShell } from '../../../../components/AppShell';
import { GesProfileScreen } from '../../../../features/procurement/screens';

export default function GesProfilePage() {
  const { gesId } = useParams<{ gesId: string }>();
  return <AppShell><GesProfileScreen gesId={gesId} /></AppShell>;
}
