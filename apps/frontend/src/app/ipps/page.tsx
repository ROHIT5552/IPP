'use client';

import Link from 'next/link';
import { useEffect, useMemo, useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { Eye, Pencil, Plus, Search, Trash } from 'lucide-react';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../components/DataState';
import { TablePagination } from '../../components/TablePagination';
import { useAuth } from '../../features/auth/AuthProvider';
import { IppAccountForm } from '../../features/ipp/IppForm';
import { api, listQuery } from '../../services/api';
import { IppCatalogRow } from '../../types/api';

export default function IppRegisterPage() {
  const { user } = useAuth();
  const client = useQueryClient();
  const canCreate = user?.permissions.includes('IPP_CREATE') ?? false;
  const canEdit = user?.permissions.includes('IPP_EDIT') ?? false;
  const [search, setSearch] = useState('');
  const [pageSize, setPageSize] = useState(10);
  const [page, setPage] = useState(1);
  const [pendingDelete, setPendingDelete] = useState<string | null>(null);
  const query = useQuery({ queryKey: ['ipp-catalog'], queryFn: () => api.get<IppCatalogRow[]>('/ipp-catalog'), enabled: !user?.gesId, ...listQuery });
  const remove = useMutation({
    mutationFn: (id: string) => api.delete<IppCatalogRow[]>(`/ipps/${id}`),
    onSuccess: (rows) => {
      toast.success('IPP deleted');
      setPendingDelete(null);
      client.setQueryData(['ipp-catalog'], rows);
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'IPP could not be deleted'),
  });
  const rows = query.data ?? [];
  const filtered = useMemo(() => {
    const needle = search.trim().toLowerCase();
    return rows.filter((ipp) => `${ipp.referenceNo ?? ''} ${ipp.name} ${ipp.loiScope ?? ''} ${ipp.headquarters} ${ipp.cin ?? ''}`.toLowerCase().includes(needle));
  }, [rows, search]);
  const pageCount = Math.max(1, Math.ceil(filtered.length / pageSize));
  const currentPage = Math.min(page, pageCount);
  const visible = filtered.slice((currentPage - 1) * pageSize, currentPage * pageSize);
  useEffect(() => { setPage(1); }, [search, pageSize]);

  if (user?.gesId) return null;
  if (query.isLoading) return <AppShell><PageSkeleton variant="table" /></AppShell>;
  if (query.error) return <AppShell><ErrorState message="Unable to load IPPs." retry={() => void query.refetch()} /></AppShell>;
  if (!rows.length && canCreate) return <AppShell><IppAccountForm /></AppShell>;

  return (
    <AppShell>
      <PageHeader eyebrow="INDEPENDENT POWER PRODUCER" title="Independent power producers" description="Company, scope, capacity, office, leadership, contact, and CIN.">
        {canCreate && <Link className="primary-button" href="/ipps/new"><Plus size={14} /> Add IPP</Link>}
      </PageHeader>
      <section className="card">
        <div className="table-toolbar">
          <h2 className="card-title">Count <span className="count-badge">{filtered.length}</span></h2>
          <label className="search-field wide"><Search size={13} /><input value={search} onChange={(event) => setSearch(event.target.value)} placeholder="Search company, scope, CIN" aria-label="Search IPPs" /></label>
        </div>
        <div className="data-table-wrap">
          <table className="data-table">
            <thead>
              <tr>
                <th>No.</th><th>IPP / company</th><th>LOI scope</th><th>Portfolio / capacity</th><th>Head office</th><th>Leadership</th><th>Key contact</th><th>CIN</th><th></th>
              </tr>
            </thead>
            <tbody>
              {visible.map((ipp) => (
                <tr key={ipp.id}>
                  <td>{ipp.referenceNo || '—'}</td>
                  <td><strong><Link href={`/ipps/${ipp.id}`}>{ipp.name}</Link></strong></td>
                  <td>{ipp.loiScope || '—'}</td>
                  <td>{ipp.portfolioCapacity || '—'}</td>
                  <td>{ipp.headquarters || '—'}</td>
                  <td>{ipp.leadership || '—'}</td>
                  <td>{ipp.keyContact || '—'}</td>
                  <td>{ipp.cin || '—'}</td>
                  <td>
                    <div className="row-actions">
                      <Link className="small-button icon-only" href={`/ipps/${ipp.id}`} aria-label={`View ${ipp.name}`}><Eye size={12} /></Link>
                      {canEdit && <Link className="small-button icon-only" href={`/ipps/${ipp.id}/edit`} aria-label={`Edit ${ipp.name}`}><Pencil size={12} /></Link>}
                      {canEdit && <button className="danger-button icon-only" type="button" aria-label={`Delete ${ipp.name}`} onClick={() => setPendingDelete(ipp.id)}><Trash size={12} /></button>}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {!visible.length && <div className="empty-state"><span>No IPP matches this search.</span></div>}
        </div>
        {pendingDelete && (
          <div className="modal-backdrop" onMouseDown={() => { if (!remove.isPending) setPendingDelete(null); }}>
            <div className="confirm-modal" role="dialog" onMouseDown={(event) => event.stopPropagation()}>
              <h3>Delete this IPP?</h3>
              <div className="card-tools" style={{ justifyContent: 'flex-end' }}>
                <button className="small-button" type="button" onClick={() => setPendingDelete(null)}>Cancel</button>
                <button className="danger-button" type="button" onClick={() => remove.mutate(pendingDelete)}>Delete</button>
              </div>
            </div>
          </div>
        )}
        <TablePagination recordCount={filtered.length} currentPage={currentPage} pageSize={pageSize} onPageChange={setPage} onPageSizeChange={setPageSize} recordLabel="producers" />
      </section>
    </AppShell>
  );
}
