'use client';

import Link from 'next/link';
import { useState } from 'react';
import { useParams } from 'next/navigation';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { Pencil } from 'lucide-react';
import { FactorChartModal } from '../../../features/ipp/FactorChartModal.lazy';
import { useWorkspace } from '../../../features/workspace/WorkspaceProvider';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../../components/DataState';
import { useAuth } from '../../../features/auth/AuthProvider';
import { api, listQuery } from '../../../services/api';
import { IppCatalogRow } from '../../../types/api';

export default function IppDetailsPage() {
  const { ippId } = useParams<{ ippId: string }>();
  const { user } = useAuth();
  const { gesId } = useWorkspace();
  const client = useQueryClient();
  const canEdit = user?.permissions.includes('IPP_EDIT') ?? false;
  const query = useQuery({ queryKey: ['ipp-catalog'], queryFn: () => api.get<IppCatalogRow[]>('/ipp-catalog'), ...listQuery });
  const ipp = query.data?.find((item) => item.id === ippId);
  const [notes, setNotes] = useState<string | null>(null);
  const [chartOpen, setChartOpen] = useState(false);
  const chartGes = user?.gesId || gesId;
  const save = useMutation({
    mutationFn: () => api.patch<IppCatalogRow[]>(`/ipps/${ippId}/notes`, { notes: notes ?? ipp?.notes ?? '' }),
    onSuccess: (rows) => {
      client.setQueryData(['ipp-catalog'], rows);
      toast.success('Notes saved');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'Notes could not be saved'),
  });

  if (query.isLoading) return <AppShell><PageSkeleton variant="detail" /></AppShell>;
  if (!ipp) return <AppShell><ErrorState message="This IPP was not found." /></AppShell>;

  return (
    <AppShell>
      <PageHeader eyebrow="INDEPENDENT POWER PRODUCER" title={ipp.name} description={ipp.referenceNo || undefined}>
        {chartGes && <button className="secondary-button" type="button" onClick={() => setChartOpen(true)}>View chart</button>}
        {canEdit && <Link className="primary-button" href={`/ipps/${ipp.id}/edit`}><Pencil size={14} /> Edit IPP</Link>}
      </PageHeader>
      <section className="card">
        <div className="card-body info-grid">
          <div className="info-item"><small>No.</small><strong>{ipp.referenceNo || '—'}</strong></div>
          <div className="info-item"><small>IPP / company</small><strong>{ipp.name}</strong></div>
          <div className="info-item"><small>Proposed LOI scope</small><strong>{ipp.loiScope || '—'}</strong></div>
          <div className="info-item"><small>Portfolio / capacity</small><strong>{ipp.portfolioCapacity || '—'}</strong></div>
          <div className="info-item"><small>Head office</small><strong>{ipp.headquarters || '—'}</strong></div>
          <div className="info-item"><small>Company leadership</small><strong>{ipp.leadership || '—'}</strong></div>
          <div className="info-item"><small>Key contact</small><strong>{ipp.keyContact || '—'}</strong></div>
          <div className="info-item"><small>CIN</small><strong>{ipp.cin || '—'}</strong></div>
        </div>
        <div className="card-body">
          <label className="form-field">
            Notes
            <textarea value={notes ?? ipp.notes ?? ''} onChange={(event) => setNotes(event.target.value)} />
          </label>
          <button className="primary-button" type="button" style={{ marginTop: 8 }} disabled={save.isPending} onClick={() => save.mutate()}>Save notes</button>
        </div>
      </section>
      {chartOpen && chartGes && <FactorChartModal gesId={chartGes} ippId={ipp.id} ippName={ipp.name} onClose={() => setChartOpen(false)} />}
    </AppShell>
  );
}
