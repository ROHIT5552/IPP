'use client';

import { useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../../components/DataState';
import { FactorChartModal } from '../../../features/ipp/FactorChartModal';
import { useAuth } from '../../../features/auth/AuthProvider';
import { api, listQuery } from '../../../services/api';
import { IppCatalogRow } from '../../../types/api';

export default function ClientIppPage() {
  const { user } = useAuth();
  const client = useQueryClient();
  const [chartIpp, setChartIpp] = useState<IppCatalogRow | null>(null);
  const query = useQuery({ queryKey: ['ipp-catalog'], queryFn: () => api.get<IppCatalogRow[]>('/ipp-catalog'), ...listQuery });
  const [notes, setNotes] = useState<Record<string, string>>({});
  const save = useMutation({
    mutationFn: (ipp: IppCatalogRow) => api.patch<IppCatalogRow[]>(`/ipps/${ipp.id}/notes`, { notes: notes[ipp.id] ?? ipp.notes ?? '' }),
    onSuccess: (rows) => {
      client.setQueryData(['ipp-catalog'], rows);
      toast.success('Notes saved');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'Notes could not be saved'),
  });

  if (query.isLoading) return <AppShell><PageSkeleton variant="table" /></AppShell>;
  if (query.isError) return <AppShell><ErrorState message="IPPs could not be loaded." retry={() => void query.refetch()} /></AppShell>;

  return (
    <AppShell>
      <PageHeader eyebrow="IPP" title="Independent power producers" description="Review each IPP and save notes about your requirement." />
      <div style={{ display: 'grid', gap: 12 }}>
        {(query.data ?? []).map((ipp) => (
          <section className="card" key={ipp.id}>
            <div className="card-body">
              <h2 className="card-title">{ipp.referenceNo ? `${ipp.referenceNo}. ` : ''}{ipp.name}</h2>
              <div className="info-grid" style={{ marginTop: 12 }}>
                <div className="info-item"><small>Proposed LOI scope</small><strong>{ipp.loiScope || '—'}</strong></div>
                <div className="info-item"><small>Portfolio / capacity</small><strong>{ipp.portfolioCapacity || '—'}</strong></div>
                <div className="info-item"><small>Head office</small><strong>{ipp.headquarters || '—'}</strong></div>
                <div className="info-item"><small>Company leadership</small><strong>{ipp.leadership || '—'}</strong></div>
                <div className="info-item"><small>Key contact</small><strong>{ipp.keyContact || '—'}</strong></div>
                <div className="info-item"><small>CIN</small><strong>{ipp.cin || '—'}</strong></div>
              </div>
              <label className="form-field" style={{ marginTop: 12 }}>
                Notes
                <textarea value={notes[ipp.id] ?? ipp.notes ?? ''} onChange={(event) => setNotes((current) => ({ ...current, [ipp.id]: event.target.value }))} placeholder="Your requirement for this IPP" />
              </label>
              <div className="card-tools" style={{ justifyContent: 'flex-start', marginTop: 8 }}>
                {user?.gesId && <button className="secondary-button" type="button" onClick={() => setChartIpp(ipp)}>View chart</button>}
                <button className="primary-button" type="button" disabled={save.isPending} onClick={() => save.mutate(ipp)}>Save</button>
              </div>
            </div>
          </section>
        ))}
      </div>
      {chartIpp && user?.gesId && <FactorChartModal gesId={user.gesId} ippId={chartIpp.id} ippName={chartIpp.name} onClose={() => setChartIpp(null)} />}
    </AppShell>
  );
}
