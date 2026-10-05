'use client';

import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { ReactNode, useEffect, useLayoutEffect, useMemo, useRef, useState } from 'react';
import { createPortal } from 'react-dom';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { Eye, Pencil, Plus, Search, Trash } from 'lucide-react';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../components/AppShell';
import { ErrorState, NewraLoader, PageSkeleton } from '../../components/DataState';
import { TablePagination } from '../../components/TablePagination';
import { useAuth } from '../../features/auth/AuthProvider';
import { IppAccountForm } from '../../features/ipp/IppForm';
import { includesBess } from '../../features/ipp/options';
import { api, listQuery } from '../../services/api';
import { IppCatalogRow } from '../../types/api';

type SortKey = 'name' | 'capacity' | 'generation' | 'p90' | 'tariff' | 'cod';

function amount(value: number, digits = 1) {
  return value.toLocaleString('en-IN', { maximumFractionDigits: digits });
}

function Tip({ text, children }: { text: string; children: ReactNode }) {
  const [anchor, setAnchor] = useState<HTMLElement | null>(null);
  const bubble = useRef<HTMLSpanElement>(null);
  const [place, setPlace] = useState({ left: -9999, top: 0, below: false, ready: false });
  useLayoutEffect(() => {
    if (!anchor || !bubble.current) return;
    const inHeader = Boolean(anchor.closest('thead'));
    const host = inHeader ? anchor.closest('th') ?? anchor : anchor;
    const rect = host.getBoundingClientRect();
    const height = bubble.current.offsetHeight;
    const width = bubble.current.offsetWidth;
    const gap = 10;
    const headerBottom = document.querySelector('.ipp-register thead')?.getBoundingClientRect().bottom ?? 0;
    const aboveTop = rect.top - height - gap;
    const fitsAbove = aboveTop > 8 && (inHeader || aboveTop >= headerBottom);
    const below = !fitsAbove;
    const center = Math.min(window.innerWidth - width / 2 - 8, Math.max(width / 2 + 8, rect.left + rect.width / 2));
    setPlace({ left: center, top: below ? rect.bottom + gap : rect.top - gap, below, ready: true });
  }, [anchor, text]);
  return (
    <span className="tip" onMouseEnter={(event) => setAnchor(event.currentTarget)} onMouseLeave={() => setAnchor(null)} onFocus={(event) => setAnchor(event.currentTarget)} onBlur={() => setAnchor(null)}>
      {children}
      {anchor && createPortal(
        <span ref={bubble} className={place.below ? 'tip-bubble below' : 'tip-bubble'} style={{ left: place.left, top: place.top, visibility: place.ready ? 'visible' : 'hidden' }} role="tooltip">{text}</span>,
        document.body,
      )}
    </span>
  );
}

function capacityText(ipp: IppCatalogRow) {
  const lines = [];
  if (ipp.solarMw > 0) lines.push(`Solar ${amount(ipp.solarMw)} MW`);
  if (ipp.windMw > 0) lines.push(`Wind ${amount(ipp.windMw)} MW`);
  if (includesBess(ipp.technology) || ipp.bessMw > 0 || ipp.bessMwh > 0) {
    lines.push(ipp.bessMw > 0 || ipp.bessMwh > 0 ? `BESS ${amount(ipp.bessMw)} MW / ${amount(ipp.bessMwh)} MWh` : 'BESS —');
  } else lines.push('BESS none');
  return lines;
}

