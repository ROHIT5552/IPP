'use client';

import { useParams } from 'next/navigation';
import { AppShell } from '../../../../components/AppShell';
import { GesRequirementScreen } from '../../../../features/procurement/screens';

export default function GesRequirementPage() {
  const { gesId } = useParams<{ gesId: string }>();
  return <AppShell><GesRequirementScreen gesId={gesId} /></AppShell>;
}
