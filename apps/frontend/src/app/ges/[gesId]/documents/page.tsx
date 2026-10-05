'use client';

import { useParams } from 'next/navigation';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { FileCheck2, FileClock } from 'lucide-react';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../../../components/DataState';
import { StatusPill } from '../../../../components/StatusPill';
import { api } from '../../../../services/api';

interface DocumentRow {
  id: string;
  category: string;
  title: string;
  status: string;
  version: number;
  owner: string;
  pendingFrom: string;
  location: string;
  comments: string;
}

export default function DocumentsPage() {
  const { gesId } = useParams<{ gesId: string }>();
  const client = useQueryClient();
  const query = useQuery({ queryKey: ['documents', gesId], queryFn: () => api.get<DocumentRow[]>(`/ges/${gesId}/documents`) });
  const update = useMutation({
    mutationFn: ({ id, status }: { id: string; status: string }) => api.patch(`/documents/${id}`, { status }),
    onSuccess: () => {
      void client.invalidateQueries({ queryKey: ['documents', gesId] });
      void client.invalidateQueries({ queryKey: ['comparison', gesId] });
      toast.success('Document status updated.');
    },
    onError: (error) => toast.error(error.message),
  });
  if (query.isLoading) return <AppShell><PageSkeleton variant="table" /></AppShell>;
  if (query.error || !query.data) return <AppShell><ErrorState message="Document register unavailable. Your role may not have document access." retry={() => void query.refetch()} /></AppShell>;
  return (
    <AppShell>
      <PageHeader eyebrow="INDEPENDENT WORKFLOW" title="Document register" description="Document status and pending responsibility do not overwrite the evaluation stage." />
      <div className="metric-grid">
        <div className="metric-card"><div className="metric-top"><span className="metric-label">Documents</span><span className="metric-icon"><FileCheck2 size={14} /></span></div><div className="metric-value">{query.data.length}</div><div className="metric-foot">Across all 24 GES–IPP evaluations</div></div>
        <div className="metric-card"><div className="metric-top"><span className="metric-label">Under review</span><span className="metric-icon amber"><FileClock size={14} /></span></div><div className="metric-value">{query.data.filter((item) => item.status === 'UNDER_REVIEW').length}</div><div className="metric-foot">With internal reviewers</div></div>
        <div className="metric-card"><div className="metric-top"><span className="metric-label">Waiting</span><span className="metric-icon blue"><FileClock size={14} /></span></div><div className="metric-value">{query.data.filter((item) => item.status === 'PENDING').length}</div><div className="metric-foot">Pending from IPP</div></div>
      </div>
      <section className="card"><div className="card-head"><div><h2 className="card-title">Evidence and submissions</h2><p className="card-subtitle">Version, owner, pending from, location, and comments remain independently tracked.</p></div></div>
        <div className="card-body data-table-wrap"><table className="data-table"><thead><tr><th>Document</th><th>Category</th><th>Version</th><th>Owner</th><th>Pending from</th><th>Status</th><th>Source</th><th>Update status</th></tr></thead><tbody>{query.data.map((document) => <tr key={document.id}>
          <td><strong>{document.title}</strong><span className="number-sub">{document.comments}</span></td><td>{document.category.replaceAll('_', ' ').toLowerCase()}</td><td>v{document.version}</td><td>{document.owner}</td><td>{document.pendingFrom}</td><td><StatusPill status={document.status} /></td><td>{document.location}</td>
          <td><select className="filter-select" value={document.status} disabled={update.isPending} onChange={(event) => update.mutate({ id: document.id, status: event.target.value })}><option value="REQUESTED">Requested</option><option value="PENDING">Pending</option><option value="RECEIVED">Received</option><option value="UNDER_REVIEW">Under review</option><option value="VERIFIED">Verified</option><option value="REJECTED">Rejected</option><option value="EXPIRED">Expired</option></select></td>
        </tr>)}</tbody></table></div>
      </section>
    </AppShell>
  );
}