export default function IppRegisterPage() {
  const { user, ready } = useAuth();
  const router = useRouter();
  useEffect(() => {
    if (user?.gesId) router.replace('/client/ipps');
  }, [user, router]);
  const client = useQueryClient();
  const canCreate = user?.permissions.includes('IPP_CREATE') ?? false;
  const canEdit = user?.permissions.includes('IPP_EDIT') ?? false;
  const [search, setSearch] = useState('');
  const [technology, setTechnology] = useState('ALL');
  const [projectState, setProjectState] = useState('ALL');
  const [projectStatus, setProjectStatus] = useState('ALL');
  const [bess, setBess] = useState('ALL');
  const [fdre, setFdre] = useState('ALL');
  const [codYear, setCodYear] = useState('ALL');
  const [tariffMin, setTariffMin] = useState('');
  const [tariffMax, setTariffMax] = useState('');
  const [sortKey, setSortKey] = useState<SortKey>('name');
  const [sortAsc, setSortAsc] = useState(true);
  const [pageSize, setPageSize] = useState(10);
  const [page, setPage] = useState(1);
  const [pendingDelete, setPendingDelete] = useState<string | null>(null);
  const query = useQuery({
    queryKey: ['ipp-catalog'],
    queryFn: () => api.get<IppCatalogRow[]>('/ipp-catalog'),
    enabled: ready && !user?.gesId,
    ...listQuery,
  });
  const remove = useMutation({
    mutationFn: (id: string) => api.delete<IppCatalogRow[]>(`/ipps/${id}`),
    onSuccess: (rows) => {
      toast.success('Independent power producer deleted');
      setPendingDelete(null);
      client.setQueryData(['ipp-catalog'], rows);
      void client.invalidateQueries({ queryKey: ['dashboard'] });
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'Independent power producer could not be deleted'),
  });

  const rows = query.data ?? [];
  const technologies = useMemo(() => ['ALL', ...new Set(rows.map((ipp) => ipp.technology).filter(Boolean))], [rows]);
  const states = useMemo(() => ['ALL', ...new Set(rows.map((ipp) => ipp.projectState).filter(Boolean))].sort(), [rows]);
  const statuses = useMemo(() => ['ALL', ...new Set(rows.map((ipp) => ipp.projectStatus).filter(Boolean))].sort(), [rows]);
  const fdreOptions = useMemo(() => ['ALL', ...new Set(rows.map((ipp) => ipp.fdreCapability || 'Not specified'))], [rows]);
  const years = useMemo(() => ['ALL', ...new Set(rows.map((ipp) => (ipp.codYear && ipp.codYear > 0 ? String(ipp.codYear) : 'Not specified')))].sort(), [rows]);
  const filtered = useMemo(() => {
    const queryText = search.trim().toLowerCase();
    const minTariff = tariffMin === '' ? null : Number(tariffMin);
    const maxTariff = tariffMax === '' ? null : Number(tariffMax);
    const next = rows.filter((ipp) => {
      const haystack = `${ipp.name} ${ipp.projectName} ${ipp.code} ${ipp.projectState} ${ipp.projectDistrict ?? ''} ${ipp.headquarters} ${ipp.technology}`.toLowerCase();
      if (queryText && !haystack.includes(queryText)) return false;
      if (technology !== 'ALL' && ipp.technology !== technology) return false;
      if (projectState !== 'ALL' && ipp.projectState !== projectState) return false;
      if (projectStatus !== 'ALL' && ipp.projectStatus !== projectStatus) return false;
      const hasBess = includesBess(ipp.technology) || ipp.bessMw > 0;
      if (bess === 'WITH' && !hasBess) return false;
      if (bess === 'WITHOUT' && hasBess) return false;
      if (fdre !== 'ALL' && (ipp.fdreCapability || 'Not specified') !== fdre) return false;
      const yearLabel = ipp.codYear && ipp.codYear > 0 ? String(ipp.codYear) : 'Not specified';
      if (codYear !== 'ALL' && yearLabel !== codYear) return false;
      if (minTariff != null && Number.isFinite(minTariff) && ipp.tariff < minTariff) return false;
      if (maxTariff != null && Number.isFinite(maxTariff) && ipp.tariff > maxTariff) return false;
      return true;
    });
    const value = (ipp: IppCatalogRow) => {
      if (sortKey === 'capacity') return ipp.solarMw + ipp.windMw;
      if (sortKey === 'generation') return ipp.annualGenerationGwh;
      if (sortKey === 'p90') return ipp.p90Gwh ?? -1;
      if (sortKey === 'tariff') return ipp.tariff;
      if (sortKey === 'cod') return ipp.codYear && ipp.codYear > 0 ? ipp.codYear : 9999;
      return ipp.name.toLowerCase();
    };
    return next.sort((left, right) => {
      const a = value(left);
      const b = value(right);
      const result = typeof a === 'string' && typeof b === 'string' ? a.localeCompare(b) : Number(a) - Number(b);
      return sortAsc ? result : -result;
    });
  }, [rows, search, technology, projectState, projectStatus, bess, fdre, codYear, tariffMin, tariffMax, sortKey, sortAsc]);
  const pageCount = Math.max(1, Math.ceil(filtered.length / pageSize));
  const currentPage = Math.min(page, pageCount);
  const start = (currentPage - 1) * pageSize;
  const visible = filtered.slice(start, start + pageSize);

  useEffect(() => {
    setPage(1);
  }, [search, technology, projectState, projectStatus, bess, fdre, codYear, tariffMin, tariffMax, pageSize]);

  useEffect(() => {
    if (!pendingDelete) return;
    function onKey(event: KeyboardEvent) {
      if (event.key === 'Escape' && !remove.isPending) setPendingDelete(null);
    }
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [pendingDelete, remove.isPending]);

  function sortBy(key: SortKey) {
    if (sortKey === key) setSortAsc((current) => !current);
    else {
      setSortKey(key);
      setSortAsc(key === 'name');
    }
  }

  if (user?.gesId) return <NewraLoader label="Opening your workspace" />;
  if (query.isLoading) return <AppShell><PageSkeleton variant="table" /></AppShell>;
  if (query.error) return <AppShell><ErrorState message="Unable to load independent power producers." retry={() => void query.refetch()} /></AppShell>;
  if (!rows.length && canCreate) return <AppShell><IppAccountForm /></AppShell>;

  return (
    <AppShell>
      <PageHeader eyebrow="INDEPENDENT POWER PRODUCER" title="Independent power producer" description="A first look at each project: where it is, what it can generate, the tariff, and whether it is ready. The comparator does the scored comparison.">
        {canCreate && <Link className="primary-button" href="/ipps/new"><Plus size={14} /> Add IPP</Link>}
      </PageHeader>
      <section className="card ipp-register">
        <div className="table-toolbar">
          <div><h2 className="card-title">Count:<span className="count-badge">{filtered.length}</span></h2></div>
          <div className="table-actions">
            <label className="search-field wide"><Search size={13} /><input value={search} onChange={(event) => setSearch(event.target.value)} placeholder="Search name, project, state" aria-label="Search independent power producers" /></label>
            <select className="filter-select" value={technology} onChange={(event) => setTechnology(event.target.value)} aria-label="Filter by technology">
              {technologies.map((item) => <option key={item} value={item}>{item === 'ALL' ? 'All technologies' : item}</option>)}
            </select>
            <select className="filter-select" value={projectState} onChange={(event) => setProjectState(event.target.value)} aria-label="Filter by project state">
              {states.map((item) => <option key={item} value={item}>{item === 'ALL' ? 'All project states' : item}</option>)}
            </select>
            <select className="filter-select" value={projectStatus} onChange={(event) => setProjectStatus(event.target.value)} aria-label="Filter by project status">
              {statuses.map((item) => <option key={item} value={item}>{item === 'ALL' ? 'All project statuses' : item}</option>)}
            </select>
            <select className="filter-select" value={bess} onChange={(event) => setBess(event.target.value)} aria-label="Filter by storage">
              <option value="ALL">All storage</option>
              <option value="WITH">With BESS</option>
              <option value="WITHOUT">Without BESS</option>
            </select>
            <select className="filter-select" value={fdre} onChange={(event) => setFdre(event.target.value)} aria-label="Filter by firm supply">
              {fdreOptions.map((item) => <option key={item} value={item}>{item === 'ALL' ? 'All FDRE' : item}</option>)}
            </select>
            <select className="filter-select" value={codYear} onChange={(event) => setCodYear(event.target.value)} aria-label="Filter by expected COD">
              {years.map((item) => <option key={item} value={item}>{item === 'ALL' ? 'All COD years' : item}</option>)}
            </select>
            <input className="filter-select" type="number" min={0} step="0.01" value={tariffMin} onChange={(event) => setTariffMin(event.target.value)} placeholder="Min ₹/kWh" aria-label="Minimum tariff" style={{ width: 96 }} />
            <input className="filter-select" type="number" min={0} step="0.01" value={tariffMax} onChange={(event) => setTariffMax(event.target.value)} placeholder="Max ₹/kWh" aria-label="Maximum tariff" style={{ width: 96 }} />
          </div>
        </div>
        {pendingDelete && (
          <div className="modal-backdrop" onMouseDown={() => { if (!remove.isPending) setPendingDelete(null); }}>
            <div className="confirm-modal" role="dialog" aria-modal="true" aria-labelledby="delete-ipp-title" onMouseDown={(event) => event.stopPropagation()}>
              <h3 id="delete-ipp-title">Delete {rows.find((ipp) => ipp.id === pendingDelete)?.name}?</h3>
              <p>This removes the producer and its matches against every GES. This cannot be undone.</p>
              <div className="card-tools" style={{ justifyContent: 'flex-end' }}>
                <button className="small-button" type="button" onClick={() => setPendingDelete(null)} disabled={remove.isPending}>Cancel</button>
                <button className="danger-button" type="button" disabled={remove.isPending} onClick={() => remove.mutate(pendingDelete)}>{remove.isPending ? 'Deleting…' : 'Confirm delete'}</button>
              </div>
            </div>
          </div>
        )}
        <div className="data-table-wrap">
          <table className="data-table">
            <thead>
              <tr>
                <th><Tip text="Sort by company name"><button type="button" onClick={() => sortBy('name')}>IPP / project {sortKey === 'name' ? (sortAsc ? '↑' : '↓') : ''}</button></Tip></th>
                <th>Location</th>
                <th>Technology</th>
                <th><Tip text="Sort by solar plus wind capacity"><button type="button" onClick={() => sortBy('capacity')}>Capacity {sortKey === 'capacity' ? (sortAsc ? '↑' : '↓') : ''}</button></Tip></th>
                <th><Tip text="Sort by annual generation"><button type="button" onClick={() => sortBy('generation')}>Generation {sortKey === 'generation' ? (sortAsc ? '↑' : '↓') : ''}</button></Tip></th>
                <th className="tab-hide"><Tip text="Sort by conservative generation"><button type="button" onClick={() => sortBy('p90')}>P90 {sortKey === 'p90' ? (sortAsc ? '↑' : '↓') : ''}</button></Tip></th>
                <th><Tip text="Sort by offered tariff"><button type="button" onClick={() => sortBy('tariff')}>Tariff {sortKey === 'tariff' ? (sortAsc ? '↑' : '↓') : ''}</button></Tip></th>
                <th><Tip text="Sort by expected commercial operation year"><button type="button" onClick={() => sortBy('cod')}>COD {sortKey === 'cod' ? (sortAsc ? '↑' : '↓') : ''}</button></Tip></th>
                <th>Status</th>
                <th className="tab-hide">FDRE</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {visible.map((ipp) => {
                const place = [ipp.projectDistrict, ipp.projectState].filter(Boolean).join(', ') || '—';
                return (
                  <tr key={ipp.id}>
                    <td>
                      <strong><Link href={`/ipps/${ipp.id}`}>{ipp.name}</Link></strong>
                      <span className="number-sub">{ipp.projectName || 'Project not specified'}</span>
                    </td>
                    <td><span>{place}</span>{ipp.projectLocation ? <span className="number-sub">{ipp.projectLocation}</span> : null}</td>
                    <td><span className="tech-tag">{ipp.technology || 'Not specified'}</span></td>
                    <td><div className="ipp-capacity">{capacityText(ipp).map((line) => <span key={line}>{line}</span>)}</div></td>
                    <td>{amount(ipp.annualGenerationGwh, 1)} GWh/year</td>
                    <td className="tab-hide">{ipp.p90Gwh ? `${amount(ipp.p90Gwh, 1)} GWh/year` : '—'}</td>
                    <td>₹{ipp.tariff.toFixed(2)}/kWh</td>
                    <td>{ipp.codYear && ipp.codYear > 0 ? ipp.codYear : '—'}</td>
                    <td><span className="tech-tag">{ipp.projectStatus || 'Not specified'}</span></td>
                    <td className="tab-hide">{ipp.fdreCapability || 'Not specified'}</td>
                    <td>
                      <div className="row-actions">
                        <Link
                          className="small-button icon-only"
                          href={`/ipps/${ipp.id}`}
                          aria-label={`View ${ipp.name}`}
                        >
                          <Eye size={12} strokeWidth={1.75} />
                        </Link>

                        {canEdit && (
                          <Link
                            className="small-button icon-only"
                            href={`/ipps/${ipp.id}/edit`}
                            aria-label={`Edit ${ipp.name}`}
                          >
                            <Pencil size={12} strokeWidth={1.75} />
                          </Link>
                        )}

                        {canEdit && (
                          <button
                            className="small-button icon-only" // Changed from danger-button to match other icons
                            type="button"
                            aria-label="Delete" // Removed the dynamic name to prevent browser tooltip
                            onClick={() => setPendingDelete(ipp.id)}
                          >
                            <Trash size={12} strokeWidth={1.75} />
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
          {!visible.length && <div className="empty-state"><span>No independent power producer matches this search.</span></div>}
        </div>
        <TablePagination recordCount={filtered.length} currentPage={currentPage} pageSize={pageSize} onPageChange={setPage} onPageSizeChange={setPageSize} recordLabel="producers" />
      </section>
    </AppShell>
  );
}
