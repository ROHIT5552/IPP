'use client';

import { FormEvent, useEffect, useMemo, useState } from 'react';
import { useParams, useSearchParams } from 'next/navigation';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import {
  AlertTriangle,
  ArrowDownToLine,
  ArrowRight,
  Check,
  ChevronDown,
  Download,
  FileSearch,
  Info,
  Pencil,
  RefreshCw,
  SlidersHorizontal,
  Sparkles,
  X,
} from 'lucide-react';
import {
  Bar,
  BarChart,
  CartesianGrid,
  Cell,
  Legend,
  PolarAngleAxis,
  PolarGrid,
  PolarRadiusAxis,
  Radar,
  RadarChart,
  ReferenceLine,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../../../components/AppShell';
import { ErrorState, LoadingState } from '../../../../components/DataState';
import { StatusPill } from '../../../../components/StatusPill';
import { useAuth } from '../../../../features/auth/AuthProvider';
import { InfoTooltip } from '../../../../features/terms/InfoTooltip';
import { bessLabel } from '../../../../features/ges/options';
import { useWorkspace } from '../../../../features/workspace/WorkspaceProvider';
import { api } from '../../../../services/api';
import { CHART_COLORS, CHART_THEME } from '../../../../constants/demo';
import {
  ComparisonProvider,
  ComparisonResponse,
  GesRequirement,
} from '../../../../types/api';

const fmt = (value: number, places = 0) =>
  value.toLocaleString('en-IN', {
    maximumFractionDigits: places,
    minimumFractionDigits: places,
  });

function Drawer({
  title,
  children,
  onClose,
}: {
  title: string;
  children: React.ReactNode;
  onClose: () => void;
}) {
  return (
    <div className="drawer-backdrop" role="presentation" onMouseDown={onClose}>
      <aside className="drawer" role="dialog" aria-modal="true" aria-label={title} onMouseDown={(event) => event.stopPropagation()}>
        <div className="drawer-top"><h3>{title}</h3><button className="drawer-close" onClick={onClose} aria-label="Close"><X size={15} /></button></div>
        {children}
      </aside>
    </div>
  );
}

function RadarTip({ active, payload, label, providers }: {
  active?: boolean;
  payload?: { dataKey: string; value: number; color: string }[];
  label?: string;
  providers: ComparisonProvider[];
}) {
  if (!active || !payload?.length) return null;
  return (
    <div className="chart-tooltip">
      <strong>{label}</strong>
      {payload.map((item) => {
        const provider = providers.find((candidate) => candidate.ipp.id === item.dataKey);
        const parameter = provider?.evaluation.parameters.find((candidate) => candidate.shortLabel === label);
        return <span key={item.dataKey} style={{ color: item.color }}>{provider?.ipp.name}: {parameter?.score.toFixed(1)}/5 · {item.value}/100 · weight {parameter?.weight}</span>;
      })}
    </div>
  );
}

export default function ComparisonPage() {
  const params = useParams<{ gesId: string }>();
  const gesId = params.gesId;
  const { selectGes } = useWorkspace();
  const { user } = useAuth();
  const canShortlist = Boolean(user?.permissions.includes('COMMERCIAL_REVIEW'));
  const canEditIpp = Boolean(user?.permissions.includes('IPP_EDIT'));
  const canReviewTariff = Boolean(user?.permissions.includes('TARIFF_REVIEW'));
  const canEditRequirement = Boolean(user?.permissions.includes('REQUIREMENT_EDIT'));
  const requestedIds = (useSearchParams().get('ippIds') ?? '').split(',').filter(Boolean).slice(0, 3);
  const [shortlistIntent, setShortlistIntent] = useState<{ ippId: string; shortlisted: boolean } | null>(null);
  const queryClient = useQueryClient();
  const [selectedIds, setSelectedIds] = useState<string[]>([]);
  const [focusId, setFocusId] = useState('');
  const [initializedFor, setInitializedFor] = useState('');
  const [drawer, setDrawer] = useState<'requirements' | 'technical' | 'factor' | null>(null);
  const [factorKey, setFactorKey] = useState('');
  const [search, setSearch] = useState('');
  const [sortKey, setSortKey] = useState('suitability');
  const [scenario, setScenario] = useState({ capexChangePct: 5, interestChangePct: 1, codDelayMonths: 0, cufReductionPct: 0, bessCostChangePct: 0 });
  const optionsQuery = useQuery({
    queryKey: ['ges-providers', gesId],
    queryFn: () => api.get<{ id: string }[]>(`/ges/${gesId}/ipps`),
  });
  useEffect(() => {
    if (!optionsQuery.data || initializedFor === gesId) return;
    const available = new Set(optionsQuery.data.map((item) => item.id));
    const requested = requestedIds.filter((id) => available.has(id));
    const ids = (requested.length ? requested : optionsQuery.data.slice(0, 3).map((item) => item.id));
    setSelectedIds(ids);
    setFocusId(ids[0] ?? '');
    setInitializedFor(gesId);
  }, [optionsQuery.data, gesId, initializedFor, requestedIds]);
  const query = useQuery({
    queryKey: ['comparison', gesId, selectedIds],
    queryFn: () => api.get<ComparisonResponse>(`/ges/${gesId}/comparison?ippIds=${selectedIds.join(',')}`),
    enabled: selectedIds.length > 0,
  });
  const data = query.data;
  const requirementMutation = useMutation({
    mutationFn: (body: Partial<GesRequirement>) => api.patch(`/ges/${gesId}/requirements`, body),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ['comparison', gesId] });
      void queryClient.invalidateQueries({ queryKey: ['dashboard', gesId] });
      toast.success('Requirement saved; evaluation recalculated.');
      setDrawer(null);
    },
    onError: (error) => toast.error(error.message),
  });
  const inputMutation = useMutation({
    mutationFn: ({ ippId, body }: { ippId: string; body: Record<string, number> }) => api.patch(`/ipps/${ippId}/input`, body),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ['comparison', gesId] });
      toast.success('Provider inputs updated and recalculated.');
      setDrawer(null);
    },
    onError: (error) => toast.error(error.message),
  });
  const scenarioMutation = useMutation({
    mutationFn: ({ ippId, body }: { ippId: string; body: typeof scenario }) => api.post<{ scenarioTariff: number }>(`/ipps/${ippId}/tariff/scenario`, body),
    onSuccess: (result: { scenarioTariff: number }) => {
      void queryClient.invalidateQueries({ queryKey: ['comparison', gesId] });
      toast.success(`Scenario tariff recalculated: ₹${result.scenarioTariff.toFixed(2)}/kWh`);
    },
    onError: (error) => toast.error(error.message),
  });
  const shortlistMutation = useMutation({
    mutationFn: ({ ippId, shortlisted }: { ippId: string; shortlisted: boolean }) => api.post(`/ges/${gesId}/ipps/${ippId}/shortlist`, { shortlisted }),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ['comparison', gesId] });
      void queryClient.invalidateQueries({ queryKey: ['dashboard'] });
      toast.success('Shortlist updated.');
      setShortlistIntent(null);
    },
    onError: (error) => toast.error(error.message),
  });

  const focus = data?.selectedIpps.find((item) => item.ipp.id === focusId) ?? data?.selectedIpps[0];
  const filteredRows = useMemo(() => {
    if (!data) return [];
    const needle = search.toLowerCase();
    return [...data.comparisonTable]
      .filter((row) => row.name.toLowerCase().includes(needle) || row.technology.toLowerCase().includes(needle))
      .sort((a, b) => {
        const left = a[sortKey as keyof typeof a];
        const right = b[sortKey as keyof typeof b];
        return typeof left === 'number' && typeof right === 'number' ? right - left : String(left).localeCompare(String(right));
      });
  }, [data, search, sortKey]);

  function toggleProvider(id: string) {
    setSelectedIds((current) => {
      if (current.includes(id)) {
        if (current.length === 1) {
          toast.error('Select at least one provider.');
          return current;
        }
        const next = current.filter((value) => value !== id);
        if (focusId === id) setFocusId(next[0]);
        return next;
      }
      if (current.length >= 3) {
        toast.error('Compare no more than three providers at once.');
        return current;
      }
      if (!current.length) setFocusId(id);
      return [...current, id];
    });
  }

  function exportCsv() {
    if (!data) return;
    const columns = ['Provider', 'Technology', 'Capacity MW', 'Annual generation GWh', 'P90 GWh', 'Storage MW', 'Tariff INR per kWh', 'CAPEX INR cr', 'COD', 'Evaluation', 'Requirement match %', 'Load match', 'Coverage', 'Required check', 'Issues'];
    const rows = data.comparisonTable.map((row) => [row.name, row.technology, row.capacityMw, row.annualGenerationGwh, row.p90Gwh, row.bessMw, row.tariff, row.capexInrCr, row.targetCodYear, row.evaluationScore, row.suitability, row.loadMatchPct, row.coveragePct, row.criticalGate, row.riskCount]);
    const csv = [columns, ...rows].map((row) => row.map((cell) => `"${String(cell).replaceAll('"', '""')}"`).join(',')).join('\n');
    const link = document.createElement('a');
    link.href = URL.createObjectURL(new Blob([csv], { type: 'text/csv;charset=utf-8' }));
    link.download = `${data.ges.code.toLowerCase().replace(' ', '-')}-comparison.csv`;
    link.click();
    URL.revokeObjectURL(link.href);
  }

  if (optionsQuery.isLoading || (selectedIds.length > 0 && query.isLoading)) return <AppShell><LoadingState label="Recalculating comparison" /></AppShell>;
  if (optionsQuery.error) return <AppShell><ErrorState message={optionsQuery.error instanceof Error ? optionsQuery.error.message : 'No IPP candidates.'} retry={() => void optionsQuery.refetch()} /></AppShell>;
  if (!optionsQuery.data?.length) return <AppShell><PageHeader eyebrow="DECISION WORKSPACE" title="IPP comparator" description="Compare each IPP with this GES requirement." /><div className="empty-state"><span>No IPP candidates are currently associated with this GES.</span></div></AppShell>;
  if (query.error || !data) return <AppShell><ErrorState message={query.error instanceof Error ? query.error.message : 'No comparison data.'} retry={() => void query.refetch()} /></AppShell>;

  const focusedFactor = focus?.evaluation.parameters.find((item) => item.key === factorKey);
  const selectedColors = data.selectedIpps.map((provider) => ({
    id: provider.ipp.id,
    name: provider.ipp.name,
    color: CHART_COLORS[data.selectedIpps.findIndex((item) => item.ipp.id === provider.ipp.id) % CHART_COLORS.length],
  }));

  return (
    <AppShell>
      <PageHeader
        eyebrow={`DECISION WORKSPACE · ${data.ges.code}`}
        title="IPP comparator"
        description="Compare each IPP with this GES requirement. Requirement match, checks, and shortlist status stay separate."
      >
        <button className="secondary-button" onClick={exportCsv}><Download size={14} /> Export comparison</button>
        {canEditRequirement && <button className="primary-button" onClick={() => setDrawer('requirements')}><Pencil size={13} /> Edit requirements</button>}
      </PageHeader>

      <div className="comparison-toolbar">
        <div className="requirement-summary">
          <div className="summary-item"><strong>{fmt(data.requirements.annualEnergyGwh)}</strong><span>GWh annual</span></div>
          <div className="summary-item"><strong>{fmt(data.requirements.peakDemandMw)}</strong><span>MW peak</span></div>
          <div className="summary-item"><strong>{data.requirements.requiredCapacityGw} GW</strong><span>planning capacity</span></div>
          <div className="summary-item"><strong>{data.requirements.targetCodYear > 0 ? data.requirements.targetCodYear : '—'}</strong><span>target supply start</span></div>
          <div className="summary-item"><strong>{data.requirements.renewableTargetPercent != null ? `${data.requirements.renewableTargetPercent}%` : data.ges.renewableEnergyTargetPercent != null ? `${data.ges.renewableEnergyTargetPercent}%` : '—'}</strong><span>renewable target</span></div>
          <div className="summary-item"><strong>{data.requirements.targetTariffInrPerKwh != null ? `₹${data.requirements.targetTariffInrPerKwh.toFixed(2)}` : '—'}</strong><span>target tariff</span></div>
        </div>
        <div className="selection-count"><Sparkles size={12} /> {data.selectedIpps.length} / 3 providers in view</div>
      </div>

      {focus && (
        <section className="card" style={{ marginBottom: 14 }}>
          <div className="card-head">
            <div>
              <h2 className="card-title">IPP evaluation <InfoTooltip term="IPP Evaluation" /></h2>
              <p className="card-subtitle">{focus.ipp.name}{focus.ipp.register?.projectName ? ` · ${focus.ipp.register.projectName}` : ''}</p>
            </div>
            <label className="focus-select"><span>Focus</span><select value={focus.ipp.id} onChange={(event) => setFocusId(event.target.value)}>{data.selectedIpps.map((item) => <option key={item.ipp.id} value={item.ipp.id}>{item.ipp.name}</option>)}</select><ChevronDown size={12} /></label>
          </div>
          <div className="card-body">
            <div className="ges-profile-metrics">
              <span><small>Requirement match <InfoTooltip term="Requirement Match" /></small><strong>{focus.suitability.overallPct}%</strong></span>
              <span><small>Evaluation status</small><strong>{focus.evaluation.overallScore ? 'Evaluated' : 'No evaluation has been started.'}</strong></span>
              <span><small>Required checks <InfoTooltip term="Required Checks" /></small><strong>{focus.shortlistEligibility ? `${focus.shortlistEligibility.passed} / ${focus.gates.length} pass` : '—'}</strong></span>
              <span><small>Shortlist eligibility <InfoTooltip term="Shortlist" /></small><strong>{focus.shortlistEligibility ? <StatusPill status={focus.shortlistEligibility.status} /> : '—'}</strong></span>
              <span><small>Shortlist</small><strong>{focus.ipp.shortlisted ? 'Shortlisted' : 'Not shortlisted'}</strong></span>
            </div>
            <div className="section-spacer" />
            <div className="activity-list">
              {(focus.requirementComparison ?? []).filter((row) => row.status === 'PASS').slice(0, 3).map((row) => <div className="activity-item" key={row.key}><span className="activity-dot" /><div className="activity-copy"><strong>{row.name}</strong><small>{row.ippValue}</small></div></div>)}
              {(focus.requirementComparison ?? []).filter((row) => row.status === 'PENDING' || row.status === 'FAIL').slice(0, 2).map((row) => <div className="activity-item" key={row.key}><AlertTriangle size={12} /><div className="activity-copy"><strong>{row.name}</strong><small>{row.evidence}</small></div></div>)}
            </div>
            <div className="section-spacer" />
            {canShortlist && !focus.ipp.shortlisted && (
              <button className="primary-button" disabled={focus.shortlistEligibility?.status !== 'ELIGIBLE'} onClick={() => setShortlistIntent({ ippId: focus.ipp.id, shortlisted: true })}>Add to Shortlist</button>
            )}
            {canShortlist && focus.ipp.shortlisted && (
              <button className="secondary-button" onClick={() => setShortlistIntent({ ippId: focus.ipp.id, shortlisted: false })}>Remove from Shortlist</button>
            )}
            {!canShortlist && <p className="card-subtitle">Shortlist changes require commercial review permission.</p>}
            {canShortlist && !focus.ipp.shortlisted && focus.shortlistEligibility?.status !== 'ELIGIBLE' && <p className="card-subtitle">Shortlisting stays closed until blocking required checks pass.</p>}
          </div>
        </section>
      )}

      <section className="card comparison-main">
        <div className="card-head">
          <div><h2 className="card-title">Provider selection</h2><p className="card-subtitle">Select up to three. The server recalculates each consumer-provider relationship.</p></div>
          <span className="tiny-label">GES ↔ IPP EVALUATIONS</span>
        </div>
        <div className="card-body">
          <div className="provider-row header"><span>Provider</span><span>Technology</span><span>Requirement match</span><span>Required check</span></div>
          {data.providerOptions.map((provider) => {
            const row = data.comparisonTable.find((item) => item.id === provider.id);
            return (
              <div className="provider-row" key={provider.id}>
                <label className="provider-name"><input type="checkbox" checked={selectedIds.includes(provider.id)} onChange={() => toggleProvider(provider.id)} /><span>{provider.name}</span></label>
                <div className="tag-list">{provider.technology.map((tech) => <span key={tech} className="tech-tag">{tech}</span>)}</div>
                <div className="metric-score"><span className="score-ring">{provider.suitability}</span><span>%</span></div>
                <StatusPill status={row?.criticalGate ?? '—'} />
              </div>
            );
          })}
          <div className="selector-help">Requirement match is recalculated for this GES.</div>
        </div>
      </section>

      <div className="content-grid">
        <section className="card">
          <div className="card-head">          <div><h2 className="card-title">Capability profile</h2><p className="card-subtitle">Independent IPP evaluation score · normalized 0–100 · 10 weighted factors.</p></div><div className="chart-actions">{canEditIpp && <button className="small-button" onClick={() => setDrawer('technical')}><Pencil size={11} /> Edit provider inputs</button>}<StatusPill status="Evaluation score" /></div></div>
          <div className="card-body">
            <div className="chart-wrap">
              <ResponsiveContainer width="100%" height="100%">
                <RadarChart data={data.radarData} outerRadius="73%">
                  <PolarGrid stroke={CHART_THEME.grid} />
                  <PolarAngleAxis dataKey="factor" tick={{ fill: CHART_THEME.tick, fontSize: 9 }} />
                  <PolarRadiusAxis angle={90} domain={[0, 100]} tick={{ fill: CHART_THEME.tickSoft, fontSize: 7 }} axisLine={false} tickCount={5} />
                  {selectedColors.map((entry) => <Radar key={entry.id} name={entry.name} dataKey={entry.id} stroke={entry.color} fill={entry.color} fillOpacity={0.11} strokeWidth={2} />)}
                  <Tooltip content={<RadarTip providers={data.selectedIpps} />} />
                </RadarChart>
              </ResponsiveContainer>
            </div>
            <div className="chart-legend">{selectedColors.map((entry) => <span className="legend-item" key={entry.id}><i className="legend-line" style={{ background: entry.color }} />{entry.name}</span>)}</div>
          </div>
          <div className="factor-list">
            {focus?.evaluation.parameters.map((factor) => <button key={factor.key} className="factor-button" onClick={() => { setFactorKey(factor.key); setDrawer('factor'); }}>{factor.shortLabel}</button>)}
          </div>
        </section>
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Requirement match</h2><p className="card-subtitle">Annual supply and interval-matched energy are distinct measures.</p></div><button className="icon-button" onClick={() => void query.refetch()} aria-label="Refresh calculations"><RefreshCw size={14} /></button></div>
          <div className="card-body">
            <div className="chart-wrap short">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart
                  data={focus ? [
                    { label: 'GES required', value: focus.loadMatch.requiredGwh, fill: '#7f93ab' },
                    { label: 'IPP available', value: focus.loadMatch.availableGwh, fill: '#5ec8b8' },
                    { label: 'Matched', value: focus.loadMatch.matchedGwh, fill: '#2ad4c2' },
                    { label: 'Surplus', value: focus.loadMatch.surplusGwh, fill: '#e0a45a' },
                    { label: 'Deficit', value: focus.loadMatch.deficitGwh, fill: '#e08a80' },
                  ] : []}
                  layout="vertical" margin={{ left: 13, right: 18, top: 5, bottom: 5 }}
                >
                  <CartesianGrid stroke={CHART_THEME.grid} horizontal={false} />
                  <XAxis type="number" tick={{ fill: CHART_THEME.tick, fontSize: 8 }} axisLine={false} tickLine={false} />
                  <YAxis type="category" dataKey="label" width={75} tick={{ fill: CHART_THEME.tick, fontSize: 8 }} axisLine={false} tickLine={false} />
                  <Tooltip formatter={(value) => [`${fmt(Number(value))} GWh`, 'Energy']} contentStyle={CHART_THEME.tooltip} />
                  <Bar dataKey="value" radius={[0, 4, 4, 0]} barSize={13}>{[
                    { fill: '#7f93ab' }, { fill: '#5ec8b8' }, { fill: '#2ad4c2' }, { fill: '#e0a45a' }, { fill: '#e08a80' },
                  ].map((item, index) => <Cell key={index} fill={item.fill} />)}</Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>
            {focus && <div className="match-stat-row"><span>Coverage <strong>{focus.loadMatch.coveragePct}%</strong></span><span>Load match <strong>{focus.loadMatch.loadMatchPct}%</strong></span><span>IPP available <strong>{fmt(focus.loadMatch.availableGwh)} GWh</strong></span><span>P90 <strong>{focus.ipp.p90Gwh > 0 ? `${fmt(focus.ipp.p90Gwh)} GWh` : 'P90 generation data is not available'}</strong></span></div>}
            {focus && !focus.loadMatch.intervals.length && <div className="empty-state"><span>Load profile data is required to calculate interval-level load matching.</span></div>}
            {focus && focus.loadMatch.intervals.length > 0 && <p className="card-subtitle">Interval series provenance: DEMO / ILLUSTRATIVE.</p>}
            <div className="match-stat-row">
              <span>Consumption <strong>{data.ges.annualConsumptionGwh != null ? `${fmt(data.ges.annualConsumptionGwh, 3)} GWh` : 'Not specified'}</strong></span>
              <span>Existing rooftop <strong>{data.ges.existingRooftopMw != null ? `${fmt(data.ges.existingRooftopMw * 1000)} kW` : 'Not specified'}</strong></span>
              <span>Existing renewable <strong>{data.ges.existingRenewableGwh != null ? `${fmt(data.ges.existingRenewableGwh, 3)} GWh` : 'Not specified'}</strong></span>
              <span>BESS preference <strong>{bessLabel(data.ges.bessRequirement, data.requirements.bessPreference)}</strong></span>
            </div>
          </div>
        </section>
      </div>

      <section className="card" style={{ marginBottom: 14 }}>
          <div className="card-head"><div><h2 className="card-title">Technology portfolio</h2><p className="card-subtitle">Installed solar, wind, and battery power across the provider pool.</p></div><span className="tiny-label">MW</span></div>
          <div className="card-body">
            <div className="chart-wrap">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={data.technologyMix} margin={{ top: 8, right: 8, left: -20, bottom: 0 }}>
                  <CartesianGrid stroke={CHART_THEME.grid} vertical={false} />
                  <XAxis dataKey="code" tick={{ fill: CHART_THEME.tick, fontSize: 8 }} axisLine={false} tickLine={false} />
                  <YAxis tick={{ fill: CHART_THEME.tick, fontSize: 8 }} axisLine={false} tickLine={false} />
                  <Tooltip labelFormatter={(_, payload) => payload?.[0]?.payload?.name ?? ''} contentStyle={CHART_THEME.tooltip} />
                  <Legend wrapperStyle={{ fontSize: 8, color: CHART_THEME.tick }} />
                  <Bar dataKey="solarMw" name="Solar" stackId="mix" fill="#e0a45a" />
                  <Bar dataKey="windMw" name="Wind" stackId="mix" fill="#2ad4c2" />
                  <Bar dataKey="bessMw" name="BESS" stackId="mix" fill="#7aa2e8" radius={[3, 3, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
        </section>

      <div className="content-grid equal">
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Required checks <InfoTooltip term="Required Checks" /></h2><p className="card-subtitle">{focus?.ipp.name} · a failed check blocks shortlisting. A conditional result stays in review.</p></div><label className="focus-select"><span>Focus</span><select value={focus?.ipp.id} onChange={(event) => setFocusId(event.target.value)}>{data.selectedIpps.map((item) => <option key={item.ipp.id} value={item.ipp.id}>{item.ipp.name}</option>)}</select><ChevronDown size={12} /></label></div>
          <div className="card-body gate-list">
            {focus?.gates.map((gate) => <div className="gate-row" key={gate.name}><span className={`gate-marker ${gate.status.toLowerCase()}`} /><span><strong>{gate.name}</strong><small>{gate.rationale} · Blocking: {gate.blocking === false ? 'No' : 'Yes'}</small></span><StatusPill status={gate.status} /></div>)}
            {!focus?.gates.length && <div className="empty-state"><span>No required checks are stored for this IPP.</span></div>}
          </div>
        </section>
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Issues / attention required</h2><p className="card-subtitle">Separate from missing information. {focus?.ipp.name}</p></div><span className="status-pill status-warn">{focus?.redFlags.length} open</span></div>
          <div className="card-body">
            {focus?.redFlags.length ? focus.redFlags.map((flag) => <div className="flag-card" key={`${flag.title}-${flag.category}`}><span className="flag-severity">{flag.severity}</span><span><strong>{flag.title}</strong><small>{flag.detail}</small></span></div>) : <div className="empty-state"><Check size={19} /><div><strong>No active red flags</strong><span>Continue validating supporting evidence.</span></div></div>}
          </div>
        </section>
      </div>

      <section className="card table-card">
        <div className="table-toolbar">
          <div><h2 className="card-title">Commercial comparison</h2><p className="card-subtitle">All {data.comparisonTable.length} linked providers are recalculated for the selected requirement.</p></div>
          <div className="table-actions">
            <label className="search-field"><FileSearch size={13} /><input value={search} onChange={(event) => setSearch(event.target.value)} placeholder="Search provider" aria-label="Search providers" /></label>
            <select className="filter-select" value={sortKey} onChange={(event) => setSortKey(event.target.value)} aria-label="Sort providers">
              <option value="suitability">Sort: Requirement match</option><option value="evaluationScore">Sort: Evaluation</option><option value="tariff">Sort: Tariff</option><option value="targetCodYear">Sort: COD</option><option value="annualGenerationGwh">Sort: Generation</option>
            </select>
            <button className="secondary-button" onClick={exportCsv}><ArrowDownToLine size={13} /> CSV</button>
          </div>
        </div>
        <div className="data-table-wrap">
          <table className="data-table">
            <thead><tr><th>IPP</th><th>Technology</th><th>Capacity</th><th>Generation / P90 <InfoTooltip term="P90" /></th><th>BESS <InfoTooltip term="BESS" /></th><th>Tariff</th><th>COD <InfoTooltip term="COD" /></th><th>Evaluation</th><th>Requirement match <InfoTooltip term="Requirement Match" /></th><th>Load match</th><th>Required check</th><th>Issues</th></tr></thead>
            <tbody>{filteredRows.map((row) => <tr key={row.id}>
              <td><strong>{row.name}</strong></td><td><div className="tag-list">{row.technology.split(' + ').map((item) => <span className="tech-tag" key={item}>{item}</span>)}</div></td>
              <td>{fmt(row.capacityMw)} MW</td><td><span className="number-main">{fmt(row.annualGenerationGwh)} GWh</span><span className="number-sub">P90 {fmt(row.p90Gwh)} GWh</span></td>
              <td>{row.bessMw ? `${fmt(row.bessMw)} MW` : '—'}<span className="number-sub">{row.bessMwh ? `${fmt(row.bessMwh)} MWh` : ''}</span></td>
              <td><strong>₹{row.tariff.toFixed(2)}</strong><span className="number-sub">/kWh</span></td><td>{row.targetCodYear}</td><td>{row.evaluationScore}</td>
              <td className="progress-cell"><span className="number-main">{row.suitability}%</span><div className="progress-line"><span style={{ width: `${row.suitability}%` }} /></div></td>
              <td>{row.loadMatchPct}%</td><td><StatusPill status={row.criticalGate} /></td><td>{row.riskCount}</td>
            </tr>)}</tbody>
          </table>
          {!filteredRows.length && <div className="empty-state"><span>No IPP candidates are currently associated with this GES.</span></div>}
        </div>
      </section>

      {focus && (
        <section className="card table-card">
          <div className="card-head"><div><h2 className="card-title">GES requirement and IPP comparison</h2><p className="card-subtitle">{focus.ipp.name} · factor results come from the stored evaluation. Weights are the configured requirement-match weights.</p></div></div>
          <div className="data-table-wrap">
            <table className="data-table">
              <thead><tr><th>Factor</th><th>GES requirement</th><th>IPP value</th><th>Result</th><th>Weight</th><th>Evidence</th></tr></thead>
              <tbody>
                {(focus.requirementComparison ?? []).map((row) => (
                  <tr key={row.key}>
                    <td><strong>{row.name}</strong>{row.term ? <InfoTooltip term={row.term} /> : null}</td>
                    <td>{row.gesValue}</td>
                    <td>{row.ippValue}</td>
                    <td><StatusPill status={row.status} /></td>
                    <td>{row.weight}%</td>
                    <td>{row.evidence}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            {!focus.requirementComparison?.length && <div className="empty-state"><span>No evaluation has been started.</span></div>}
          </div>
          <div className="card-body">
            <h3 className="card-title">Information completeness</h3>
            <p className="card-subtitle">Missing information is not the same as a weak project.</p>
            {focus.documents.length ? focus.documents.map((document) => (
              <div className="gate-row" key={document.id}><span><strong>{document.title}</strong><small>{document.category}</small></span><StatusPill status={document.status} /></div>
            )) : <div className="empty-state"><span>No documents are stored for this IPP.</span></div>}
            <div className="match-stat-row">
              <span>FDRE <InfoTooltip term="FDRE" /> <strong>{focus.ipp.register?.fdreCapability || 'Not specified'}</strong></span>
              <span>15-minute generation <strong>{focus.ipp.register?.generationData15Min || 'Not specified'}</strong></span>
              <span>Grid voltage <InfoTooltip term="EHV" /> <strong>{focus.ipp.register?.gridVoltage || 'Not specified'}</strong></span>
              <span>Open access <InfoTooltip term="Open Access" /> <strong>{focus.ipp.register?.openAccessReadiness || 'Not specified'}</strong></span>
              {canReviewTariff && <span>CAPEX <InfoTooltip term="CAPEX" /> <strong>{focus.ipp.register?.estimatedCapexCr != null ? `₹${fmt(focus.ipp.register.estimatedCapexCr)} crore` : focus.ipp.capexInrCr > 0 ? `₹${fmt(focus.ipp.capexInrCr)} crore` : 'Not specified'}</strong></span>}
            </div>
            <p className="card-subtitle">No GES commercial threshold has been configured. Tariff fit uses the platform band already stored in the evaluation.</p>
          </div>
        </section>
      )}

      {canReviewTariff && <section className="card tariff-card">
        <div className="card-head"><div><h2 className="card-title">Tariff sensitivity</h2><p className="card-subtitle">Server-calculated downside scenarios · demo assumptions only.</p></div><span className="tiny-label">FOCUS: {focus?.ipp.code}</span></div>
        <div className="card-body">
          <div className="scenario-columns">
            <div>
              {([
                ['CAPEX increase (%)', 'capexChangePct', -50, 50],
                ['Interest rate (+ points)', 'interestChangePct', -5, 5],
                ['COD delay (months)', 'codDelayMonths', 0, 36],
                ['Generation / CUF reduction (%)', 'cufReductionPct', 0, 40],
                ['Storage cost increase (%)', 'bessCostChangePct', -50, 100],
              ] as const).map(([label, key, min, max]) => (
                <label className="scenario-row" key={key}>{label}<input type="number" min={min} max={max} value={scenario[key]} onChange={(event) => setScenario((current) => ({ ...current, [key]: Number(event.target.value) }))} /></label>
              ))}
              <button className="primary-button" onClick={() => focus && scenarioMutation.mutate({ ippId: focus.ipp.id, body: scenario })} disabled={scenarioMutation.isPending || !focus}><SlidersHorizontal size={13} /> {scenarioMutation.isPending ? 'Recalculating…' : 'Apply scenario'}</button>
            </div>
            <div className="tariff-scenario-chart">
              {focus && <div className="tariff-readout"><span>Base tariff <strong>₹{focus.tariff.baseTariff.toFixed(2)}</strong></span><ArrowRight size={16} /><span>Scenario tariff <strong>₹{focus.tariff.scenarioTariff.toFixed(2)}<small> /kWh</small></strong></span><span>Base DSCR <strong>{focus.tariff.baseDscr.toFixed(2)}x</strong></span><span>Scenario DSCR <strong>{focus.tariff.scenarioDscr.toFixed(2)}x</strong></span></div>}
              <div className="chart-wrap short">
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={focus?.tariff.buildUp ?? []} margin={{ top: 10, right: 8, left: -18, bottom: 0 }}>
                    <CartesianGrid stroke={CHART_THEME.grid} vertical={false} />
                    <XAxis dataKey="label" interval={0} angle={-17} textAnchor="end" height={44} tick={{ fill: CHART_THEME.tick, fontSize: 7 }} axisLine={false} tickLine={false} />
                    <YAxis tick={{ fill: CHART_THEME.tick, fontSize: 8 }} axisLine={false} tickLine={false} />
                    <Tooltip formatter={(value) => [`₹${Number(value).toFixed(2)}/kWh`, 'Component']} contentStyle={CHART_THEME.tooltip} />
                    <Bar dataKey="amount" fill="#2ad4c2" radius={[3,3,0,0]} />
                  </BarChart>
                </ResponsiveContainer>
              </div>
            </div>
          </div>
        </div>
      </section>}

      {shortlistIntent && focus && (
        <div className="modal-backdrop" role="presentation" onMouseDown={() => { if (!shortlistMutation.isPending) setShortlistIntent(null); }}>
          <div className="confirm-modal" role="dialog" aria-modal="true" aria-labelledby="shortlist-title" onMouseDown={(event) => event.stopPropagation()}>
            <h3 id="shortlist-title">{shortlistIntent.shortlisted ? 'Add to Shortlist' : 'Remove from Shortlist'}</h3>
            <p>{focus.ipp.name}<br />Requirement match: {focus.suitability.overallPct}%<br />Required checks: {focus.shortlistEligibility ? `${focus.shortlistEligibility.passed}/${focus.gates.length} pass` : '—'}<br />Blocking issues: {focus.shortlistEligibility?.blockingIssues ?? '—'}<br />This records the workflow change. It does not change the requirement match.</p>
            <div className="card-tools" style={{ justifyContent: 'flex-end' }}>
              <button className="secondary-button" type="button" onClick={() => setShortlistIntent(null)} disabled={shortlistMutation.isPending}>Cancel</button>
              <button className="primary-button" type="button" disabled={shortlistMutation.isPending} onClick={() => shortlistMutation.mutate(shortlistIntent)}>{shortlistMutation.isPending ? 'Saving…' : shortlistIntent.shortlisted ? 'Add to Shortlist' : 'Remove from Shortlist'}</button>
            </div>
          </div>
        </div>
      )}
      {drawer === 'requirements' && <Drawer title="Edit GES requirement" onClose={() => setDrawer(null)}><RequirementForm requirement={data.requirements} saving={requirementMutation.isPending} onSave={(body) => requirementMutation.mutate(body)} /></Drawer>}
      {drawer === 'technical' && focus && <Drawer title={`Update ${focus.ipp.name}`} onClose={() => setDrawer(null)}><IppInputForm provider={focus} saving={inputMutation.isPending} onSave={(body) => inputMutation.mutate({ ippId: focus.ipp.id, body })} /></Drawer>}
      {drawer === 'factor' && focusedFactor && focus && <Drawer title={focusedFactor.label} onClose={() => setDrawer(null)}>
        <div className="drawer-metric"><span>Provider</span><strong>{focus.ipp.name}</strong></div>
        <div className="drawer-metric"><span>Rating</span><strong>{focusedFactor.score.toFixed(1)} / 5</strong></div>
        <div className="drawer-metric"><span>Normalized</span><strong>{focusedFactor.normalizedScore} / 100</strong></div>
        <div className="drawer-metric"><span>Weight</span><strong>{focusedFactor.weight}</strong></div>
        <div className="drawer-metric"><span>Weighted contribution</span><strong>{focusedFactor.weightedContribution} / {focusedFactor.weight}</strong></div>
        <div className="drawer-metric"><span>Status</span><StatusPill status={focusedFactor.status} /></div>
        <div className="drawer-metric"><span>Reviewer</span><strong>{focusedFactor.reviewer}</strong></div>
        <div className="factor-evidence"><strong>Evidence</strong><br />{focusedFactor.evidence}<br /><br />Evidence status influences confidence. Confirm source material before advancing a gate.</div>
        <div className="divider" />
        {canEditIpp && <button className="secondary-button" onClick={() => setDrawer('technical')}><Pencil size={13} /> Edit provider inputs</button>}
      </Drawer>}
    </AppShell>
  );
}

function RequirementForm({ requirement, saving, onSave }: {
  requirement: GesRequirement;
  saving: boolean;
  onSave: (body: Partial<GesRequirement>) => void;
}) {
  const [draft, setDraft] = useState({
    annualEnergyGwh: requirement.annualEnergyGwh,
    peakDemandMw: requirement.peakDemandMw,
    requiredCapacityGw: requirement.requiredCapacityGw,
    targetCodYear: requirement.targetCodYear,
    bessPreference: requirement.bessPreference,
    preferredTechnologies: requirement.preferredTechnologies.join(', '),
  });
  function submit(event: FormEvent) {
    event.preventDefault();
    onSave({
      annualEnergyGwh: Number(draft.annualEnergyGwh),
      peakDemandMw: Number(draft.peakDemandMw),
      requiredCapacityGw: Number(draft.requiredCapacityGw),
      targetCodYear: Number(draft.targetCodYear),
      bessPreference: draft.bessPreference,
      bessHoursMin: draft.bessPreference === 'HOURS_4' ? 4 : draft.bessPreference === 'HOURS_2_TO_4' ? 2 : null,
      bessHoursMax: draft.bessPreference === 'HOURS_4' ? 4 : draft.bessPreference === 'HOURS_2_TO_4' ? 4 : null,
      preferredTechnologies: draft.preferredTechnologies.split(',').map((item) => item.trim()).filter(Boolean),
    });
  }
  return (
    <form onSubmit={submit}>
      <div className="alert-strip"><Info size={14} /> Saving sends the new assumptions to the API. Requirement match is recalculated on the server.</div>
      <div className="form-grid">
        <label className="form-field">Annual energy (GWh)<input type="number" min="250" max="10000" value={draft.annualEnergyGwh} onChange={(event) => setDraft({ ...draft, annualEnergyGwh: Number(event.target.value) })} required /></label>
        <label className="form-field">Peak demand (MW)<input type="number" min="10" max="2000" value={draft.peakDemandMw} onChange={(event) => setDraft({ ...draft, peakDemandMw: Number(event.target.value) })} required /></label>
        <label className="form-field">Capacity plan (GW)<input type="number" min="0.1" max="20" step="0.1" value={draft.requiredCapacityGw} onChange={(event) => setDraft({ ...draft, requiredCapacityGw: Number(event.target.value) })} required /></label>
        <label className="form-field">Target COD year<input type="number" min="2026" max="2040" value={draft.targetCodYear} onChange={(event) => setDraft({ ...draft, targetCodYear: Number(event.target.value) })} required /></label>
        <label className="form-field">Storage preference<select value={draft.bessPreference} onChange={(event) => setDraft({ ...draft, bessPreference: event.target.value as typeof draft.bessPreference })}><option value="OPTIONAL">Optional</option><option value="HOURS_2_TO_4">2–4 hours</option><option value="HOURS_4">4 hours</option></select></label>
        <label className="form-field">Technology preference<input value={draft.preferredTechnologies} onChange={(event) => setDraft({ ...draft, preferredTechnologies: event.target.value })} placeholder="Solar, Wind, BESS" /></label>
      </div>
      <div className="divider" />
      <button className="primary-button" type="submit" disabled={saving}>{saving ? 'Recalculating…' : 'Save and recalculate'} <ArrowRight size={14} /></button>
    </form>
  );
}

function IppInputForm({ provider, saving, onSave }: {
  provider: ComparisonProvider;
  saving: boolean;
  onSave: (body: Record<string, number>) => void;
}) {
  const [draft, setDraft] = useState({
    p90Gwh: provider.ipp.p90Gwh,
    bessMw: provider.ipp.bessMw,
    bessMwh: provider.ipp.bessMwh,
    bessDurationHours: provider.ipp.bessDurationHours,
    tariff: provider.ipp.tariff,
    capexInrCr: provider.ipp.capexInrCr,
    interestRate: provider.ipp.interestRate,
    dscr: provider.ipp.dscr,
  });
  function submit(event: FormEvent) {
    event.preventDefault();
    const { dscr: _calculatedDscr, ...inputs } = draft;
    onSave(Object.fromEntries(Object.entries(inputs).map(([key, value]) => [key, Number(value)])));
  }
  return (
    <form onSubmit={submit}>
      <div className="alert-strip"><Info size={14} /> Provider engineering and finance inputs are validated by the backend.</div>
      <div className="form-grid">
        <label className="form-field">P90 generation (GWh)<input type="number" min="0" value={draft.p90Gwh} onChange={(event) => setDraft({ ...draft, p90Gwh: Number(event.target.value) })} /></label>
        <label className="form-field">Tariff (₹/kWh)<input type="number" min="0.1" step="0.01" value={draft.tariff} onChange={(event) => setDraft({ ...draft, tariff: Number(event.target.value) })} /></label>
        <label className="form-field">BESS power (MW)<input type="number" min="0" value={draft.bessMw} onChange={(event) => setDraft({ ...draft, bessMw: Number(event.target.value) })} /></label>
        <label className="form-field">BESS energy (MWh)<input type="number" min="0" value={draft.bessMwh} onChange={(event) => setDraft({ ...draft, bessMwh: Number(event.target.value) })} /></label>
        <label className="form-field">Duration (hours)<input type="number" min="0" max="10" step="0.5" value={draft.bessDurationHours} onChange={(event) => setDraft({ ...draft, bessDurationHours: Number(event.target.value) })} /></label>
        <label className="form-field">CAPEX (INR cr)<input type="number" min="0" value={draft.capexInrCr} onChange={(event) => setDraft({ ...draft, capexInrCr: Number(event.target.value) })} /></label>
        <label className="form-field">Interest rate (%)<input type="number" min="0" max="30" step="0.1" value={draft.interestRate} onChange={(event) => setDraft({ ...draft, interestRate: Number(event.target.value) })} /></label>
        <label className="form-field">DSCR (x, calculated) <InfoTooltip term="DSCR" /><input type="number" value={draft.dscr} readOnly /></label>
      </div>
      <div className="divider" />
      <button className="primary-button" type="submit" disabled={saving}>{saving ? 'Recalculating…' : 'Update and recalculate'} <ArrowRight size={14} /></button>
    </form>
  );
}
