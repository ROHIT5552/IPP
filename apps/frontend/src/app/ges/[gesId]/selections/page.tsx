'use client';

import { useParams } from 'next/navigation';
import { AppShell } from '../../../../components/AppShell';
import { MyIppsScreen } from '../../../../features/procurement/screens';

export default function GesSelectionsPage() {
  const { gesId } = useParams<{ gesId: string }>();
  return <AppShell><MyIppsScreen gesId={gesId} /></AppShell>;
}
