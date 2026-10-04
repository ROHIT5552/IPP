'use client';

import Link from 'next/link';
import { FormEvent, ReactNode, useMemo, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { toast } from 'sonner';
import { PageHeader } from '../../components/AppShell';
import { api } from '../../services/api';
import { GesAccount } from '../../types/api';
import { BESS_REQUIREMENTS, BUSINESS_TYPES, DISCOMS, SOLAR_CONNECTIONS, STATES, TECHNOLOGIES, bessKey, technologyKey, withCurrent } from './options';

const emptyForm = {
  name: '',
  legalName: '',
  businessType: '',
  location: '',
  state: '',
  discom: '',
  consumerNumbers: '',
  annualConsumptionGwh: '' as number | '',
  peakRecordedDemandKva: '' as number | '',
  contractDemandKva: '' as number | '',
  sanctionedLoadKw: '' as number | '',
  existingRooftopSolarKw: '' as number | '',
  solarConnectionType: '',
  renewableEnergyTargetPercent: '' as number | '',
  targetSupplyStartYear: '' as number | '',
  preferredTechnology: '',
  bessRequirement: '',
  notes: '',
};

type GesFormState = typeof emptyForm;

function formFromAccount(ges: GesAccount): GesFormState {
  const peakKva = ges.peakRecordedDemandKva ?? (ges.requirement.peakDemandMw > 0 ? ges.requirement.peakDemandMw * 1000 : '');
  return {
    name: ges.name,
    legalName: ges.legalName || '',
    businessType: ges.businessType || '',
    location: ges.city || ges.location.split(',')[0]?.trim() || '',
    state: ges.state || ges.location.split(',')[1]?.trim() || '',
    discom: ges.discom || '',
    consumerNumbers: ges.consumerNumbers || '',
    annualConsumptionGwh: ges.annualConsumptionGwh || '',
    peakRecordedDemandKva: peakKva || '',
    contractDemandKva: ges.contractDemandMw ? ges.contractDemandMw * 1000 : '',
    sanctionedLoadKw: ges.sanctionedLoadKw || '',
    existingRooftopSolarKw: ges.existingRooftopMw ? ges.existingRooftopMw * 1000 : '',
    solarConnectionType: ges.solarConnectionType || '',
    renewableEnergyTargetPercent: ges.renewableEnergyTargetPercent ?? '',
    targetSupplyStartYear: ges.requirement.targetCodYear > 0 ? ges.requirement.targetCodYear : '',
    preferredTechnology: technologyKey(ges.requirement.preferredTechnologies),
    bessRequirement: bessKey(ges.bessRequirement, ges.requirement.bessPreference),
    notes: ges.notes || '',
  };
}

function payload(form: GesFormState) {
  const numeric = (value: number | '') => (value === '' ? null : value);
  return {
    name: form.name,
    legalName: form.legalName,
    businessType: form.businessType,
    location: form.location,
    state: form.state,
    discom: form.discom,
    consumerNumbers: form.consumerNumbers,
    annualConsumptionGwh: numeric(form.annualConsumptionGwh),
    peakRecordedDemandKva: numeric(form.peakRecordedDemandKva),
    contractDemandKva: numeric(form.contractDemandKva),
    sanctionedLoadKw: numeric(form.sanctionedLoadKw),
    existingRooftopSolarKw: numeric(form.existingRooftopSolarKw),
    solarConnectionType: form.solarConnectionType,
    renewableEnergyTargetPercent: numeric(form.renewableEnergyTargetPercent),
    targetSupplyStartYear: numeric(form.targetSupplyStartYear),
    preferredTechnology: form.preferredTechnology,
    bessRequirement: form.bessRequirement,
    notes: form.notes,
  };
}

function fieldErrors(form: GesFormState) {
  const errors: Partial<Record<keyof GesFormState, string>> = {};
  if (!form.name.trim()) errors.name = 'Enter the account name.';
  if (!form.legalName.trim()) errors.legalName = 'Enter the legal name.';
  if (!form.businessType) errors.businessType = 'Select a business type.';
  if (!form.location.trim()) errors.location = 'Enter the city.';
  if (!form.state) errors.state = 'Select a state.';
  if (!form.discom) errors.discom = 'Select a DISCOM.';
  const numberError = (value: number | '', label: string, min = 0, max?: number) => {
    if (value === '') return '';
    if (!Number.isFinite(value) || value < min || (max != null && value > max)) {
      return max == null ? `Enter ${label} of ${min} or more.` : `Enter ${label} from ${min} to ${max}.`;
    }
    return '';
  };
  const consumption = numberError(form.annualConsumptionGwh, 'consumption');
  const peak = numberError(form.peakRecordedDemandKva, 'peak demand');
  const contract = numberError(form.contractDemandKva, 'contract demand');
  const sanctioned = numberError(form.sanctionedLoadKw, 'sanctioned load');
  const rooftop = numberError(form.existingRooftopSolarKw, 'rooftop solar');
  const target = numberError(form.renewableEnergyTargetPercent, 'a target', 0, 100);
  const year = numberError(form.targetSupplyStartYear, 'a year', 2026, 2045);
  if (consumption) errors.annualConsumptionGwh = consumption;
  if (peak) errors.peakRecordedDemandKva = peak;
  if (contract) errors.contractDemandKva = contract;
  if (sanctioned) errors.sanctionedLoadKw = sanctioned;
  if (rooftop) errors.existingRooftopSolarKw = rooftop;
  if (target) errors.renewableEnergyTargetPercent = target;
  if (year) errors.targetSupplyStartYear = year;
  return errors;
}

function Badge({ kind, children }: { kind: 'customer' | 'calculated' | 'stored'; children: string }) {
  return <span className={`field-badge ${kind === 'stored' ? '' : kind}`}>{children}</span>;
}

function Section({ title, text }: { title: string; text: string }) {
  return <div className="form-section"><h3>{title}</h3><p>{text}</p></div>;
}

function Field({ label, badge, kind = 'customer', error, children }: { label: string; badge: string; kind?: 'customer' | 'calculated' | 'stored'; error?: string; children: ReactNode }) {
  return (
    <label className={`form-field${error ? ' has-error' : ''}`}>
      <span className="field-label">{label} <Badge kind={kind}>{badge}</Badge></span>
      {children}
      {error ? <span className="field-error">{error}</span> : null}
    </label>
  );
}

export function GesAccountForm({ account, cancelHref = '/ges' }: { account?: GesAccount; cancelHref?: string }) {
  const router = useRouter();
  const client = useQueryClient();
  const [form, setForm] = useState<GesFormState>(account ? formFromAccount(account) : emptyForm);
  const [errors, setErrors] = useState<Partial<Record<keyof GesFormState, string>>>({});
  const save = useMutation({
    mutationFn: () => account
      ? api.patch<GesAccount[]>(`/ges/${account.id}`, payload(form))
      : api.post<GesAccount[]>('/ges', payload(form)),
    onSuccess: async (accounts) => {
      toast.success(account ? 'GES account updated' : 'GES account added');
      client.setQueryData(['ges'], accounts);
      await client.invalidateQueries({ queryKey: ['dashboard'] });
      await client.invalidateQueries({ queryKey: ['ipp-catalog'] });
      router.push(account ? `/ges/${account.id}` : '/ges');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'GES account could not be saved'),
  });
  const requiredEnergy = useMemo(() => {
    if (form.annualConsumptionGwh === '' || form.renewableEnergyTargetPercent === '') return null;
    return form.annualConsumptionGwh * (form.renewableEnergyTargetPercent / 100);
  }, [form.annualConsumptionGwh, form.renewableEnergyTargetPercent]);
  const averageMonthly = form.annualConsumptionGwh === '' ? null : (form.annualConsumptionGwh * 1000) / 12;
  const states = withCurrent(STATES, form.state);
  const discoms = withCurrent(DISCOMS, form.discom);

  function submit(event: FormEvent) {
    event.preventDefault();
    const next = fieldErrors(form);
    setErrors(next);
    const first = Object.keys(next)[0];
    if (first) {
      document.getElementById(`ges-${first}`)?.scrollIntoView({ block: 'center', behavior: 'smooth' });
      return;
    }
    save.mutate();
  }

  function setText(key: keyof GesFormState, value: string) {
    setForm((current) => ({ ...current, [key]: value }));
    setErrors((current) => ({ ...current, [key]: undefined }));
  }

  function setNumber(key: keyof GesFormState, value: string) {
    setForm((current) => ({ ...current, [key]: value === '' ? '' : Number(value) }));
    setErrors((current) => ({ ...current, [key]: undefined }));
  }

  return (
    <>
      <PageHeader
        eyebrow="GES"
        title={account ? 'Edit GES' : 'Add GES'}
        description="Bill figures describe the current electricity account. The renewable target and supply year are the customer’s own requirement."
      />
      <section className="card">
        <form className="card-body" onSubmit={submit} noValidate>
          <div className="form-grid">
            <Section title="1. Basic information" text="Who the subscriber is and which DISCOM supplies them." />
            <Field label="GES / account name" badge="Customer input" error={errors.name}><input id="ges-name" value={form.name} onChange={(event) => setText('name', event.target.value)} placeholder="Account name" aria-invalid={Boolean(errors.name)} /></Field>
            <Field label="Legal name" badge="Customer input" error={errors.legalName}><input id="ges-legalName" value={form.legalName} onChange={(event) => setText('legalName', event.target.value)} placeholder="Registered legal name" aria-invalid={Boolean(errors.legalName)} /></Field>
            <Field label="Business type" badge="Customer input" error={errors.businessType}>
              <select id="ges-businessType" value={form.businessType} onChange={(event) => setText('businessType', event.target.value)} aria-invalid={Boolean(errors.businessType)}>
                <option value="">Select business type</option>
                {withCurrent(BUSINESS_TYPES, form.businessType).map((item) => <option key={item} value={item}>{item}</option>)}
              </select>
            </Field>
            <Field label="Consumer number" badge="Customer input"><input value={form.consumerNumbers} onChange={(event) => setForm({ ...form, consumerNumbers: event.target.value })} placeholder="DISCOM consumer number" /></Field>
            <Field label="City" badge="Customer input" error={errors.location}><input id="ges-location" value={form.location} onChange={(event) => setText('location', event.target.value)} aria-invalid={Boolean(errors.location)} /></Field>
            <Field label="State" badge="Customer input" error={errors.state}>
              <select id="ges-state" value={form.state} onChange={(event) => setText('state', event.target.value)} aria-invalid={Boolean(errors.state)}>
                <option value="">Select state</option>
                {states.map((item) => <option key={item} value={item}>{item}</option>)}
              </select>
            </Field>
            <Field label="DISCOM" badge="Customer input" error={errors.discom}>
              <select id="ges-discom" value={form.discom} onChange={(event) => setText('discom', event.target.value)} aria-invalid={Boolean(errors.discom)}>
                <option value="">Select DISCOM</option>
                {discoms.map((item) => <option key={item} value={item}>{item}</option>)}
              </select>
            </Field>
            <Field label="Target supply start year" badge="Customer input" error={errors.targetSupplyStartYear}><input id="ges-targetSupplyStartYear" type="number" inputMode="numeric" value={form.targetSupplyStartYear} onChange={(event) => setNumber('targetSupplyStartYear', event.target.value)} placeholder="Year" aria-invalid={Boolean(errors.targetSupplyStartYear)} /></Field>

            <Section title="2. Electricity profile" text="The customer’s present supply. Leave a field blank when the bill figure is not available." />
            <Field label="Annual electricity consumption (GWh/year)" badge="Electricity profile" kind="stored" error={errors.annualConsumptionGwh}><input id="ges-annualConsumptionGwh" type="number" inputMode="decimal" min={0} step="any" value={form.annualConsumptionGwh} onChange={(event) => setNumber('annualConsumptionGwh', event.target.value)} placeholder="GWh/year" aria-invalid={Boolean(errors.annualConsumptionGwh)} /></Field>
            <Field label="Average monthly consumption (MWh/month)" badge="Auto calculated" kind="calculated"><div className="readonly-value">{averageMonthly === null ? 'Not specified' : averageMonthly.toLocaleString('en-IN', { maximumFractionDigits: 3 })}</div></Field>
            <Field label="Peak recorded demand (kVA)" badge="Electricity profile" kind="stored" error={errors.peakRecordedDemandKva}><input id="ges-peakRecordedDemandKva" type="number" inputMode="decimal" min={0} step="any" value={form.peakRecordedDemandKva} onChange={(event) => setNumber('peakRecordedDemandKva', event.target.value)} placeholder="kVA" aria-invalid={Boolean(errors.peakRecordedDemandKva)} /></Field>
            <Field label="Contract demand (kVA)" badge="Electricity profile" kind="stored" error={errors.contractDemandKva}><input id="ges-contractDemandKva" type="number" inputMode="decimal" min={0} step="any" value={form.contractDemandKva} onChange={(event) => setNumber('contractDemandKva', event.target.value)} placeholder="kVA" aria-invalid={Boolean(errors.contractDemandKva)} /></Field>
            <Field label="Sanctioned load (kW)" badge="Electricity profile" kind="stored" error={errors.sanctionedLoadKw}><input id="ges-sanctionedLoadKw" type="number" inputMode="decimal" min={0} step="any" value={form.sanctionedLoadKw} onChange={(event) => setNumber('sanctionedLoadKw', event.target.value)} placeholder="kW" aria-invalid={Boolean(errors.sanctionedLoadKw)} /></Field>
            <Field label="Existing rooftop solar (kW)" badge="Electricity profile" kind="stored" error={errors.existingRooftopSolarKw}><input id="ges-existingRooftopSolarKw" type="number" inputMode="decimal" min={0} step="any" value={form.existingRooftopSolarKw} onChange={(event) => setNumber('existingRooftopSolarKw', event.target.value)} placeholder="kW" aria-invalid={Boolean(errors.existingRooftopSolarKw)} /></Field>
            <Field label="Solar connection type" badge="Electricity profile" kind="stored">
              <select value={form.solarConnectionType} onChange={(event) => setForm({ ...form, solarConnectionType: event.target.value })}>
                <option value="">Not specified</option>
                {withCurrent(SOLAR_CONNECTIONS, form.solarConnectionType).map((item) => <option key={item} value={item}>{item}</option>)}
              </select>
            </Field>

            <Section title="3. Renewable procurement requirement" text="The target percentage is the customer’s decision. Required energy is calculated from consumption." />
            <Field label="Renewable energy target (%)" badge="Customer input" error={errors.renewableEnergyTargetPercent}><input id="ges-renewableEnergyTargetPercent" type="number" inputMode="decimal" min={0} max={100} step="any" value={form.renewableEnergyTargetPercent} onChange={(event) => setNumber('renewableEnergyTargetPercent', event.target.value)} placeholder="%" aria-invalid={Boolean(errors.renewableEnergyTargetPercent)} /></Field>
            <Field label="Required renewable energy (GWh/year)" badge="Auto calculated" kind="calculated"><div className="readonly-value">{requiredEnergy === null ? '—' : requiredEnergy.toLocaleString('en-IN', { maximumFractionDigits: 4 })}</div></Field>

            <Section title="4. Procurement preference" text="Leave these blank when the customer has not chosen a technology or storage position." />
            <Field label="Preferred technology" badge="Customer input">
              <select value={form.preferredTechnology} onChange={(event) => setForm({ ...form, preferredTechnology: event.target.value })}>
                <option value="">Not specified</option>
                {TECHNOLOGIES.map((item) => <option key={item.value} value={item.value}>{item.label}</option>)}
              </select>
            </Field>
            <Field label="BESS requirement" badge="Customer input">
              <select value={form.bessRequirement} onChange={(event) => setForm({ ...form, bessRequirement: event.target.value })}>
                <option value="">Not specified</option>
                {BESS_REQUIREMENTS.map((item) => <option key={item.value} value={item.value}>{item.label}</option>)}
              </select>
            </Field>

            <Section title="5. Operating notes" text="Optional context for the account. This is not used to calculate energy." />
            <label className="form-field form-span">
              <span className="field-label">Operating notes <Badge kind="customer">Customer input</Badge></span>
              <textarea value={form.notes} onChange={(event) => setForm({ ...form, notes: event.target.value })} placeholder="Shift pattern, constraints, or other operating context" />
            </label>
          </div>
          <div className="card-tools" style={{ justifyContent: 'flex-start', marginTop: 12 }}>
            <button className="primary-button" type="submit" disabled={save.isPending}>{save.isPending ? 'Saving…' : account ? 'Save GES' : 'Add GES'}</button>
            <Link className="secondary-button" href={cancelHref}>Cancel</Link>
          </div>
        </form>
      </section>
    </>
  );
}
