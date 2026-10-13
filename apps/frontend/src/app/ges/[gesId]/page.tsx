'use client';

import Link from 'next/link';
import { useParams } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { Pencil } from 'lucide-react';
import { AppShell, PageHeader } from '../../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../../components/DataState';
import { useAuth } from '../../../features/auth/AuthProvider';
import { api, listQuery } from '../../../services/api';
import { GesAccount } from '../../../types/api';

export default function GesDetailsPage() {
  const { gesId } = useParams<{ gesId: string }>();
  const { user } = useAuth();
  const canEdit = user?.permissions.includes('GES_EDIT') ?? false;
  const query = useQuery({ queryKey: ['ges'], queryFn: () => api.get<GesAccount[]>('/ges'), ...listQuery });
  const ges = query.data?.find((item) => item.id === gesId);
  if (query.isLoading) return <AppShell><PageSkeleton variant="detail" /></AppShell>;
  if (!ges) return <AppShell><ErrorState message="This GES account was not found." /></AppShell>;
  const contract = ges.contractDemandMw ? `${(ges.contractDemandMw * 1000).toLocaleString('en-IN')} kVA` : '—';
  const rooftop = ges.existingRooftopMw ? `${(ges.existingRooftopMw * 1000).toLocaleString('en-IN')} kW` : 'None recorded';
  const period = ges.zoneConsumption?.period === 'monthly' ? 'Monthly average' : 'Annual';

  return (
    <AppShell>
      <PageHeader eyebrow="GES" title={ges.name} description="Profile only. Login credentials are not shown here.">
        {canEdit && !user?.gesId && <Link className="primary-button" href={`/ges/${ges.id}/edit`}><Pencil size={14} /> Edit GES</Link>}
      </PageHeader>
      <section className="card">
        <div className="card-body info-grid">
          <div className="info-item"><small>Name</small><strong>{ges.name}</strong></div>
          <div className="info-item"><small>Consumer number</small><strong>{ges.consumerNumbers || '—'}</strong></div>
          <div className="info-item"><small>Plant address</small><strong>{ges.plantAddress || '—'}</strong></div>
          <div className="info-item"><small>Contract demand</small><strong>{contract}</strong></div>
          <div className="info-item"><small>Existing rooftop capacity</small><strong>{rooftop}</strong></div>
          <div className="info-item"><small>Zone consumption</small><strong>{period}</strong></div>
        </div>
        <div className="card-body">
          {(ges.zoneConsumption?.zones ?? []).length === 0 && <p>No zones recorded.</p>}
          {(ges.zoneConsumption?.zones ?? []).map((zone) => (
            <p key={zone.name}><strong>{zone.name}</strong> — {zone.value}</p>
          ))}
        </div>
      </section>
    </AppShell>
  );
}
