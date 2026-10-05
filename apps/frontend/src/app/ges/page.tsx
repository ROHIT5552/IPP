'use client';

import Link from 'next/link';
import { useEffect, useMemo, useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { ArrowLeftRight, ClipboardList, Eye, ListChecks, Pencil, Plus, Search, Trash2 } from 'lucide-react';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../components/DataState';
import { StatusPill } from '../../components/StatusPill';
import { TablePagination } from '../../components/TablePagination';
import { useAuth } from '../../features/auth/AuthProvider';
import { GesAccountForm } from '../../features/ges/GesForm';
import { bessLabel, technologyLabel } from '../../features/ges/options';
import { useWorkspace } from '../../features/workspace/WorkspaceProvider';
import { api, listQuery } from '../../services/api';
import { GesAccount } from '../../types/api';

function amount(value: number, digits = 3) {
  return value.toLocaleString('en-IN', { maximumFractionDigits: digits });
}

type SortKey = 'name' | 'consumption' | 'target';

export default function GesListPage() {
  const { user } = useAuth();
  const { gesId, selectGes } = useWorkspace();
  const client = useQueryClient();
  const canCreate = user?.permissions.includes('GES_CREATE') ?? false;
  const canEdit = user?.permissions.includes('GES_EDIT') ?? false;
  const [search, setSearch] = useState('');
  const [stateFilter, setStateFilter] = useState('ALL');
  const [stageFilter, setStageFilter] = useState('ALL');
  const [sortKey, setSortKey] = useState<SortKey>('name');
  const [sortAsc, setSortAsc] = useState(true);
  const [pageSize, setPageSize] = useState(10);
  const [page, setPage] = useState(1);
  const [pendingDelete, setPendingDelete] = useState<string | null>(null);
  const query = useQuery({ queryKey: ['ges'], queryFn: () => api.get<GesAccount[]>('/ges'), ...listQuery });
  const remove = useMutation({
    mutationFn: (id: string) => api.delete<GesAccount[]>(`/ges/${id}`),
    onSuccess: async (accounts, id) => {
      toast.success('GES account deleted');
      setPendingDelete(null);
      if (gesId === id) {
        const next = accounts[0];
        if (next) selectGes(next.id);
      }
      client.setQueryData(['ges'], accounts);
      await client.invalidateQueries({ queryKey: ['dashboard'] });
      await client.invalidateQueries({ queryKey: ['ipp-catalog'] });
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'GES account could not be deleted'),
  });
  useEffect(() => {
    if (!pendingDelete) return;
    function onKey(event: KeyboardEvent) {
      if (event.key === 'Escape' && !remove.isPending) setPendingDelete(null);
    }
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [pendingDelete, remove.isPending]);

  const rows = query.data ?? [];
  const states = useMemo(() => ['ALL', ...new Set(rows.map((ges) => ges.state).filter((value): value is string => Boolean(value)))].sort((left, right) => left === 'ALL' ? -1 : right === 'ALL' ? 1 : left.localeCompare(right)), [rows]);
  const stages = useMemo(() => ['ALL', ...new Set(rows.map((ges) => ges.stage).filter(Boolean))].sort((left, right) => left === 'ALL' ? -1 : right === 'ALL' ? 1 : left.localeCompare(right)), [rows]);
  const filtered = useMemo(() => {
    const needle = search.trim().toLowerCase();
    return rows.filter((ges) => {
      const searchable = `${ges.code} ${ges.name} ${ges.legalName ?? ''} ${ges.city ?? ''} ${ges.state ?? ''} ${ges.discom ?? ''} ${ges.consumerNumbers ?? ''}`.toLowerCase();
      return (!needle || searchable.includes(needle))
        && (stateFilter === 'ALL' || ges.state === stateFilter)
        && (stageFilter === 'ALL' || ges.stage === stageFilter);
    }).sort((left, right) => {
      const a = sortKey === 'consumption'
        ? left.annualConsumptionGwh ?? -1
        : sortKey === 'target' ? left.renewableEnergyTargetPercent ?? -1 : left.name.toLowerCase();
      const b = sortKey === 'consumption'
        ? right.annualConsumptionGwh ?? -1
        : sortKey === 'target' ? right.renewableEnergyTargetPercent ?? -1 : right.name.toLowerCase();
      const result = typeof a === 'string' && typeof b === 'string' ? a.localeCompare(b) : Number(a) - Number(b);
      return sortAsc ? result : -result;
    });
  }, [rows, search, stateFilter, stageFilter, sortKey, sortAsc]);
  const pageCount = Math.max(1, Math.ceil(filtered.length / pageSize));
  const currentPage = Math.min(page, pageCount);
  const visible = filtered.slice((currentPage - 1) * pageSize, currentPage * pageSize);
  const pendingAccount = rows.find((ges) => ges.id === pendingDelete);

  useEffect(() => {
    setPage(1);
  }, [search, stateFilter, stageFilter, pageSize]);

  function sortBy(key: SortKey) {
    if (sortKey === key) setSortAsc((current) => !current);
    else {
      setSortKey(key);
      setSortAsc(key === 'name');
    }
  }

  if (query.isLoading) return <AppShell><PageSkeleton variant="table" /></AppShell>;
  if (query.error) return <AppShell><ErrorState message="Unable to load accounts." retry={() => void query.refetch()} /></AppShell>;
  if (!query.data?.length && canCreate) return <AppShell><GesAccountForm /></AppShell>;

  return (
    <AppShell>
      <PageHeader eyebrow="GES" title="GES accounts" description="Search and review customer electricity profiles and renewable requirements. Open an account for detailed matching and procurement workflows.">
        {canCreate && <Link className="primary-button" href="/ges/new"><Plus size={14} /> Add GES</Link>}
      </PageHeader>
      <section className="card ges-register">
        <div className="table-toolbar">
          <div><h2 className="card-title">Accounts <span className="count-badge">{filtered.length}</span></h2></div>
          <div className="table-actions">
            <label className="search-field wide"><Search size={13} /><input value={search} onChange={(event) => setSearch(event.target.value)} placeholder="Search name, code, location" aria-label="Search GES accounts" /></label>
            <select className="filter-select" value={stateFilter} onChange={(event) => setStateFilter(event.target.value)} aria-label="Filter by state">
              {states.map((item) => <option key={item} value={item}>{item === 'ALL' ? 'All states' : item}</option>)}
            </select>
            <select className="filter-select" value={stageFilter} onChange={(event) => setStageFilter(event.target.value)} aria-label="Filter by stage">
              {stages.map((item) => <option key={item} value={item}>{item === 'ALL' ? 'All stages' : item}</option>)}
            </select>
          </div>
        </div>
        {pendingAccount && (
          <div className="modal-backdrop" onMouseDown={() => { if (!remove.isPending) setPendingDelete(null); }}>
            <div className="confirm-modal" role="dialog" aria-modal="true" aria-labelledby="delete-ges-title" onMouseDown={(event) => event.stopPropagation()}>
              <h3 id="delete-ges-title">Delete {pendingAccount.name}?</h3>
              <p>This removes the account, its evaluations, and its linked IPP matches. This cannot be undone.</p>
              <div className="card-tools" style={{ justifyContent: 'flex-end' }}>
                <button className="small-button" type="button" onClick={() => setPendingDelete(null)} disabled={remove.isPending}>Cancel</button>
                <button className="danger-button" type="button" disabled={remove.isPending} onClick={() => remove.mutate(pendingAccount.id)}>{remove.isPending ? 'Deleting…' : 'Confirm delete'}</button>
              </div>
            </div>
          </div>
        )}
        <div className="data-table-wrap">
          <table className="data-table">
            <thead>
              <tr>
                <th><button type="button" onClick={() => sortBy('name')}>GES / code {sortKey === 'name' ? (sortAsc ? '↑' : '↓') : ''}</button></th>
                <th>Location</th>
                <th>Stage</th>
                <th><button type="button" onClick={() => sortBy('consumption')}>Annual consumption {sortKey === 'consumption' ? (sortAsc ? '↑' : '↓') : ''}</button></th>
                <th><button type="button" onClick={() => sortBy('target')}>Renewable target {sortKey === 'target' ? (sortAsc ? '↑' : '↓') : ''}</button></th>
                <th>Technology / storage</th>
                <th>Load matches</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {visible.map((ges) => {
          const place = [ges.city, ges.state].filter(Boolean).join(', ') || ges.location;
          const consumption = ges.annualConsumptionGwh && ges.annualConsumptionGwh > 0 ? ges.annualConsumptionGwh : null;
          const target = ges.renewableEnergyTargetPercent;
          const technology = technologyLabel(ges.requirement.preferredTechnologies);
          const bess = bessLabel(ges.bessRequirement, ges.requirement.bessPreference);
                return (
                  <tr key={ges.id}>
                    <td><strong><Link href={`/ges/${ges.id}`}>{ges.name}</Link></strong><span className="number-sub">{ges.code} · {ges.discom?.trim() || 'DISCOM not specified'}</span></td>
                    <td>{place || 'Not specified'}{ges.consumerNumbers?.trim() ? <span className="number-sub">Consumer no: {ges.consumerNumbers}</span> : null}</td>
                    <td><StatusPill status={ges.stage} /></td>
                    <td>{consumption === null ? '—' : `${amount(consumption, 4)} GWh/year`}</td>
                    <td>{target == null ? '—' : `${amount(target, 1)}%`}</td>
                    <td><span className="tech-tag">{technology}</span><span className="number-sub">BESS: {bess}</span></td>
                    <td>{ges.ipps?.length ? `${ges.ipps.length} calculated` : 'Not calculated'}</td>
                    <td>
                      <div className="row-actions">
                        <Link className="small-button icon-only" href={`/ges/${ges.id}`} aria-label={`View ${ges.name}`}><Eye size={12} /></Link>
                        <Link className="small-button icon-only" href={`/ges/${ges.id}/requirements`} aria-label={`Requirements for ${ges.name}`}><ClipboardList size={12} /></Link>
                        <Link className="small-button icon-only" href={`/ges/${ges.id}/selections`} aria-label={`Selected IPPs for ${ges.name}`}><ListChecks size={12} /></Link>
                        <Link className="small-button icon-only" href={`/ges/${ges.id}/comparison`} aria-label={`Compare IPPs for ${ges.name}`}><ArrowLeftRight size={12} /></Link>
                        {canEdit && <Link className="small-button icon-only" href={`/ges/${ges.id}/edit`} aria-label={`Edit ${ges.name}`}><Pencil size={12} /></Link>}
                        {canEdit && <button className="danger-button icon-only" type="button" aria-label={`Delete ${ges.name}`} onClick={() => setPendingDelete(ges.id)}><Trash2 size={12} /></button>}
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
          {!visible.length && <div className="empty-state"><span>No GES accounts match these filters.</span></div>}
        </div>
        <TablePagination recordCount={filtered.length} currentPage={currentPage} pageSize={pageSize} onPageChange={setPage} onPageSizeChange={setPageSize} recordLabel="accounts" />
      </section>
    </AppShell>
  );
}
