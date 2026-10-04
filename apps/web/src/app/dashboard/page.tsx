'use client';

import Link from 'next/link';
import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import {
  ArrowRight,
  ArrowUpRight,
  AlertOctagon,
  BriefcaseBusiness,
  CheckCircle2,
  Clock3,
  FileClock,
  Gauge,
  Leaf,
  Zap,
} from 'lucide-react';
import { AppShell, PageHeader } from '../../components/AppShell';
import { ErrorState, LoadingState } from '../../components/DataState';
import { StatusPill } from '../../components/StatusPill';
import { InfoTooltip } from '../../features/terms/InfoTooltip';
import { bessLabel } from '../../features/ges/options';
import { api } from '../../services/api';
import { DashboardResponse, GesAccount } from '../../types/api';
import { useWorkspace } from '../../features/workspace/WorkspaceProvider';

const number = (value: number) => value.toLocaleString('en-IN');

function requiredRenewable(ges: GesAccount) {
  const consumption = ges.annualConsumptionGwh;
  const target = ges.renewableEnergyTargetPercent;
  if (consumption == null || target == null) return null;
  return Number((consumption * (target / 100)).toFixed(3));
}

function RequirementSummary({ ges }: { ges: GesAccount }) {
  const renewable = requiredRenewable(ges);
  const peak = ges.peakRecordedDemandKva != null
    ? `${number(ges.peakRecordedDemandKva)} kVA`
    : ges.requirement.peakDemandMw
      ? `${number(ges.requirement.peakDemandMw * 1000)} kVA`
      : 'Not specified';
  const items = [
    {
      key: 'consumption',
      label: 'Annual consumption',
      value: ges.annualConsumptionGwh != null ? `${number(ges.annualConsumptionGwh)} GWh` : 'Not specified',
      source: ges.annualConsumptionGwh != null ? 'Stored electricity profile' : 'Data required',
      detail: ges.annualConsumptionGwh != null
        ? 'This is the GES annual electricity consumption. It is the starting point for the renewable requirement and is kept separate from existing renewable generation.'
        : 'Annual consumption is required before the renewable requirement can be calculated.',
    },
    {
      key: 'target',
      label: 'Renewable target',
      value: ges.renewableEnergyTargetPercent != null ? `${ges.renewableEnergyTargetPercent}%` : 'Not specified',
      source: ges.renewableEnergyTargetPercent != null ? 'Stored procurement preference' : 'Not configured',
      detail: ges.renewableEnergyTargetPercent != null
        ? 'The target percentage is applied to annual consumption. A missing target leaves required renewable energy unspecified.'
        : 'Set a renewable energy target on the GES record to calculate the procurement requirement.',
    },
    {
      key: 'required',
      label: 'Required renewable energy',
      value: renewable != null ? `${number(renewable)} GWh` : 'Not specified',
      source: renewable != null ? 'Calculated from consumption and target' : 'Not configured',
      detail: renewable != null
        ? `${number(ges.annualConsumptionGwh ?? 0)} GWh consumption × ${ges.renewableEnergyTargetPercent}% target. Existing rooftop solar is ${ges.existingRooftopMw != null ? `${number(ges.existingRooftopMw * 1000)} kW` : 'not specified'} and existing renewable generation is ${ges.existingRenewableGwh != null ? `${number(ges.existingRenewableGwh)} GWh` : 'not specified'}. Those figures stay on their own lines.`
        : 'Required renewable energy is calculated only when both annual consumption and the renewable target are stored.',
    },
    {
      key: 'peak',
      label: 'Peak demand',
      value: peak,
      source: ges.peakRecordedDemandKva != null ? 'Stored peak recorded demand' : ges.requirement.peakDemandMw ? 'Stored peak demand' : 'Data required',
      detail: 'Peak demand is the highest recorded demand on the GES record. It is shown in kVA and is separate from annual energy.',
    },
    {
      key: 'contract',
      label: 'Contract demand',
      value: ges.contractDemandMw != null ? `${number(ges.contractDemandMw * 1000)} kVA` : 'Not specified',
      source: ges.contractDemandMw != null ? 'Stored contract demand' : 'Data required',
      detail: 'Contract demand is the demand agreed with the distribution company. It is not used as a substitute for the renewable energy requirement.',
    },
    {
      key: 'rooftop',
      label: 'Rooftop solar',
      value: ges.existingRooftopMw != null ? `${number(ges.existingRooftopMw * 1000)} kW` : 'Not specified',
      source: ges.existingRooftopMw != null ? 'Stored existing rooftop solar' : 'Data required',
      detail: 'Existing rooftop solar is already on the GES site. It is shown apart from the IPP procurement requirement so the same generation is not counted twice.',
    },
    {
      key: 'cod',
      label: 'Target supply start',
      term: 'COD',
      value: ges.requirement.targetCodYear > 0 ? String(ges.requirement.targetCodYear) : 'Not specified',
      source: ges.requirement.targetCodYear > 0 ? 'Stored target supply start year' : 'Not configured',
      detail: 'The IPP expected commercial operation year is compared with this year during evaluation.',
    },
    {
      key: 'technology',
      label: 'Technology',
      value: ges.requirement.preferredTechnologies.length ? ges.requirement.preferredTechnologies.join(', ') : 'Not configured',
      source: ges.requirement.preferredTechnologies.length ? 'Stored technology preference' : 'Not configured',
      detail: ges.requirement.preferredTechnologies.length
        ? 'Technology match uses this preference. An IPP is assessed against the technologies named here.'
        : 'Technology match stays unconfigured until a preference is stored.',
    },
    {
      key: 'bess',
      label: 'BESS preference',
      term: 'BESS',
      value: bessLabel(ges.bessRequirement, ges.requirement.bessPreference),
      source: ges.bessRequirement ? 'Stored BESS preference' : 'Stored evaluation preference',
      detail: 'Required storage is assessed against the IPP battery capacity. Preferred storage can support a match. When storage is not required, a project can still match without a battery.',
    },
  ];
  const [selectedKey, setSelectedKey] = useState('required');
  const selected = items.find((item) => item.key === selectedKey) ?? items[0];
  return (
    <section className="card requirement-card">
      <div className="card-head">
        <div>
          <h2 className="card-title">Requirement summary</h2>
          <p className="card-subtitle">{ges.name} · select a figure to see where it comes from.</p>
        </div>
        <Link href={`/ges/${ges.id}`} className="list-link">GES record <ArrowUpRight size={12} /></Link>
      </div>
      <div className="card-body">
        <div className="requirement-board" role="group" aria-label="GES requirement figures">
          {items.map((item) => (
            <button
              key={item.key}
              type="button"
              className="requirement-tile"
              aria-pressed={selected.key === item.key}
              aria-controls="requirement-detail"
              onClick={() => setSelectedKey(item.key)}
            >
              <small>{item.label}</small>
              <strong>{item.value}</strong>
            </button>
          ))}
        </div>
        <div className="requirement-detail" id="requirement-detail" role="region" aria-live="polite">
          <div>
            <span className="tiny-label">{selected.source}</span>
            <h3>{selected.label}{selected.term ? <InfoTooltip term={selected.term} /> : null}</h3>
            <strong>{selected.value}</strong>
            <p>{selected.detail}</p>
          </div>
          <Link className="secondary-button" href={`/ges/${ges.id}/comparison`}>Open comparator <ArrowRight size={14} /></Link>
        </div>
      </div>
    </section>
  );
}

