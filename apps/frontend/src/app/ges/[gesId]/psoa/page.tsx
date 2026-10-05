'use client';

import { useParams } from 'next/navigation';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { CheckCircle2, CircleDashed, FileCheck2, ShieldAlert } from 'lucide-react';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../../../components/DataState';
import { StatusPill } from '../../../../components/StatusPill';
import { api } from '../../../../services/api';
import { PsoaRecord, ProviderOption } from '../../../../types/api';
import { useEffect, useState } from 'react';

export default function PsoaPage() {
  const { gesId } = useParams<{ gesId: string }>();
  const [providerId, setProviderId] = useState('');
  const queryClient = useQueryClient();
  const candidates = useQuery({ queryKey: ['candidates', gesId], queryFn: () => api.get<ProviderOption[]>(`/ges/${gesId}/ipps`) });
  useEffect(() => {
    if (!providerId && candidates.data?.[0]) setProviderId(candidates.data[0].id);
  }, [candidates.data, providerId]);
  const checklist = useQuery({
    queryKey: ['psoa', gesId, providerId],
    queryFn: async () => (await api.get<PsoaRecord[]>(`/ges/${gesId}/psoa?ippId=${providerId}`))[0],
    enabled: Boolean(providerId),
  });
  const update = useMutation({
    mutationFn: (body: { item: string; status: string }) => api.patch(`/ges/${gesId}/psoa/${providerId}`, body),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ['psoa', gesId, providerId] });
      toast.success('Evidence checklist updated.');
    },
    onError: (error) => toast.error(error.message),
  });

  if (candidates.isLoading || (candidates.data?.length && (!providerId || checklist.isLoading))) return <AppShell><PageSkeleton variant="detail" /></AppShell>;
  if (candidates.error) return <AppShell><ErrorState message="Evidence checklist is unavailable." retry={() => void candidates.refetch()} /></AppShell>;
  if (!candidates.data?.length) return <AppShell><PageHeader eyebrow="EVIDENCE READINESS" title="PSOA checklist" description="Track readiness item by item, independently of the overall evaluation stage." /><div className="empty-state"><span>No IPP candidates are currently associated with this GES.</span></div></AppShell>;
  if (checklist.error || !checklist.data) return <AppShell><ErrorState message="Evidence checklist is unavailable." retry={() => void checklist.refetch()} /></AppShell>;
  const verified = checklist.data.items.filter((item) => item.status === 'VERIFIED').length;
  return (
    <AppShell>
      <PageHeader eyebrow="EVIDENCE READINESS" title="PSOA checklist" description="Track readiness item by item, independently of the overall evaluation stage.">
        <label className="selector-field">Provider<select value={providerId} onChange={(event) => setProviderId(event.target.value)}>{candidates.data?.map((item) => <option key={item.id} value={item.id}>{item.name}</option>)}</select></label>
      </PageHeader>
      <div className="metric-grid psoa-metrics">
        <div className="metric-card"><div className="metric-top"><span className="metric-label">Evidence items</span><span className="metric-icon"><FileCheck2 size={14} /></span></div><div className="metric-value">{checklist.data.items.length}</div><div className="metric-foot">Independent evidence requirements</div></div>
        <div className="metric-card"><div className="metric-top"><span className="metric-label">Verified</span><span className="metric-icon"><CheckCircle2 size={14} /></span></div><div className="metric-value">{verified}</div><div className="metric-foot">Evidence review complete</div></div>
        <div className="metric-card"><div className="metric-top"><span className="metric-label">Outstanding</span><span className="metric-icon amber"><CircleDashed size={14} /></span></div><div className="metric-value">{checklist.data.items.length - verified}</div><div className="metric-foot">Pending, received, or exception</div></div>
        <div className="metric-card"><div className="metric-top"><span className="metric-label">Readiness</span><span className="metric-icon blue"><ShieldAlert size={14} /></span></div><div className="metric-value">{checklist.data.status === 'READY' ? 'Ready' : 'In progress'}</div><div className="metric-foot">This checklist does not approve the deal</div></div>
      </div>
      <section className="card">
        <div className="card-head"><div><h2 className="card-title">{checklist.data.ippName} · evidence readiness</h2><p className="card-subtitle">Choose a distinct status for every required item.</p></div><StatusPill status={checklist.data.status} /></div>
        <div className="card-body evidence-list">
          {checklist.data.items.map((item, index) => (
            <div className="evidence-row" key={item.name}>
              <span className="step-index">{String(index + 1).padStart(2, '0')}</span>
              <div className="evidence-copy"><strong>{item.name}</strong><small>Evidence and supporting document to be attached to the decision record.</small></div>
              <StatusPill status={item.status} />
              <select value={item.status} aria-label={`Status for ${item.name}`} disabled={update.isPending} onChange={(event) => update.mutate({ item: item.name, status: event.target.value })}>
                <option value="PENDING">Pending</option><option value="RECEIVED">Received</option><option value="VERIFIED">Verified</option><option value="EXCEPTION">Exception</option>
              </select>
            </div>
          ))}
        </div>
      </section>
    </AppShell>
  );
}
