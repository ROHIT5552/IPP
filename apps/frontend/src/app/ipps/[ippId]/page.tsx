'use client';

import Link from 'next/link';
import { useEffect, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { Pencil } from 'lucide-react';
import { AppShell, PageHeader } from '../../../components/AppShell';
import { ErrorState, LoadingState } from '../../../components/DataState';
import { useAuth } from '../../../features/auth/AuthProvider';
import { connectivityValue, includesBess } from '../../../features/ipp/options';
import { api } from '../../../services/api';
import { IppCatalogRow } from '../../../types/api';

const SECTIONS = ['Overview', 'Generation', 'Technical', 'Grid and connectivity', 'BESS', 'Commercial', 'Financial', 'Execution', 'Regulatory', 'Documents', 'Evaluation'] as const;

function amount(value: number | null | undefined, digits = 1) {
  if (value == null || Number.isNaN(value)) return '—';
  return value.toLocaleString('en-IN', { maximumFractionDigits: digits });
}

function text(value?: string | null) {
  return value?.trim() ? value : 'Not specified';
}

function Item({ label, value }: { label: string; value: string }) {
  return <div className="info-item"><small>{label}</small><strong>{value}</strong></div>;
}

export default function IppDetailsPage() {
  const { ippId } = useParams<{ ippId: string }>();
  const { user } = useAuth();
  const router = useRouter();
  useEffect(() => {
    if (user?.gesId) router.replace(`/client/ipps/${ippId}`);
  }, [user, router, ippId]);
  const canEdit = user?.permissions.includes('IPP_EDIT') ?? false;
  const [section, setSection] = useState<(typeof SECTIONS)[number]>('Overview');
  const query = useQuery({ queryKey: ['ipp-catalog'], queryFn: () => api.get<IppCatalogRow[]>('/ipp-catalog') });
  const ipp = query.data?.find((item) => item.id === ippId);

  if (query.isLoading) return <AppShell><LoadingState /></AppShell>;
  if (!ipp) return <AppShell><ErrorState message="This independent power producer was not found." /></AppShell>;

  const storage = includesBess(ipp.technology) || ipp.bessMw > 0 || ipp.bessMwh > 0;
  const duration = ipp.bessMw > 0 && ipp.bessMwh > 0 ? ipp.bessMwh / ipp.bessMw : null;
  const bessText = !storage ? 'None' : ipp.bessMw > 0 || ipp.bessMwh > 0 ? `${amount(ipp.bessMw)} MW / ${amount(ipp.bessMwh)} MWh` : '—';
  const place = [ipp.projectLocation, ipp.projectDistrict, ipp.projectState].filter(Boolean).join(', ');

  return (
    <AppShell>
      <PageHeader eyebrow={ipp.code} title={ipp.name} description={ipp.projectName || 'Project name not specified'}>
        {canEdit && <Link className="primary-button" href={`/ipps/${ipp.id}/edit`}><Pencil size={14} /> Edit IPP</Link>}
      </PageHeader>
      <div className="ipp-section-nav">
        {SECTIONS.map((item) => (
          <button key={item} className={item === section ? 'small-button' : 'secondary-button'} type="button" onClick={() => setSection(item)}>{item}</button>
        ))}
      </div>
      <section className="card">
        <div className="card-body info-grid">
          {section === 'Overview' && (
            <>
              <Item label="IPP name" value={ipp.name} />
              <Item label="Project name" value={text(ipp.projectName)} />
              <Item label="Headquarters" value={text(ipp.headquarters)} />
              <Item label="Project location" value={text(place)} />
              <Item label="Technology" value={text(ipp.technology)} />
              <Item label="Solar capacity" value={ipp.solarMw > 0 ? `${amount(ipp.solarMw)} MW` : '—'} />
              <Item label="Wind capacity" value={ipp.windMw > 0 ? `${amount(ipp.windMw)} MW` : '—'} />
              <Item label="BESS" value={bessText} />
              <Item label="Annual generation" value={`${amount(ipp.annualGenerationGwh)} GWh/year`} />
              <Item label="P90 generation" value={ipp.p90Gwh ? `${amount(ipp.p90Gwh)} GWh/year` : '—'} />
              <Item label="Tariff" value={`₹${ipp.tariff.toFixed(2)}/kWh`} />
              <Item label="Expected COD" value={ipp.codYear && ipp.codYear > 0 ? String(ipp.codYear) : 'Not specified'} />
              <Item label="Project status" value={text(ipp.projectStatus)} />
              <Item label="Firm / FDRE capability" value={text(ipp.fdreCapability)} />
            </>
          )}
          {section === 'Generation' && (
            <>
              <Item label="Annual generation" value={`${amount(ipp.annualGenerationGwh)} GWh/year`} />
              <Item label="P90 generation" value={ipp.p90Gwh ? `${amount(ipp.p90Gwh)} GWh/year` : '—'} />
              <Item label="15-minute generation data" value={text(ipp.generationData15Min)} />
              <Item label="Firm / FDRE capability" value={text(ipp.fdreCapability)} />
            </>
          )}
          {section === 'Technical' && (
            <>
              <Item label="Technology" value={text(ipp.technology)} />
              <Item label="Solar capacity" value={ipp.solarMw > 0 ? `${amount(ipp.solarMw)} MW` : '—'} />
              <Item label="Wind capacity" value={ipp.windMw > 0 ? `${amount(ipp.windMw)} MW` : '—'} />
            </>
          )}
          {section === 'Grid and connectivity' && (
            <>
              <Item label="Grid voltage" value={text(ipp.gridVoltage)} />
              <Item label="Grid connectivity" value={text(connectivityValue(ipp.gridConnectivity, ipp.engineConnectivity) || null)} />
              <Item label="Open access readiness" value={text(ipp.openAccessReadiness)} />
            </>
          )}
          {section === 'BESS' && (
            <>
              <Item label="BESS power" value={storage && ipp.bessMw > 0 ? `${amount(ipp.bessMw)} MW` : storage ? '—' : 'None'} />
              <Item label="BESS storage" value={storage && ipp.bessMwh > 0 ? `${amount(ipp.bessMwh)} MWh` : storage ? '—' : 'None'} />
              <Item label="BESS duration" value={duration === null ? '—' : `${amount(duration, 2)} hours`} />
            </>
          )}
          {section === 'Commercial' && (
            <>
              <Item label="Tariff" value={`₹${ipp.tariff.toFixed(2)}/kWh`} />
              <Item label="Tariff type" value={text(ipp.tariffType)} />
              <Item label="Contract tenure" value={ipp.contractTenureYears ? `${amount(ipp.contractTenureYears, 0)} years` : 'Not specified'} />
            </>
          )}
          {section === 'Financial' && (
            <>
              <Item label="Financial model available" value={text(ipp.financialModelAvailable)} />
              <Item label="Funding status" value={text(ipp.fundingStatus)} />
              <Item label="Estimated CAPEX" value={ipp.estimatedCapexCr ? `₹${amount(ipp.estimatedCapexCr, 2)} crore` : '—'} />
            </>
          )}
          {section === 'Execution' && (
            <>
              <Item label="Project status" value={text(ipp.projectStatus)} />
              <Item label="Expected COD year" value={ipp.codYear && ipp.codYear > 0 ? String(ipp.codYear) : 'Not specified'} />
              <Item label="COD confidence" value={text(ipp.codConfidence)} />
            </>
          )}
          {section === 'Regulatory' && <Item label="Regulatory position" value="Not specified" />}
          {section === 'Documents' && <Item label="Documents" value="Not specified" />}
          {section === 'Evaluation' && <Item label="Scored comparison" value="Open a GES comparator to see this project’s evaluation." />}
        </div>
      </section>
    </AppShell>
  );
}