function MetricCard({
  label,
  value,
  foot,
  icon: Icon,
  tone = 'green',
}: {
  label: string;
  value: string;
  foot: string;
  icon: typeof Zap;
  tone?: string;
}) {
  return (
    <div className="metric-card">
      <div className="metric-top"><span className="metric-label">{label}</span><span className={`metric-icon ${tone}`}><Icon size={14} /></span></div>
      <div className="metric-value">{value}</div>
      <div className="metric-foot">{foot}</div>
    </div>
  );
}

export default function DashboardPage() {
  const { gesId } = useWorkspace();
  const query = useQuery({
    queryKey: ['dashboard', gesId],
    queryFn: () => api.get<DashboardResponse>(`/dashboard?gesId=${gesId}`),
  });

  if (query.isLoading) return <AppShell><LoadingState /></AppShell>;
  if (query.error || !query.data) {
    return <AppShell><ErrorState message={query.error instanceof Error ? query.error.message : 'API unavailable.'} retry={() => void query.refetch()} /></AppShell>;
  }
  const data = query.data;
  return (
    <AppShell>
      <PageHeader
        eyebrow="SELECTED GES"
        title={data.selectedGes.name}
        description="Requirement, candidates, and checks for this GES. Requirement match is decision support, not an award."
      >
        <Link className="primary-button" href={`/ges/${gesId}/comparison`}>Open comparator <ArrowRight size={15} /></Link>
      </PageHeader>

      <div className="metric-grid">
        <MetricCard label="GES accounts" value={String(data.totals.gesAccounts).padStart(2, '0')} foot="Accounts you can access" icon={BriefcaseBusiness} />
        <MetricCard label="IPP candidates" value={String(data.totals.ippCandidates).padStart(2, '0')} foot="Linked to the selected GES" icon={Leaf} />
        <MetricCard label="Evaluated IPPs" value={number(data.totals.activeEvaluations)} foot="Stored evaluations for this GES" icon={Gauge} />
        <MetricCard label="Shortlisted IPPs" value={number(data.totals.shortlisted)} foot="Workflow status, not the highest match" icon={CheckCircle2} />
      </div>
      <div className="metric-grid">
        <MetricCard label="Pending checks" value={number(data.totals.pendingReviews)} foot="Documents still under review" icon={FileClock} tone="amber" />
        <MetricCard label="Pending actions" value={number(data.totals.pendingActions ?? 0)} foot="Open tasks for this GES" icon={Clock3} tone="amber" />
        <MetricCard label="Issues needing attention" value={number(data.totals.criticalRisks)} foot="High or critical items on this GES" icon={AlertOctagon} tone="red" />
        <MetricCard label="Average requirement match" value={data.keyMetrics.candidateCount ? `${data.keyMetrics.averageSuitability}%` : '—'} foot={`Across ${data.keyMetrics.candidateCount} linked IPPs`} icon={Zap} />
        <MetricCard label="Target supply start" value={data.keyMetrics.targetCodYear ? String(data.keyMetrics.targetCodYear) : 'Not specified'} foot={data.selectedGes.name} icon={Clock3} tone="blue" />
      </div>

      <RequirementSummary ges={data.selectedGes} />

      <div className="alert-strip"><AlertOctagon size={15} /> A high requirement match does not clear a failed required check, and it does not shortlist an IPP.</div>
      <div className="dashboard-grid">
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">GES requirements</h2><p className="card-subtitle">Select an account to set your evaluation context.</p></div><Link href="/ges" className="list-link">View all <ArrowUpRight size={12} /></Link></div>
          <div className="card-body data-table-wrap">
            <table className="ges-list">
              <thead><tr><th>GES account</th><th>Stored requirement</th><th>Peak</th><th>Supply start</th><th>Stage</th><th>Requirement match</th></tr></thead>
              <tbody>
                {data.ges.map((ges) => (
                  <tr key={ges.id}>
                    <td><div className="ges-name"><span className="ges-code">{ges.code.replace('GES ', '')}</span><span><strong>{ges.name}</strong><small>{ges.location} · {ges.businessType}</small></span></div></td>
                    <td>{number(ges.requirement.annualEnergyGwh)} GWh</td>
                    <td>{number(ges.requirement.peakDemandMw)} MW</td>
                    <td>{ges.requirement.targetCodYear > 0 ? ges.requirement.targetCodYear : 'Not specified'}</td>
                    <td><StatusPill status={ges.stage} /></td>
                    <td><strong>{ges.averageSuitability}%</strong></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </section>
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Next actions</h2><p className="card-subtitle">Tasks move independently from evaluation stage.</p></div><span className="tiny-label">OWNER · DUE DATE</span></div>
          <div className="card-body activity-list">
            {data.recentTasks.map((task) => (
              <div className="activity-item" key={task.id}>
                <span className="activity-dot" />
                <div className="activity-copy"><strong>{task.title}</strong><small>{task.owner} · due {task.dueDate}</small></div>
                <StatusPill status={task.status} />
              </div>
            ))}
            {!data.recentTasks.length && <div className="empty-state"><span>No open tasks.</span></div>}
          </div>
        </section>
      </div>
      <div className="section-spacer" />
      <section className="card compact-card">
        <div className="card-head"><div><h2 className="card-title">Continue your review</h2><p className="card-subtitle">The decision trail from requirement through evidence and approval.</p></div></div>
        <div className="card-body quick-links">
          <Link href={`/ges/${gesId}/comparison`}><span className="quick-icon"><Gauge size={15} /></span><span><strong>Compare providers</strong><small>Requirement match, load match, tariff, and required checks</small></span><ArrowRight size={14} /></Link>
          <Link href={`/ges/${gesId}/negotiation`}><span className="quick-icon orange"><ArrowUpRight size={15} /></span><span><strong>Negotiation history</strong><small>Versioned offers and counter-offers</small></span><ArrowRight size={14} /></Link>
          <Link href={`/ges/${gesId}/dealbook`}><span className="quick-icon blue"><CheckCircle2 size={15} /></span><span><strong>Decision dealbook</strong><small>One record of conditions, risks, and evidence</small></span><ArrowRight size={14} /></Link>
        </div>
      </section>
    </AppShell>
  );
}
