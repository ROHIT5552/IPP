'use client';

import Link from 'next/link';
import { FormEvent, ReactNode, useMemo, useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { toast } from 'sonner';
import { PageHeader } from '../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../components/DataState';
import { InfoTooltip } from '../terms/InfoTooltip';
import { useAuth } from '../auth/AuthProvider';
import { BESS_REQUIREMENTS, TECHNOLOGIES, bessKey, bessLabel, technologyKey, technologyLabel } from '../ges/options';
import { api, listQuery } from '../../services/api';
import { IppCatalogRow } from '../../types/api';
import { amount, commercialStatus, inr, provenanceKind, provenanceLabel, selectionStatus, when, Provenance } from './format';

function Badge({ value }: { value?: string }) {
  return <span className={`field-badge ${provenanceKind(value)}`}>{provenanceLabel(value)}</span>;
}

function Item({ label, value, provenance }: { label: string; value: string; provenance?: string }) {
  return (
    <div className="info-item">
      <small>{label} {provenance ? <Badge value={provenance} /> : null}</small>
      <strong>{value}</strong>
    </div>
  );
}

export interface GesProfile {
  id: string;
  name: string;
  legalName: string;
  businessType: string;
  consumerNumbers: string;
  city: string;
  state: string;
  discom: string;
  annualConsumptionGwh: number;
  averageMonthlyConsumptionGwh: number | null;
  peakRecordedDemandKva: number | null;
  contractDemandMw: number;
  billedDemandMw: number;
  sanctionedLoadKw: number | null;
  existingRooftopMw: number;
  existingRenewableGwh: number;
  contactName: string;
  contactEmail: string;
  contactPhone: string;
  notes: string;
  procurement: RequirementRecord;
  provenance: Record<string, Provenance>;
}

export interface RequirementRecord {
  gesId?: string;
  gesName?: string;
  annualConsumptionGwh?: number;
  renewableTargetPercent: number | null;
  requiredRenewableGwh: number | null;
  annualEnergyGwh: number;
  peakDemandMw: number;
  requiredCapacityGw: number;
  targetCodYear: number;
  preferredTechnologies: string[];
  bessPreference: string;
  bessRequirement?: string | null;
  targetTariffInrPerKwh: number | null;
  contractTenureYears: number | null;
  notes: string;
  commercialNotes: string;
  provenance?: Record<string, Provenance>;
}

export function GesProfileScreen({ gesId }: { gesId: string }) {
  const { user } = useAuth();
  const client = useQueryClient();
  const staff = !user?.gesId && Boolean(user?.permissions.includes('GES_EDIT'));
  const canEdit = Boolean(user?.permissions.includes('GES_PROFILE_EDIT'));
  const query = useQuery({ queryKey: ['ges-profile', gesId], queryFn: () => api.get<GesProfile>(`/ges/${gesId}/profile`) });
  const [form, setForm] = useState<Partial<GesProfile> | null>(null);
  const save = useMutation({
    mutationFn: (body: Partial<GesProfile>) => api.patch<GesProfile>(`/ges/${gesId}/profile`, body),
    onSuccess: (profile) => {
      client.setQueryData(['ges-profile', gesId], profile);
      setForm(null);
      toast.success('GES profile saved');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'Profile could not be saved'),
  });
  if (query.isLoading) return <PageSkeleton variant="detail" />;
  if (query.error || !query.data) return <ErrorState message="Unable to load this GES profile." retry={() => void query.refetch()} />;
  const profile = query.data;
  const draft = form ?? profile;
  const source = profile.provenance;

  function onSubmit(event: FormEvent) {
    event.preventDefault();
    const body: Partial<GesProfile> = {
      contactName: draft.contactName,
      contactEmail: draft.contactEmail,
      contactPhone: draft.contactPhone,
      notes: draft.notes,
    };
    if (staff) {
      Object.assign(body, {
        name: draft.name,
        legalName: draft.legalName,
        businessType: draft.businessType,
        city: draft.city,
        state: draft.state,
        discom: draft.discom,
        consumerNumbers: draft.consumerNumbers,
        annualConsumptionGwh: draft.annualConsumptionGwh,
        contractDemandMw: draft.contractDemandMw,
        billedDemandMw: draft.billedDemandMw,
        sanctionedLoadKw: draft.sanctionedLoadKw,
        peakRecordedDemandKva: draft.peakRecordedDemandKva,
        existingRooftopMw: draft.existingRooftopMw,
        existingRenewableGwh: draft.existingRenewableGwh,
      });
    }
    save.mutate(body);
  }

  return (
    <>
      <PageHeader eyebrow="GES PROFILE" title={profile.name} description="Who this customer is. Procurement choices are kept on the GES requirement." />
      <form className="card" onSubmit={onSubmit}>
        <div className="card-body procurement-stack">
          <section>
            <div className="form-section"><h3>Basic information</h3></div>
            <div className="info-grid">
              {staff ? <Field label="Account name" badge={source.accountName}><input value={draft.name} onChange={(event) => setForm({ ...draft, name: event.target.value })} /></Field> : <Item label="Account name" value={profile.name} provenance={source.accountName} />}
              {staff ? <Field label="Legal name" badge={source.legalName}><input value={draft.legalName} onChange={(event) => setForm({ ...draft, legalName: event.target.value })} /></Field> : <Item label="Legal name" value={profile.legalName || '—'} provenance={source.legalName} />}
              {staff ? <Field label="Business type" badge={source.businessType}><input value={draft.businessType} onChange={(event) => setForm({ ...draft, businessType: event.target.value })} /></Field> : <Item label="Business type" value={profile.businessType || '—'} provenance={source.businessType} />}
              {staff ? <Field label="Consumer number" badge={source.consumerNumbers}><input value={draft.consumerNumbers} onChange={(event) => setForm({ ...draft, consumerNumbers: event.target.value })} /></Field> : <Item label="Consumer number" value={profile.consumerNumbers || '—'} provenance={source.consumerNumbers} />}
              {staff ? <Field label="City" badge={source.city}><input value={draft.city} onChange={(event) => setForm({ ...draft, city: event.target.value })} /></Field> : <Item label="City" value={profile.city || '—'} provenance={source.city} />}
              {staff ? <Field label="State" badge={source.state}><input value={draft.state} onChange={(event) => setForm({ ...draft, state: event.target.value })} /></Field> : <Item label="State" value={profile.state || '—'} provenance={source.state} />}
              {staff ? <Field label="DISCOM" badge={source.discom}><input value={draft.discom} onChange={(event) => setForm({ ...draft, discom: event.target.value })} /></Field> : <Item label="DISCOM" value={profile.discom || '—'} provenance={source.discom} />}
            </div>
          </section>
          <section>
            <div className="form-section"><h3>Electricity profile</h3><p>Bill-verified and calculated values stay locked for the GES login.</p></div>
            <div className="info-grid">
              {staff ? <Field label="Annual consumption (GWh)" badge={source.annualConsumptionGwh}><input type="number" step="0.000001" value={draft.annualConsumptionGwh} onChange={(event) => setForm({ ...draft, annualConsumptionGwh: Number(event.target.value) })} /></Field> : <Item label="Annual consumption" value={profile.annualConsumptionGwh ? `${amount(profile.annualConsumptionGwh, 6)} GWh` : '—'} provenance={source.annualConsumptionGwh} />}
              <Item label="Average monthly consumption" value={profile.averageMonthlyConsumptionGwh == null ? '—' : `${amount(profile.averageMonthlyConsumptionGwh * 1000, 3)} MWh/month`} provenance={source.averageMonthlyConsumptionGwh} />
              {staff ? <Field label="Peak recorded demand (kVA)" badge={source.peakRecordedDemandKva}><input type="number" step="0.1" value={draft.peakRecordedDemandKva ?? ''} onChange={(event) => setForm({ ...draft, peakRecordedDemandKva: event.target.value === '' ? null : Number(event.target.value) })} /></Field> : <Item label="Peak recorded demand" value={profile.peakRecordedDemandKva ? `${amount(profile.peakRecordedDemandKva, 1)} kVA` : '—'} provenance={source.peakRecordedDemandKva} />}
              {staff ? <Field label="Contract demand (MW)" badge={source.contractDemandMw}><input type="number" step="0.001" value={draft.contractDemandMw} onChange={(event) => setForm({ ...draft, contractDemandMw: Number(event.target.value) })} /></Field> : <Item label="Contract demand" value={profile.contractDemandMw ? `${amount(profile.contractDemandMw, 3)} MW` : '—'} provenance={source.contractDemandMw} />}
              {staff ? <Field label="Billed demand (MW)" badge={source.billedDemandMw}><input type="number" step="0.001" value={draft.billedDemandMw} onChange={(event) => setForm({ ...draft, billedDemandMw: Number(event.target.value) })} /></Field> : <Item label="Billed demand" value={profile.billedDemandMw ? `${amount(profile.billedDemandMw, 3)} MW` : '—'} provenance={source.billedDemandMw} />}
              {staff ? <Field label="Sanctioned load (kW)" badge={source.sanctionedLoadKw}><input type="number" step="0.1" value={draft.sanctionedLoadKw ?? ''} onChange={(event) => setForm({ ...draft, sanctionedLoadKw: event.target.value === '' ? null : Number(event.target.value) })} /></Field> : <Item label="Sanctioned load" value={profile.sanctionedLoadKw ? `${amount(profile.sanctionedLoadKw / 1000, 3)} MW` : '—'} provenance={source.sanctionedLoadKw} />}
              {staff ? <Field label="Existing rooftop solar (MW)" badge={source.existingRooftopMw}><input type="number" step="0.001" value={draft.existingRooftopMw} onChange={(event) => setForm({ ...draft, existingRooftopMw: Number(event.target.value) })} /></Field> : <Item label="Existing rooftop solar" value={profile.existingRooftopMw ? `${amount(profile.existingRooftopMw, 3)} MW` : '—'} provenance={source.existingRooftopMw} />}
              {staff ? <Field label="Existing renewable energy (GWh)" badge={source.existingRenewableGwh}><input type="number" step="0.001" value={draft.existingRenewableGwh} onChange={(event) => setForm({ ...draft, existingRenewableGwh: Number(event.target.value) })} /></Field> : <Item label="Existing renewable energy" value={profile.existingRenewableGwh ? `${amount(profile.existingRenewableGwh, 3)} GWh` : '—'} provenance={source.existingRenewableGwh} />}
            </div>
          </section>
          <section>
            <div className="form-section"><h3>Procurement requirement</h3><p>Shown here for context. Edit it on the GES requirement screen.</p></div>
            <div className="info-grid">
              <Item label="Renewable energy target %" value={profile.procurement.renewableTargetPercent == null ? 'Not specified' : `${amount(profile.procurement.renewableTargetPercent, 1)}%`} provenance="CLIENT_PROVIDED" />
              <Item label="Required renewable energy" value={profile.procurement.requiredRenewableGwh == null ? 'Not specified' : `${amount(profile.procurement.requiredRenewableGwh, 4)} GWh`} provenance="CALCULATED" />
              <Item label="Target supply start" value={profile.procurement.targetCodYear > 0 ? String(profile.procurement.targetCodYear) : 'Not specified'} provenance="CLIENT_PROVIDED" />
              <Item label="Preferred technologies" value={technologyLabel(profile.procurement.preferredTechnologies)} provenance="CLIENT_PROVIDED" />
              <Item label="BESS preference" value={bessLabel(profile.procurement.bessRequirement, profile.procurement.bessPreference)} provenance="CLIENT_PROVIDED" />
            </div>
          </section>
          <section>
            <div className="form-section"><h3>Contact information</h3></div>
            <div className="form-grid">
              <Field label="Contact name" badge={source.contactName}><input value={draft.contactName} disabled={!canEdit} onChange={(event) => setForm({ ...draft, contactName: event.target.value })} /></Field>
              <Field label="Email" badge={source.contactEmail}><input type="email" value={draft.contactEmail} disabled={!canEdit} onChange={(event) => setForm({ ...draft, contactEmail: event.target.value })} /></Field>
              <Field label="Phone" badge={source.contactPhone}><input value={draft.contactPhone} disabled={!canEdit} onChange={(event) => setForm({ ...draft, contactPhone: event.target.value })} /></Field>
              <Field label="Operating notes" badge={source.notes}><textarea value={draft.notes} disabled={!canEdit} onChange={(event) => setForm({ ...draft, notes: event.target.value })} /></Field>
            </div>
          </section>
          {canEdit && <div className="card-tools"><button className="primary-button" type="submit" disabled={save.isPending}>{save.isPending ? 'Saving…' : 'Save profile'}</button></div>}
        </div>
      </form>
    </>
  );
}

export function GesRequirementScreen({ gesId }: { gesId: string }) {
  const { user } = useAuth();
  const client = useQueryClient();
  const canEdit = Boolean(user?.permissions.includes('REQUIREMENT_EDIT'));
  const query = useQuery({ queryKey: ['ges-requirement', gesId], queryFn: () => api.get<RequirementRecord>(`/ges/${gesId}/requirements`) });
  const [form, setForm] = useState<RequirementRecord | null>(null);
  const save = useMutation({
    mutationFn: (body: RequirementRecord) => api.patch<RequirementRecord>(`/ges/${gesId}/requirements`, {
      renewableTargetPercent: body.renewableTargetPercent,
      preferredTechnology: technologyKey(body.preferredTechnologies),
      bessRequirement: bessKey(body.bessRequirement, body.bessPreference),
      targetSupplyStartYear: body.targetCodYear || null,
      targetTariffInrPerKwh: body.targetTariffInrPerKwh,
      contractTenureYears: body.contractTenureYears,
      notes: body.notes,
      commercialNotes: body.commercialNotes,
      annualEnergyGwh: user?.gesId ? undefined : body.annualEnergyGwh,
      requiredRenewableGwh: body.requiredRenewableGwh,
      peakDemandMw: body.peakDemandMw,
    }),
    onSuccess: (requirement) => {
      client.setQueryData(['ges-requirement', gesId], requirement);
      setForm(null);
      toast.success('GES requirement saved');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'Requirement could not be saved'),
  });
  if (query.isLoading) return <PageSkeleton variant="form" />;
  if (query.error || !query.data) return <ErrorState message="Unable to load the GES requirement." retry={() => void query.refetch()} />;
  const requirement = form ?? query.data;
  const source = query.data.provenance ?? {};
  const technology = technologyKey(requirement.preferredTechnologies);

  function onSubmit(event: FormEvent) {
    event.preventDefault();
    save.mutate(requirement);
  }

  return (
    <>
      <PageHeader eyebrow="GES REQUIREMENT" title={query.data.gesName || 'GES requirement'} description="What this GES currently wants from renewable procurement. This is not a negotiation." />
      <form className="card" onSubmit={onSubmit}>
        <div className="card-body form-grid">
          <div className="form-section"><h3>Energy requirement</h3></div>
          <Field label="Renewable target %" badge={source.renewableTargetPercent}><input type="number" min={0} max={100} step="0.1" disabled={!canEdit} value={requirement.renewableTargetPercent ?? ''} onChange={(event) => setForm({ ...requirement, renewableTargetPercent: event.target.value === '' ? null : Number(event.target.value) })} /></Field>
          <Field label="Required renewable energy" badge="CLIENT_PROVIDED"><input type="number" min={0} step="0.0001" disabled={!canEdit} value={requirement.requiredRenewableGwh ?? ''} onChange={(event) => setForm({ ...requirement, requiredRenewableGwh: event.target.value === '' ? null : Number(event.target.value) })} /></Field>
          <Field label="Required energy (GWh)" badge={user?.gesId ? 'CALCULATED' : source.annualEnergyGwh}><input type="number" step="0.001" disabled={!canEdit || Boolean(user?.gesId)} value={requirement.annualEnergyGwh} onChange={(event) => setForm({ ...requirement, annualEnergyGwh: Number(event.target.value) })} /></Field>
          <Field label="Required load (MW)" badge="CLIENT_PROVIDED"><input type="number" min={0} step="0.001" disabled={!canEdit} value={requirement.peakDemandMw || ''} onChange={(event) => setForm({ ...requirement, peakDemandMw: event.target.value === '' ? 0 : Number(event.target.value) })} /></Field>
          <Field label="Target supply start" badge={source.targetCodYear}><input type="number" min={2024} max={2060} disabled={!canEdit} value={requirement.targetCodYear || ''} onChange={(event) => setForm({ ...requirement, targetCodYear: Number(event.target.value) })} /></Field>
          <Field label="Preferred technology" badge={source.preferredTechnologies}>
            <select disabled={!canEdit} value={technology} onChange={(event) => setForm({ ...requirement, preferredTechnologies: event.target.value && event.target.value !== 'NONE' ? event.target.value.split('+') : [] })}>
              <option value="">Not specified</option>
              {TECHNOLOGIES.map((item) => <option key={item.value} value={item.value}>{item.label}</option>)}
            </select>
          </Field>
          <Field label="BESS preference" badge={source.bessPreference}>
            <select disabled={!canEdit} value={bessKey(requirement.bessRequirement, requirement.bessPreference)} onChange={(event) => setForm({ ...requirement, bessRequirement: event.target.value })}>
              <option value="">Not specified</option>
              {BESS_REQUIREMENTS.map((item) => <option key={item.value} value={item.value}>{item.label}</option>)}
            </select>
          </Field>
          <Field label="Notes" badge={source.notes}><textarea disabled={!canEdit} value={requirement.notes} onChange={(event) => setForm({ ...requirement, notes: event.target.value })} /></Field>
          <div className="form-section"><h3>Commercial requirement</h3><p>What the GES wants commercially. This does not start a negotiation.</p></div>
          <Field label="Target tariff (₹/kWh)" badge={source.targetTariffInrPerKwh}><input type="number" min={0} step="0.01" disabled={!canEdit} value={requirement.targetTariffInrPerKwh ?? ''} onChange={(event) => setForm({ ...requirement, targetTariffInrPerKwh: event.target.value === '' ? null : Number(event.target.value) })} /></Field>
          <Field label="Contract tenure (years)" badge={source.contractTenureYears}><input type="number" min={0} step="1" disabled={!canEdit} value={requirement.contractTenureYears ?? ''} onChange={(event) => setForm({ ...requirement, contractTenureYears: event.target.value === '' ? null : Number(event.target.value) })} /></Field>
          <Field label="Commercial notes" badge={source.commercialNotes}><textarea disabled={!canEdit} value={requirement.commercialNotes} onChange={(event) => setForm({ ...requirement, commercialNotes: event.target.value })} /></Field>
          {canEdit && <div className="form-span card-tools"><button className="primary-button" type="submit" disabled={save.isPending}>{save.isPending ? 'Saving…' : 'Save GES requirement'}</button></div>}
        </div>
      </form>
    </>
  );
}

export function IppCatalogueScreen({ gesId, detailBase }: { gesId: string; detailBase: string }) {
  const { user } = useAuth();
  const client = useQueryClient();
  const canConsider = Boolean(user?.permissions.includes('SELECTION_CREATE'));
  const [picked, setPicked] = useState<string[]>([]);
  const catalog = useQuery({ queryKey: ['ipp-catalog', gesId, Boolean(user?.gesId)], queryFn: () => api.get<IppCatalogRow[]>('/ipp-catalog'), ...listQuery });
  const selections = useQuery({ queryKey: ['ges-selections', gesId], queryFn: () => api.get<SelectionBoard>(`/ges/${gesId}/selections`) });
  const consider = useMutation({
    mutationFn: (ippId: string) => api.post<SelectionBoard>(`/ges/${gesId}/ipps/${ippId}/consider`),
    onSuccess: (board) => {
      client.setQueryData(['ges-selections', gesId], board);
      void client.invalidateQueries({ queryKey: ['ipp-catalog'] });
      toast.success('IPP considered for this GES requirement');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'This IPP could not be considered'),
  });
  const selected = useMemo(() => new Set(selections.data?.selections.map((item) => item.ippId) ?? []), [selections.data]);
  if (catalog.isLoading) return <PageSkeleton variant="table" />;
  if (catalog.error) return <ErrorState message="Unable to load the IPP catalogue." retry={() => void catalog.refetch()} />;
  const rows = catalog.data ?? [];

  function toggle(id: string) {
    setPicked((current) => {
      if (current.includes(id)) return current.filter((item) => item !== id);
      if (current.length >= 3) {
        toast.error('Compare no more than three IPPs at once.');
        return current;
      }
      return [...current, id];
    });
  }

  return (
    <>
      <PageHeader eyebrow="IPP CATALOGUE" title="Available IPPs" description="This catalogue is global. Viewing an IPP does not attach it to the GES. Use Consider for Requirement when this GES wants to take it forward.">
        <Link className="primary-button" href={picked.length ? `/ges/${gesId}/comparison?ippIds=${picked.join(',')}` : `/ges/${gesId}/comparison`}>Compare{picked.length ? ` ${picked.length}` : ''}</Link>
      </PageHeader>
      <section className="card">
        <div className="data-table-wrap">
          <table className="data-table">
            <thead>
              <tr>
                <th>Compare</th><th>IPP / project</th><th>Location</th><th>Technology</th><th>Solar</th><th>Wind</th><th>BESS</th><th>Generation</th><th>P90</th><th>Tariff</th><th>COD</th><th>FDRE</th><th>Status</th><th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {rows.map((ipp) => {
                const place = [ipp.projectLocation, ipp.projectDistrict, ipp.projectState].filter(Boolean).join(', ') || '—';
                const considered = selected.has(ipp.id) || ipp.selectedByCurrentGes;
                return (
                  <tr key={ipp.id}>
                    <td><input type="checkbox" checked={picked.includes(ipp.id)} onChange={() => toggle(ipp.id)} aria-label={`Compare ${ipp.name}`} /></td>
                    <td><strong>{ipp.name}</strong><span className="number-sub">{ipp.projectName || 'Project not specified'}</span></td>
                    <td>{place}</td>
                    <td>{ipp.technology || '—'}</td>
                    <td>{ipp.solarMw > 0 ? `${amount(ipp.solarMw, 1)} MW` : '—'}</td>
                    <td>{ipp.windMw > 0 ? `${amount(ipp.windMw, 1)} MW` : '—'}</td>
                    <td>{ipp.bessMw > 0 || ipp.bessMwh > 0 ? `${amount(ipp.bessMw, 1)} MW / ${amount(ipp.bessMwh, 1)} MWh` : '—'}</td>
                    <td>{amount(ipp.annualGenerationGwh, 1)} GWh</td>
                    <td>{ipp.p90Gwh ? `${amount(ipp.p90Gwh, 1)} GWh` : '—'}</td>
                    <td>{inr(ipp.tariff)}</td>
                    <td>{ipp.codYear && ipp.codYear > 0 ? ipp.codYear : '—'}</td>
                    <td>{ipp.fdreCapability || '—'}</td>
                    <td>{ipp.projectStatus || '—'}</td>
                    <td>
                      <div className="row-actions">
                        <Link className="small-button" href={`${detailBase}/${ipp.id}`}>View details</Link>
                        {canConsider && <button className="small-button" type="button" disabled={consider.isPending || considered} onClick={() => consider.mutate(ipp.id)}>{considered ? 'Considered' : 'Consider for Requirement'}</button>}
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
          {!rows.length && <div className="empty-state"><span>No client-visible IPPs are in the catalogue.</span></div>}
        </div>
      </section>
    </>
  );
}

interface CommercialRecord {
  id: string;
  targetTariffInrPerKwh: number | null;
  requiredEnergyGwh: number | null;
  requiredLoadMw: number | null;
  contractTenureYears: number | null;
  targetSupplyYear: number | null;
  notes: string;
  status: string;
  createdBy: string | null;
  createdByRole: string;
  actingOnBehalfOfGes: boolean;
  onBehalfOf: string | null;
  createdAt: string;
}

interface SelectionRow {
  id: string;
  ippId: string;
  ippName: string;
  ippTariff: number;
  requirementMatch: number | null;
  myTargetTariff: number | null;
  status: string;
  createdBy: string | null;
  createdByRole: string;
  actingOnBehalfOfGes: boolean;
  onBehalfOf: string | null;
  createdAt: string;
  commercialRequirements: CommercialRecord[];
}

interface SelectionBoard {
  gesId: string;
  gesName: string;
  targetTariffInrPerKwh: number | null;
  selections: SelectionRow[];
}

export function MyIppsScreen({ gesId }: { gesId: string }) {
  const { user } = useAuth();
  const client = useQueryClient();
  const canWrite = Boolean(user?.permissions.includes('COMMERCIAL_REQUIREMENT_CREATE'));
  const query = useQuery({ queryKey: ['ges-selections', gesId], queryFn: () => api.get<SelectionBoard>(`/ges/${gesId}/selections`) });
  const [open, setOpen] = useState<string | null>(null);
  const [draft, setDraft] = useState({ targetTariffInrPerKwh: '', requiredEnergyGwh: '', requiredLoadMw: '', contractTenureYears: '', targetSupplyYear: '', notes: '' });
  const save = useMutation({
    mutationFn: ({ selectionId, body }: { selectionId: string; body: Record<string, unknown> }) => api.post<SelectionBoard>(`/ges/${gesId}/selections/${selectionId}/commercial-requirements`, body),
    onSuccess: (board) => {
      client.setQueryData(['ges-selections', gesId], board);
      toast.success('Commercial requirement recorded');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'Commercial requirement could not be saved'),
  });
  if (query.isLoading) return <PageSkeleton variant="cards" />;
  if (query.error || !query.data) return <ErrorState message="Unable to load IPP selections." retry={() => void query.refetch()} />;
  const board = query.data;

  return (
    <>
      <PageHeader eyebrow="MY IPP SELECTIONS" title={board.gesName} description="Only IPPs this GES has explicitly considered. The IPP record itself stays global." />
      <div className="procurement-stack">
        {board.selections.map((row) => (
          <section className="card selection-card" key={row.id}>
            <div className="card-body">
              <div className="dealbook-head">
                <div>
                  <h2>{row.ippName}</h2>
                  <p>Requirement match: {row.requirementMatch == null ? 'Not calculated yet' : `${amount(row.requirementMatch, 0)}%`}</p>
                </div>
                <span className="tech-tag">{selectionStatus(row.status)}</span>
              </div>
              <div className="info-grid">
                <Item label="IPP tariff" value={inr(row.ippTariff)} />
                <Item label="My target tariff" value={inr(row.myTargetTariff)} />
                <Item label="Created by" value={row.createdBy || '—'} />
                <Item label="Role" value={row.createdByRole || '—'} />
                {row.actingOnBehalfOfGes && <Item label="On behalf of" value={row.onBehalfOf || board.gesName} />}
                <Item label="Created at" value={when(row.createdAt)} />
              </div>
              <div className="divider" />
              <h3>Commercial history</h3>
              <div className="history-list">
                {row.commercialRequirements.length ? row.commercialRequirements.map((item) => (
                  <article className="history-row" key={item.id}>
                    <strong>{when(item.createdAt)} · {commercialStatus(item.status)}</strong>
                    <small>Target tariff {inr(item.targetTariffInrPerKwh)} · Tenure {item.contractTenureYears ?? '—'} years · Required energy {item.requiredEnergyGwh ?? '—'} GWh</small>
                    <small>Required load {item.requiredLoadMw ?? '—'} MW · Supply start {item.targetSupplyYear ?? '—'}</small>
                    {item.notes && <small>{item.notes}</small>}
                    <small>Created by {item.createdBy || '—'}{item.createdByRole ? ` · ${item.createdByRole}` : ''}{item.actingOnBehalfOfGes ? ` · On behalf of ${item.onBehalfOf}` : ''}</small>
                  </article>
                )) : <div className="empty-state"><span>No commercial requirement has been submitted for this IPP.</span></div>}
              </div>
              {canWrite && (
                <form className="form-grid" style={{ marginTop: 12 }} onSubmit={(event) => {
                  event.preventDefault();
                  save.mutate({
                    selectionId: row.id,
                    body: {
                      targetTariffInrPerKwh: draft.targetTariffInrPerKwh === '' ? null : Number(draft.targetTariffInrPerKwh),
                      requiredEnergyGwh: draft.requiredEnergyGwh === '' ? null : Number(draft.requiredEnergyGwh),
                      requiredLoadMw: draft.requiredLoadMw === '' ? null : Number(draft.requiredLoadMw),
                      contractTenureYears: draft.contractTenureYears === '' ? null : Number(draft.contractTenureYears),
                      targetSupplyYear: draft.targetSupplyYear === '' ? null : Number(draft.targetSupplyYear),
                      notes: draft.notes,
                    },
                  });
                }}>
                  <div className="form-section"><h3>Commercial requirement</h3><p>Each save adds a new history row. Earlier rows stay unchanged.</p></div>
                  {open !== row.id ? <button className="secondary-button" type="button" onClick={() => setOpen(row.id)}>Add commercial requirement</button> : (
                    <>
                      <Field label="Target tariff (₹/kWh)" badge="CLIENT_PROVIDED"><input type="number" min={0} step="0.01" value={draft.targetTariffInrPerKwh} onChange={(event) => setDraft({ ...draft, targetTariffInrPerKwh: event.target.value })} /></Field>
                      <Field label="Required energy (GWh)" badge="CLIENT_PROVIDED"><input type="number" min={0} step="0.001" value={draft.requiredEnergyGwh} onChange={(event) => setDraft({ ...draft, requiredEnergyGwh: event.target.value })} /></Field>
                      <Field label="Required load (MW)" badge="CLIENT_PROVIDED"><input type="number" min={0} step="0.001" value={draft.requiredLoadMw} onChange={(event) => setDraft({ ...draft, requiredLoadMw: event.target.value })} /></Field>
                      <Field label="Contract tenure (years)" badge="CLIENT_PROVIDED"><input type="number" min={0} step="1" value={draft.contractTenureYears} onChange={(event) => setDraft({ ...draft, contractTenureYears: event.target.value })} /></Field>
                      <Field label="Target supply start" badge="CLIENT_PROVIDED"><input type="number" min={2024} max={2060} value={draft.targetSupplyYear} onChange={(event) => setDraft({ ...draft, targetSupplyYear: event.target.value })} /></Field>
                      <Field label="Additional commercial notes" badge="CLIENT_PROVIDED"><textarea value={draft.notes} onChange={(event) => setDraft({ ...draft, notes: event.target.value })} /></Field>
                      <div className="form-span card-tools">
                        <button className="secondary-button" type="button" onClick={() => setOpen(null)}>Cancel</button>
                        <button className="primary-button" type="submit" disabled={save.isPending}>{save.isPending ? 'Saving…' : 'Submit commercial requirement'}</button>
                      </div>
                    </>
                  )}
                </form>
              )}
            </div>
          </section>
        ))}
        {!board.selections.length && <div className="empty-state"><span>This GES has not considered an IPP yet. Browse the catalogue and choose Consider for Requirement.</span></div>}
      </div>
    </>
  );
}

interface ClientIpp {
  id: string;
  selected: boolean;
  selectionStatus: string | null;
  overview: { name: string; projectName: string; location: string; technology: string; projectStatus: string };
  capacity: { solarMw: number; windMw: number; bessMw: number; bessMwh: number; bessDurationHours: number | null };
  generation: { annualGenerationGwh: number; p90Gwh: number | null; fdreCapability: string | null };
  commercial: { tariff: number; tariffType: string | null; contractTenureYears: number | null };
  execution: { codYear: number | null; codConfidence: string | null };
  grid: { gridVoltage: string | null; connectivityStatus: string | null; openAccessReadiness: string | null };
  requirementMatch: number | null;
  matches: { key: string; label: string; score: number }[];
  requiredChecks: { name: string; status: string }[];
  requirement: { targetTariffInrPerKwh: number | null; targetCodYear: number; preferredTechnologies: string[] } | null;
}

export function ClientIppScreen({ gesId, ippId }: { gesId: string; ippId: string }) {
  const { user } = useAuth();
  const client = useQueryClient();
  const canConsider = Boolean(user?.permissions.includes('SELECTION_CREATE'));
  const query = useQuery({ queryKey: ['client-ipp', gesId, ippId], queryFn: () => api.get<ClientIpp>(`/ges/${gesId}/catalogue/${ippId}`) });
  const consider = useMutation({
    mutationFn: () => api.post(`/ges/${gesId}/ipps/${ippId}/consider`),
    onSuccess: () => {
      void query.refetch();
      void client.invalidateQueries({ queryKey: ['ges-selections', gesId] });
      toast.success('IPP considered for this GES requirement');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'This IPP could not be considered'),
  });
  if (query.isLoading) return <PageSkeleton variant="detail" />;
  if (query.error || !query.data) return <ErrorState message="Unable to load this IPP." retry={() => void query.refetch()} />;
  const ipp = query.data;
  return (
    <>
      <PageHeader eyebrow="IPP DETAILS" title={ipp.overview.name} description={ipp.overview.projectName || 'Project name not specified'}>
        <Link className="secondary-button" href={`/ges/${gesId}/comparison?ippIds=${ipp.id}`}>Compare</Link>
        {canConsider && <button className="primary-button" type="button" disabled={consider.isPending || ipp.selected} onClick={() => consider.mutate()}>{ipp.selected ? 'Considered' : 'Consider for Requirement'}</button>}
      </PageHeader>
      <div className="procurement-stack">
        <section className="card"><div className="card-body info-grid">
          <div className="form-section"><h3>Project overview</h3></div>
          <Item label="IPP name" value={ipp.overview.name} />
          <Item label="Project name" value={ipp.overview.projectName || '—'} />
          <Item label="Location" value={ipp.overview.location || '—'} />
          <Item label="Technology" value={ipp.overview.technology || '—'} />
          <Item label="Project status" value={ipp.overview.projectStatus || '—'} />
          <Item label="Requirement match" value={ipp.requirementMatch == null ? 'Not calculated yet' : `${amount(ipp.requirementMatch, 0)}%`} />
        </div></section>
        <section className="card"><div className="card-body info-grid">
          <div className="form-section"><h3>Capacity</h3></div>
          <Item label="Solar" value={ipp.capacity.solarMw > 0 ? `${amount(ipp.capacity.solarMw, 1)} MW` : '—'} />
          <Item label="Wind" value={ipp.capacity.windMw > 0 ? `${amount(ipp.capacity.windMw, 1)} MW` : '—'} />
          <Item label="BESS MW" value={ipp.capacity.bessMw > 0 ? `${amount(ipp.capacity.bessMw, 1)} MW` : '—'} />
          <Item label="BESS MWh" value={ipp.capacity.bessMwh > 0 ? `${amount(ipp.capacity.bessMwh, 1)} MWh` : '—'} />
          <Item label="BESS duration" value={ipp.capacity.bessDurationHours ? `${amount(ipp.capacity.bessDurationHours, 2)} hours` : '—'} />
        </div></section>
        <section className="card"><div className="card-body info-grid">
          <div className="form-section"><h3>Generation</h3></div>
          <Item label="Annual generation" value={`${amount(ipp.generation.annualGenerationGwh, 1)} GWh`} />
          <div className="info-item"><small>P90 <InfoTooltip term="P90" /></small><strong>{ipp.generation.p90Gwh ? `${amount(ipp.generation.p90Gwh, 1)} GWh` : '—'}</strong></div>
          <div className="info-item"><small>FDRE <InfoTooltip term="FDRE" /></small><strong>{ipp.generation.fdreCapability || '—'}</strong></div>
        </div></section>
        <section className="card"><div className="card-body info-grid">
          <div className="form-section"><h3>Commercial</h3></div>
          <Item label="Tariff" value={inr(ipp.commercial.tariff)} />
          <Item label="Tariff type" value={ipp.commercial.tariffType || '—'} />
          <Item label="Contract tenure" value={ipp.commercial.contractTenureYears ? `${amount(ipp.commercial.contractTenureYears, 0)} years` : 'Not specified'} />
          <Item label="My target tariff" value={inr(ipp.requirement?.targetTariffInrPerKwh)} />
        </div></section>
        <section className="card"><div className="card-body info-grid">
          <div className="form-section"><h3>Execution</h3></div>
          <div className="info-item"><small>Expected COD <InfoTooltip term="COD" /></small><strong>{ipp.execution.codYear ?? '—'}</strong></div>
          <Item label="COD confidence" value={ipp.execution.codConfidence || '—'} />
        </div></section>
        <section className="card"><div className="card-body info-grid">
          <div className="form-section"><h3>Grid</h3></div>
          <Item label="Grid voltage" value={ipp.grid.gridVoltage || '—'} />
          <Item label="Connectivity status" value={ipp.grid.connectivityStatus || '—'} />
          <div className="info-item"><small>Open access <InfoTooltip term="Open Access" /></small><strong>{ipp.grid.openAccessReadiness || '—'}</strong></div>
        </div></section>
        <section className="card"><div className="card-body">
          <div className="form-section"><h3>Requirement match</h3><p>Calculated for this GES requirement. It is not a universal IPP score.</p></div>
          <div className="info-grid">
            {ipp.matches.map((item) => <Item key={item.key} label={item.label} value={`${amount(item.score, 0)}%`} />)}
            {!ipp.matches.length && <Item label="Match" value={ipp.requirementMatch == null ? 'Not calculated yet' : `${amount(ipp.requirementMatch, 0)}%`} />}
          </div>
          <div className="divider" />
          <h3>Required checks</h3>
          <div className="info-grid">
            {ipp.requiredChecks.map((check) => <Item key={check.name} label={check.name} value={check.status} />)}
            {!ipp.requiredChecks.length && <Item label="Required checks" value="None recorded" />}
          </div>
        </div></section>
      </div>
    </>
  );
}

function Field({ label, badge, children }: { label: string; badge?: string; children: ReactNode }) {
  return (
    <label className="form-field">
      <span className="field-label">{label} {badge ? <Badge value={badge} /> : null}</span>
      {children}
    </label>
  );
}
