'use client';

import Link from 'next/link';
import { useEffect, useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { ArrowRight, MapPin, Pencil, Plus, Trash2 } from 'lucide-react';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../components/AppShell';
import { ErrorState, LoadingState } from '../../components/DataState';
import { StatusPill } from '../../components/StatusPill';
import { useAuth } from '../../features/auth/AuthProvider';
import { GesAccountForm } from '../../features/ges/GesForm';
import { bessLabel, technologyLabel } from '../../features/ges/options';
import { useWorkspace } from '../../features/workspace/WorkspaceProvider';
import { api } from '../../services/api';
import { GesAccount } from '../../types/api';

function amount(value: number, digits = 3) {
  return value.toLocaleString('en-IN', { maximumFractionDigits: digits });
}

function Metric({ label, value, badge, kind }: { label: string; value: string; badge: string; kind?: 'customer' | 'calculated' }) {
  return (
    <span>
      <small>{label} <span className={`field-badge ${kind ?? ''}`}>{badge}</span></small>
      <strong>{value}</strong>
    </span>
  );
}

export default function GesListPage() {
  const { user } = useAuth();
  const { gesId, selectGes } = useWorkspace();
  const client = useQueryClient();
  const canCreate = user?.permissions.includes('GES_CREATE') ?? false;
  const canEdit = user?.permissions.includes('GES_EDIT') ?? false;
  const [pendingDelete, setPendingDelete] = useState<string | null>(null);
  const query = useQuery({ queryKey: ['ges'], queryFn: () => api.get<GesAccount[]>('/ges'), refetchInterval: 15000 });
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

  if (query.isLoading) return <AppShell><LoadingState /></AppShell>;
  if (query.error) return <AppShell><ErrorState message="Unable to load accounts." retry={() => void query.refetch()} /></AppShell>;
  if (!query.data?.length && canCreate) return <AppShell><GesAccountForm /></AppShell>;

  return (
    <AppShell>
      <PageHeader eyebrow="GES" title="GES" description="Each account shows who the customer is, the electricity they use today, and the renewable requirement they have specified. IPP matching is listed separately.">
        {canCreate && <Link className="primary-button" href="/ges/new"><Plus size={14} /> Add GES</Link>}
      </PageHeader>
      <div className="dealbook-grid">
        {query.data?.map((ges) => {
          const place = [ges.city, ges.state].filter(Boolean).join(', ') || ges.location;
          const consumption = ges.annualConsumptionGwh && ges.annualConsumptionGwh > 0 ? ges.annualConsumptionGwh : null;
          const monthly = consumption === null ? null : (consumption * 1000) / 12;
          const peakKva = ges.peakRecordedDemandKva && ges.peakRecordedDemandKva > 0
            ? ges.peakRecordedDemandKva
            : ges.requirement.peakDemandMw > 0 ? ges.requirement.peakDemandMw * 1000 : null;
          const contractKva = ges.contractDemandMw && ges.contractDemandMw > 0 ? ges.contractDemandMw * 1000 : null;
          const rooftopKw = ges.existingRooftopMw && ges.existingRooftopMw > 0 ? ges.existingRooftopMw * 1000 : null;
          const target = ges.renewableEnergyTargetPercent;
          const hasTarget = target !== null && target !== undefined;
          const required = hasTarget && consumption !== null ? consumption * (target / 100) : null;
          const technology = technologyLabel(ges.requirement.preferredTechnologies);
          const bess = bessLabel(ges.bessRequirement, ges.requirement.bessPreference);
          return (
          <section className="card dealbook-card" key={ges.id}>
            <div className="dealbook-head">
              <div>
                <span className="tiny-label">{ges.code}</span>
                <h2><Link href={`/ges/${ges.id}`}>{ges.name}</Link></h2>
                <p><MapPin size={10} /> {place || 'Not specified'}</p>
                <p>{ges.discom?.trim() || 'DISCOM not specified'}</p>
                <p>Consumer no: {ges.consumerNumbers?.trim() || 'Not specified'}</p>
              </div>
              <div className="card-tools">
                <StatusPill status={ges.stage} />
                {canEdit && <Link className="small-button" href={`/ges/${ges.id}/edit`}><Pencil size={11} /> Edit</Link>}
                {canEdit && <button className="danger-button" type="button" onClick={() => setPendingDelete(ges.id)}><Trash2 size={11} /> Delete</button>}
              </div>
            </div>
            {pendingDelete === ges.id && (
              <div className="modal-backdrop" onMouseDown={() => { if (!remove.isPending) setPendingDelete(null); }}>
                <div className="confirm-modal" role="dialog" aria-modal="true" aria-labelledby="delete-ges-title" onMouseDown={(event) => event.stopPropagation()}>
                  <h3 id="delete-ges-title">Delete {ges.name}?</h3>
                  <p>This removes the account, its evaluations, and its linked IPP matches. This cannot be undone.</p>
                  <div className="card-tools" style={{ justifyContent: 'flex-end' }}>
                    <button className="small-button" type="button" onClick={() => setPendingDelete(null)} disabled={remove.isPending}>Cancel</button>
                    <button className="danger-button" type="button" disabled={remove.isPending} onClick={() => remove.mutate(ges.id)}>{remove.isPending ? 'Deleting…' : 'Confirm delete'}</button>
                  </div>
                </div>
              </div>
            )}
            <div className="dealbook-section-title"><strong>Electricity profile</strong></div>
            <div className="dealbook-metrics ges-profile-metrics">
              <Metric label="Annual consumption" value={consumption === null ? '—' : `${amount(consumption, 4)} GWh/year`} badge="Electricity profile" />
              <Metric label="Average monthly" value={monthly === null ? '—' : `${amount(monthly, 3)} MWh/month`} badge="Auto calculated" kind="calculated" />
              <Metric label="Peak recorded demand" value={peakKva === null ? '—' : `${amount(peakKva, 1)} kVA`} badge="Electricity profile" />
              <Metric label="Contract demand" value={contractKva === null ? '—' : `${amount(contractKva, 1)} kVA`} badge="Electricity profile" />
              <Metric label="Sanctioned load" value={ges.sanctionedLoadKw ? `${amount(ges.sanctionedLoadKw, 1)} kW` : '—'} badge="Electricity profile" />
              <Metric label="Existing rooftop solar" value={rooftopKw === null ? '—' : `${amount(rooftopKw, 1)} kW`} badge="Electricity profile" />
            </div>
            <div className="dealbook-section-title"><strong>Renewable requirement</strong></div>
            <div className="dealbook-metrics ges-profile-metrics">
              <Metric label="Renewable energy target" value={hasTarget ? `${amount(target, 1)}%` : 'Not specified'} badge="Customer input" kind="customer" />
              <Metric label="Required renewable energy" value={required === null ? 'Not specified' : `${amount(required, 4)} GWh/year`} badge="Auto calculated" kind="calculated" />
              <Metric label="Target supply start" value={ges.requirement.targetCodYear > 0 ? String(ges.requirement.targetCodYear) : 'Not specified'} badge="Customer input" kind="customer" />
            </div>
            <div className="dealbook-section-title"><strong>Procurement preference</strong></div>
            <div className="tag-list">
              <span className="tech-tag">{technology === 'Not specified' ? 'Technology: Not specified' : technology}</span>
              <span className="tech-tag">BESS: {bess}</span>
            </div>
            <div className="dealbook-section-title">
              <strong>Load match snapshot</strong>
              <span>{ges.ipps?.length ? `${ges.ipps.length} calculated` : 'No calculation yet'}</span>
            </div>
            <p className="card-subtitle">Calculated against the global IPP catalogue. This is not IPP ownership. Selections are recorded only when a GES considers an IPP.</p>
            {ges.ipps?.length ? (
              <>
                <p className="card-subtitle" style={{ margin: '0 0 8px' }}>Calculated generation match</p>
                <div className="data-table-wrap">
                  <table className="data-table">
                    <thead><tr><th>IPP</th><th>Available</th><th>Used</th><th>Of IPP</th><th>Of GES</th></tr></thead>
                    <tbody>
                      {ges.ipps.map((ipp) => (
                        <tr key={ipp.id}>
                          <td><strong>{ipp.name}</strong><span className="number-sub">{ipp.technology}</span></td>
                          <td>{amount(ipp.availableGwh, 1)} GWh</td>
                          <td><strong>{amount(ipp.matchedGwh, 1)} GWh</strong></td>
                          <td>{ipp.usedPct}%</td>
                          <td>{ipp.coveragePct}%</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </>
            ) : <div className="empty-state"><span>No IPP matching completed yet</span></div>}
            <div className="card-tools" style={{ marginTop: 12 }}>
              <Link className="small-button" href={`/ges/${ges.id}/requirements`}>GES requirement</Link>
              <Link className="small-button" href={`/ges/${ges.id}/selections`}>Selected IPPs</Link>
              <Link className="list-link" href={`/ges/${ges.id}/comparison`}>Open comparator <ArrowRight size={12} /></Link>
            </div>
          </section>
          );
        })}
      </div>
    </AppShell>
  );
}
