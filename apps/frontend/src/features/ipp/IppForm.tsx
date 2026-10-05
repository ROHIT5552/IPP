'use client';

import Link from 'next/link';
import { FormEvent, ReactNode, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { toast } from 'sonner';
import { PageHeader } from '../../components/AppShell';
import { api } from '../../services/api';
import { IppCatalogRow } from '../../types/api';
import {
  COD_CONFIDENCE,
  FDRE_OPTIONS,
  FINANCIAL_MODEL,
  FUNDING_STATUS,
  GENERATION_INTERVALS,
  GRID_CONNECTIVITY,
  GRID_VOLTAGES,
  IPP_TECHNOLOGIES,
  OPEN_ACCESS,
  PROJECT_STATUSES,
  STATES,
  TARIFF_TYPES,
  connectivityValue,
  includesBess,
  withCurrent,
} from './options';

type NumberField = number | '';

const emptyForm = {
  name: '',
  projectName: '',
  headquarters: '',
  projectState: '',
  projectDistrict: '',
  projectLocation: '',
  technology: '',
  solarMw: '' as NumberField,
  windMw: '' as NumberField,
  bessMw: '' as NumberField,
  bessMwh: '' as NumberField,
  annualGenerationGwh: '' as NumberField,
  p90Gwh: '' as NumberField,
  generationData15Min: '',
  fdreCapability: '',
  gridVoltage: '',
  gridConnectivity: '',
  openAccessReadiness: '',
  quotedTariff: '' as NumberField,
  tariffType: '',
  contractTenureYears: '' as NumberField,
  projectStatus: '',
  codYear: '' as NumberField,
  codConfidence: '',
  financialModelAvailable: '',
  fundingStatus: '',
  estimatedCapexCr: '' as NumberField,
};

type IppFormState = typeof emptyForm;

function blankNumber(value: number | null | undefined): NumberField {
  return value == null || value <= 0 ? '' : value;
}

function formFromAccount(account: IppCatalogRow): IppFormState {
  return {
    name: account.name,
    projectName: account.projectName || '',
    headquarters: account.headquarters === 'Not specified' ? '' : account.headquarters,
    projectState: account.projectState || '',
    projectDistrict: account.projectDistrict || '',
    projectLocation: account.projectLocation || '',
    technology: account.technology || '',
    solarMw: blankNumber(account.solarMw),
    windMw: blankNumber(account.windMw),
    bessMw: blankNumber(account.bessMw),
    bessMwh: blankNumber(account.bessMwh),
    annualGenerationGwh: blankNumber(account.annualGenerationGwh),
    p90Gwh: blankNumber(account.p90Gwh),
    generationData15Min: account.generationData15Min || '',
    fdreCapability: account.fdreCapability || '',
    gridVoltage: account.gridVoltage || '',
    gridConnectivity: connectivityValue(account.gridConnectivity, account.engineConnectivity),
    openAccessReadiness: account.openAccessReadiness || '',
    quotedTariff: account.tariff > 0 ? account.tariff : '',
    tariffType: account.tariffType || '',
    contractTenureYears: blankNumber(account.contractTenureYears),
    projectStatus: account.projectStatus || '',
    codYear: account.codYear && account.codYear > 0 ? account.codYear : '',
    codConfidence: account.codConfidence || '',
    financialModelAvailable: account.financialModelAvailable || '',
    fundingStatus: account.fundingStatus || '',
    estimatedCapexCr: blankNumber(account.estimatedCapexCr),
  };
}

function numeric(value: NumberField) {
  return value === '' ? null : value;
}

function payload(form: IppFormState) {
  const storage = includesBess(form.technology);
  return {
    name: form.name,
    projectName: form.projectName,
    headquarters: form.headquarters,
    projectState: form.projectState,
    projectDistrict: form.projectDistrict,
    projectLocation: form.projectLocation,
    technology: form.technology,
    solarMw: numeric(form.solarMw),
    windMw: numeric(form.windMw),
    bessMw: storage ? numeric(form.bessMw) : null,
    bessMwh: storage ? numeric(form.bessMwh) : null,
    annualGenerationGwh: numeric(form.annualGenerationGwh),
    p90Gwh: numeric(form.p90Gwh),
    generationData15Min: form.generationData15Min,
    fdreCapability: form.fdreCapability,
    gridVoltage: form.gridVoltage,
    gridConnectivity: form.gridConnectivity,
    openAccessReadiness: form.openAccessReadiness,
    quotedTariff: numeric(form.quotedTariff),
    tariffType: form.tariffType,
    contractTenureYears: numeric(form.contractTenureYears),
    projectStatus: form.projectStatus,
    codYear: numeric(form.codYear),
    codConfidence: form.codConfidence,
    financialModelAvailable: form.financialModelAvailable,
    fundingStatus: form.fundingStatus,
    estimatedCapexCr: numeric(form.estimatedCapexCr),
  };
}

function Section({ title, text }: { title: string; text: string }) {
  return <div className="form-section"><h3>{title}</h3><p>{text}</p></div>;
}

function Field({ label, hint, children }: { label: string; hint?: string; children: ReactNode }) {
  return (
    <label className="form-field">
      <span>{label}{hint && <span className="field-tip" tabIndex={0} aria-label={hint}><span className="field-badge">Info</span><span className="field-tip-panel" role="tooltip">{hint}</span></span>}</span>
      {children}
    </label>
  );
}

function Select({ value, onChange, options, placeholder, required }: { value: string; onChange: (value: string) => void; options: string[]; placeholder: string; required?: boolean }) {
  return (
    <select value={value} onChange={(event) => onChange(event.target.value)} required={required}>
      <option value="">{placeholder}</option>
      {options.map((item) => <option key={item} value={item}>{item}</option>)}
    </select>
  );
}

export function IppAccountForm({ account, cancelHref = '/ipps' }: { account?: IppCatalogRow; cancelHref?: string }) {
  const router = useRouter();
  const client = useQueryClient();
  const [form, setForm] = useState<IppFormState>(account ? formFromAccount(account) : emptyForm);
  const save = useMutation({
    mutationFn: () => account
      ? api.patch<IppCatalogRow[]>(`/ipps/${account.id}`, payload(form))
      : api.post<IppCatalogRow[]>('/ipps', payload(form)),
    onSuccess: async (rows) => {
      toast.success(account ? 'Independent power producer updated' : 'Independent power producer added');
      client.setQueryData(['ipp-catalog'], rows);
      await client.invalidateQueries({ queryKey: ['dashboard'] });
      router.push(account ? `/ipps/${account.id}` : '/ipps');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'Independent power producer could not be saved'),
  });
  const storage = includesBess(form.technology);
  const duration = storage && typeof form.bessMw === 'number' && form.bessMw > 0 && typeof form.bessMwh === 'number' && form.bessMwh > 0
    ? form.bessMwh / form.bessMw
    : null;

  function submit(event: FormEvent) {
    event.preventDefault();
    save.mutate();
  }

  function setNumber(key: keyof IppFormState, value: string) {
    setForm((current) => ({ ...current, [key]: value === '' ? '' : Number(value) }));
  }

  return (
    <>
      <PageHeader
        eyebrow="INDEPENDENT POWER PRODUCER"
        title={account ? 'Edit independent power producer' : 'Add independent power producer'}
        description="Company and project are kept separate. Capacity, generation, tariff, and readiness are what the comparator uses."
      />
      <section className="card">
        <form className="card-body" onSubmit={submit}>
          <div className="form-grid">
            <Section title="Basic information" text="The company can own more than one project. Headquarters is the company office, not the plant site." />
            <Field label="IPP name"><input value={form.name} onChange={(event) => setForm({ ...form, name: event.target.value })} placeholder="Company name" required /></Field>
            <Field label="Project name"><input value={form.projectName} onChange={(event) => setForm({ ...form, projectName: event.target.value })} placeholder="Project name" required /></Field>
            <Field label="Headquarters"><input value={form.headquarters} onChange={(event) => setForm({ ...form, headquarters: event.target.value })} placeholder="City, state" /></Field>
            <Field label="Project state">
              <Select value={form.projectState} onChange={(projectState) => setForm({ ...form, projectState })} options={withCurrent(STATES, form.projectState)} placeholder="Select state" required />
            </Field>
            <Field label="Project district"><input value={form.projectDistrict} onChange={(event) => setForm({ ...form, projectDistrict: event.target.value })} placeholder="District" /></Field>
            <Field label="Project location"><input value={form.projectLocation} onChange={(event) => setForm({ ...form, projectLocation: event.target.value })} placeholder="Site or village" /></Field>
            <Field label="Technology">
              <Select value={form.technology} onChange={(technology) => setForm({ ...form, technology })} options={withCurrent(IPP_TECHNOLOGIES, form.technology)} placeholder="Select technology" required />
            </Field>

            <Section title="Capacity" text="Enter the capacity that matches the technology. Storage duration is calculated." />
            <Field label="Solar capacity (MW)"><input type="number" min={0} step="0.1" value={form.solarMw} onChange={(event) => setNumber('solarMw', event.target.value)} placeholder="MW" /></Field>
            <Field label="Wind capacity (MW)"><input type="number" min={0} step="0.1" value={form.windMw} onChange={(event) => setNumber('windMw', event.target.value)} placeholder="MW" /></Field>
            {storage ? (
              <>
                <Field label="BESS power (MW)"><input type="number" min={0} step="0.1" value={form.bessMw} onChange={(event) => setNumber('bessMw', event.target.value)} placeholder="MW" /></Field>
                <Field label="BESS storage (MWh)"><input type="number" min={0} step="0.1" value={form.bessMwh} onChange={(event) => setNumber('bessMwh', event.target.value)} placeholder="MWh" /></Field>
                <Field label="BESS duration (hours)"><div className="readonly-value">{duration === null ? '—' : `${duration.toLocaleString('en-IN', { maximumFractionDigits: 2 })} hours`}</div></Field>
              </>
            ) : (
              <>
                <Field label="BESS power (MW)"><div className="readonly-value">—</div></Field>
                <Field label="BESS storage (MWh)"><div className="readonly-value">—</div></Field>
                <Field label="BESS duration (hours)"><div className="readonly-value">—</div></Field>
              </>
            )}

            <Section title="Generation" text="Annual generation is the expected yearly output. P90 is optional until a conservative estimate is available." />
            <Field label="Annual generation (GWh/year)"><input type="number" min={0.1} step="0.1" value={form.annualGenerationGwh} onChange={(event) => setNumber('annualGenerationGwh', event.target.value)} placeholder="GWh/year" required /></Field>
            <Field label="P90 generation (GWh/year)" hint="Conservative expected annual generation estimate."><input type="number" min={0} step="0.1" value={form.p90Gwh} onChange={(event) => setNumber('p90Gwh', event.target.value)} placeholder="GWh/year" /></Field>
            <Field label="15-minute generation data" hint="Indicates whether detailed generation data at 15-minute intervals is available.">
              <Select value={form.generationData15Min} onChange={(generationData15Min) => setForm({ ...form, generationData15Min })} options={GENERATION_INTERVALS} placeholder="Not specified" />
            </Field>
            <Field label="Firm / FDRE capability" hint="Indicates whether the project can provide renewable supply in a more controlled or firm manner.">
              <Select value={form.fdreCapability} onChange={(fdreCapability) => setForm({ ...form, fdreCapability })} options={FDRE_OPTIONS} placeholder="Not specified" />
            </Field>

            <Section title="Grid and connectivity" text="Use the status that has actually been reached. Leave a field blank when it is not known." />
            <Field label="Grid voltage">
              <Select value={form.gridVoltage} onChange={(gridVoltage) => setForm({ ...form, gridVoltage })} options={withCurrent(GRID_VOLTAGES, form.gridVoltage)} placeholder="Not specified" />
            </Field>
            <Field label="Grid connectivity">
              <Select value={form.gridConnectivity} onChange={(gridConnectivity) => setForm({ ...form, gridConnectivity })} options={withCurrent(GRID_CONNECTIVITY, form.gridConnectivity)} placeholder="Not specified" />
            </Field>
            <Field label="Open access readiness">
              <Select value={form.openAccessReadiness} onChange={(openAccessReadiness) => setForm({ ...form, openAccessReadiness })} options={OPEN_ACCESS} placeholder="Not specified" />
            </Field>

            <Section title="Commercial" text="Tariff is the offered price. Tenure and tariff type can be added later." />
            <Field label="Tariff (₹/kWh)"><input type="number" min={0.01} step="0.01" value={form.quotedTariff} onChange={(event) => setNumber('quotedTariff', event.target.value)} placeholder="₹/kWh" required /></Field>
            <Field label="Tariff type">
              <Select value={form.tariffType} onChange={(tariffType) => setForm({ ...form, tariffType })} options={TARIFF_TYPES} placeholder="Not specified" />
            </Field>
            <Field label="Contract tenure (years)"><input type="number" min={1} step="1" value={form.contractTenureYears} onChange={(event) => setNumber('contractTenureYears', event.target.value)} placeholder="Years" /></Field>

            <Section title="Execution" text="Expected COD is the year the project is planned to start supply. Leave it blank if the year is not known." />
            <Field label="Project status">
              <Select value={form.projectStatus} onChange={(projectStatus) => setForm({ ...form, projectStatus })} options={withCurrent(PROJECT_STATUSES, form.projectStatus)} placeholder="Not specified" />
            </Field>
            <Field label="Expected COD year"><input type="number" min={2024} max={2045} value={form.codYear} onChange={(event) => setNumber('codYear', event.target.value)} placeholder="Year" /></Field>
            <Field label="COD confidence" hint="Internal confidence level for the expected commercial operation date.">
              <Select value={form.codConfidence} onChange={(codConfidence) => setForm({ ...form, codConfidence })} options={COD_CONFIDENCE} placeholder="Not specified" />
            </Field>

            <Section title="Financial summary" text="A short funding position only. Detailed returns stay in the project record." />
            <Field label="Financial model available">
              <Select value={form.financialModelAvailable} onChange={(financialModelAvailable) => setForm({ ...form, financialModelAvailable })} options={FINANCIAL_MODEL} placeholder="Not specified" />
            </Field>
            <Field label="Funding status">
              <Select value={form.fundingStatus} onChange={(fundingStatus) => setForm({ ...form, fundingStatus })} options={FUNDING_STATUS} placeholder="Not specified" />
            </Field>
            <Field label="Estimated CAPEX (₹ crore)"><input type="number" min={0} step="0.1" value={form.estimatedCapexCr} onChange={(event) => setNumber('estimatedCapexCr', event.target.value)} placeholder="₹ crore" /></Field>
          </div>
          <div className="card-tools" style={{ justifyContent: 'flex-start', marginTop: 12 }}>
            <button className="primary-button" type="submit" disabled={save.isPending}>{save.isPending ? 'Saving…' : account ? 'Save IPP' : 'Add IPP'}</button>
            <Link className="secondary-button" href={cancelHref}>Cancel</Link>
          </div>
        </form>
      </section>
    </>
  );
}
