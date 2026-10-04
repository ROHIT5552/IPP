'use client';

import Link from 'next/link';
import { useParams } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { Pencil } from 'lucide-react';
import { AppShell, PageHeader } from '../../../components/AppShell';
import { ErrorState, LoadingState } from '../../../components/DataState';
import { useAuth } from '../../../features/auth/AuthProvider';
import { bessLabel, technologyLabel } from '../../../features/ges/options';
import { api } from '../../../services/api';
import { GesAccount } from '../../../types/api';

function amount(value: number | null | undefined, digits = 3) {
  if (value === null || value === undefined || Number.isNaN(value)) return '—';
  return value.toLocaleString('en-IN', { maximumFractionDigits: digits });
}

function text(value?: string | null) {
  return value?.trim() ? value : 'Not specified';
}

function Item({ label, value, badge }: { label: string; value: string; badge: string }) {
  return (
    <div className="info-item">
      <small>{label} <span className={`field-badge ${badge === 'Auto calculated' ? 'calculated' : badge === 'Customer input' ? 'customer' : ''}`}>{badge}</span></small>
      <strong>{value}</strong>
    </div>
  );
}

export default function GesDetailsPage() {
  const { gesId } = useParams<{ gesId: string }>();
  const { user } = useAuth();
  const canEdit = user?.permissions.includes('GES_EDIT') ?? false;
  const query = useQuery({ queryKey: ['ges'], queryFn: () => api.get<GesAccount[]>('/ges') });
  const ges = query.data?.find((item) => item.id === gesId);

  if (query.isLoading) return <AppShell><LoadingState /></AppShell>;
  if (!ges) return <AppShell><ErrorState message="This GES account was not found." /></AppShell>;

  const consumption = ges.annualConsumptionGwh && ges.annualConsumptionGwh > 0 ? ges.annualConsumptionGwh : null;
  const monthly = consumption === null ? null : (consumption * 1000) / 12;
  const target = ges.renewableEnergyTargetPercent;
  const calculated = consumption !== null && target !== null && target !== undefined ? consumption * (target / 100) : null;
  const peakKva = ges.peakRecordedDemandKva ?? (ges.requirement.peakDemandMw > 0 ? ges.requirement.peakDemandMw * 1000 : null);
  const contractKva = ges.contractDemandMw && ges.contractDemandMw > 0 ? ges.contractDemandMw * 1000 : null;
  const rooftopKw = ges.existingRooftopMw && ges.existingRooftopMw > 0 ? ges.existingRooftopMw * 1000 : null;

  return (
    <AppShell>
      <PageHeader eyebrow="GES" title={ges.name} description="Account identity, electricity profile, and the renewable energy the customer wants to buy.">
        {canEdit && <Link className="primary-button" href={`/ges/${ges.id}/edit`}><Pencil size={14} /> Edit GES</Link>}
      </PageHeader>
      <div className="ges-detail-grid">
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">GES overview</h2><p className="card-subtitle">{ges.code}</p></div></div>
          <div className="card-body info-grid">
            <Item label="GES / account name" value={ges.name} badge="Customer input" />
            <Item label="Legal name" value={text(ges.legalName)} badge="Customer input" />
            <Item label="Business type" value={text(ges.businessType)} badge="Customer input" />
            <Item label="Consumer number" value={text(ges.consumerNumbers)} badge="Customer input" />
            <Item label="City" value={text(ges.city || ges.location.split(',')[0])} badge="Customer input" />
            <Item label="State" value={text(ges.state)} badge="Customer input" />
            <Item label="DISCOM" value={text(ges.discom)} badge="Customer input" />
          </div>
        </section>
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Electricity profile</h2><p className="card-subtitle">Present supply. Blank means the figure has not been recorded.</p></div></div>
          <div className="card-body info-grid">
            <Item label="Annual electricity consumption" value={consumption === null ? '—' : `${amount(consumption, 4)} GWh/year`} badge="Electricity profile" />
            <Item label="Average monthly consumption" value={monthly === null ? '—' : `${amount(monthly, 3)} MWh/month`} badge="Auto calculated" />
            <Item label="Peak recorded demand" value={peakKva === null ? '—' : `${amount(peakKva, 1)} kVA`} badge="Electricity profile" />
            <Item label="Contract demand" value={contractKva === null ? '—' : `${amount(contractKva, 1)} kVA`} badge="Electricity profile" />
            <Item label="Sanctioned load" value={ges.sanctionedLoadKw ? `${amount(ges.sanctionedLoadKw, 1)} kW` : '—'} badge="Electricity profile" />
            <Item label="Existing rooftop solar" value={rooftopKw === null ? '—' : `${amount(rooftopKw, 1)} kW`} badge="Electricity profile" />
            <Item label="Solar connection type" value={text(ges.solarConnectionType)} badge="Electricity profile" />
          </div>
        </section>
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Renewable procurement</h2><p className="card-subtitle">Customer target and the energy calculated from it.</p></div></div>
          <div className="card-body info-grid">
            <Item label="Renewable energy target" value={target === null || target === undefined ? 'Not specified' : `${amount(target, 1)}%`} badge="Customer input" />
            <Item label="Required renewable energy" value={calculated === null ? 'Not specified' : `${amount(calculated, 4)} GWh/year`} badge="Auto calculated" />
            <Item label="Target supply start year" value={ges.requirement.targetCodYear > 0 ? String(ges.requirement.targetCodYear) : 'Not specified'} badge="Customer input" />
            <Item label="Preferred technology" value={technologyLabel(ges.requirement.preferredTechnologies)} badge="Customer input" />
            <Item label="BESS requirement" value={bessLabel(ges.bessRequirement, ges.requirement.bessPreference)} badge="Customer input" />
          </div>
        </section>
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Load / consumption profile</h2><p className="card-subtitle">Monthly bill history for this account.</p></div></div>
          <div className="card-body">
            <div className="empty-state"><span>Monthly bill history is not available for this account.</span></div>
          </div>
        </section>
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Operating notes</h2></div></div>
          <div className="card-body"><p className="card-subtitle" style={{ margin: 0 }}>{ges.notes?.trim() ? ges.notes : 'Not specified'}</p></div>
        </section>
      </div>
    </AppShell>
  );
}
