'use client';

import { useParams } from 'next/navigation';
import { AppShell } from '../../../../components/AppShell';
import { IppCatalogueScreen } from '../../../../features/procurement/screens';

export default function GesCataloguePage() {
  const { gesId } = useParams<{ gesId: string }>();
  return <AppShell><IppCatalogueScreen gesId={gesId} detailBase={`/ges/${gesId}/catalogue`} /></AppShell>;
}
