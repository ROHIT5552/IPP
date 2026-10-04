'use client';

import { useParams } from 'next/navigation';
import { AppShell } from '../../../../../components/AppShell';
import { ClientIppScreen } from '../../../../../features/procurement/screens';

export default function GesCatalogueDetailPage() {
  const { gesId, ippId } = useParams<{ gesId: string; ippId: string }>();
  return <AppShell><ClientIppScreen gesId={gesId} ippId={ippId} /></AppShell>;
}