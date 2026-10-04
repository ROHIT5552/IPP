'use client';

import { useParams } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { BookOpenCheck, Download, FileText } from 'lucide-react';
import { AppShell, PageHeader } from '../../../../components/AppShell';
import { ErrorState, LoadingState } from '../../../../components/DataState';
import { StatusPill } from '../../../../components/StatusPill';
import { api } from '../../../../services/api';

interface DealbookRecord {
  ges: { code: string; name: string; requirement: { annualEnergyGwh: number; peakDemandMw: number; targetCodYear: number } };
  ipp: { id: string; code: string; name: string };
  evaluation: { overallScore: number; parameters: { label: string; score: number; weight: number; weightedContribution: number }[] };
  suitability: { overallPct: number; status: string; dimensions: { label: string; score: number; weight: number }[] };
  gates: { name: string; status: string; rationale: string }[];
  redFlags: { severity: string; title: string; detail: string }[];
  technical: Record<string, string | number | boolean>;
  commercial: { tariff: { scenarioTariff: number; sustainability: string }; capexInrCr: number; annualGenerationGwh: number; p90Gwh: number; codYear: number };
  financial: { score: number; dscr: number; interestRatePct: number; lender: string };
  generation: { requiredGwh: number; availableGwh: number; matchedGwh: number; coveragePct: number; loadMatchPct: number };
  bess: { powerMw: number; energyMwh: number; durationHours: number; yearSnapshots: { year: number; usableMwh: number }[] };
  ehv: { status: string; capabilityScore: number; projectApprovalConfirmed: boolean };
  negotiationHistory: { id: string; version: number; tariff: number; status: string; offerType: string; createdAt: string }[];
  documents: { id: string; title: string; status: string; version: number; pendingFrom: string }[];
  tasks: { id: string; title: string; owner: string; pendingFrom: string; dueDate: string; priority: string }[];
  conditions: { name: string; status: string; rationale: string }[];
}

export default function DealbookPage() {
  const { gesId } = useParams<{ gesId: string }>();
  const query = useQuery({ queryKey: ['dealbook', gesId], queryFn: () => api.get<DealbookRecord[]>(`/ges/${gesId}/dealbook`) });
  if (query.isLoading) return <AppShell><LoadingState label="Compiling decision record" /></AppShell>;
  if (query.error || !query.data) return <AppShell><ErrorState message="The dealbook could not be compiled." retry={() => void query.refetch()} /></AppShell>;
  const records = query.data;
  const exportDealbook = () => {
    const report = records.map((record) => `${record.ipp.name}\nGES: ${record.ges.name}\nEvaluation: ${record.evaluation.overallScore}/100\nRequirement match: ${record.suitability.overallPct}%\nTariff: ₹${record.commercial.tariff.scenarioTariff}/kWh\nRequired checks: ${record.gates.map((gate) => `${gate.name}: ${gate.status}`).join('; ')}\nIssues: ${record.redFlags.map((flag) => flag.title).join('; ')}\n`).join('\n---\n');
    const link = document.createElement('a');
    link.href = URL.createObjectURL(new Blob([report], { type: 'text/plain' }));
    link.download = `${records[0]?.ges.code.toLowerCase().replace(' ', '-')}-dealbook.txt`;
    link.click();
    URL.revokeObjectURL(link.href);
  };
  return (
    <AppShell>
      <PageHeader eyebrow={`${records[0]?.ges.code} · DECISION RECORD`} title="Dealbook" description="A consolidated evidence record for evaluation, conditions, risks, and approvals.">
        <button className="secondary-button" onClick={exportDealbook}><Download size={14} /> Export record</button>
      </PageHeader>
      <div className="alert-strip"><BookOpenCheck size={14} /> The dealbook summarizes demo evidence only. Formal approvals and project-specific connectivity are not implied.</div>
      <div className="dealbook-grid">
        {records.map((record) => (
          <article className="card dealbook-card" key={record.ipp.id}>
            <div className="dealbook-head"><div><span className="tiny-label">{record.ipp.code} · {record.ges.code}</span><h2>{record.ipp.name}</h2><p>{record.ges.name}</p></div><div className="dealbook-score"><strong>{record.suitability.overallPct}%</strong><span>Requirement match</span></div></div>
            <div className="dealbook-metrics"><span><small>IPP evaluation</small><strong>{record.evaluation.overallScore}<i>/100</i></strong></span><span><small>Annual / P90</small><strong>{record.commercial.annualGenerationGwh.toLocaleString()} / {record.commercial.p90Gwh.toLocaleString()}<i> GWh</i></strong></span><span><small>Indicative tariff</small><strong>₹{record.commercial.tariff.scenarioTariff.toFixed(2)}<i> /kWh</i></strong></span><span><small>COD</small><strong>{record.commercial.codYear}</strong></span></div>
            <div className="divider" />
            <div className="dealbook-section-title"><strong>Required checks</strong><span>{record.gates.filter((gate) => gate.status !== 'PASS').length} still open</span></div>
            <div className="gate-mini">{record.gates.slice(0, 4).map((gate) => <div key={gate.name}><span>{gate.name}</span><StatusPill status={gate.status} /></div>)}</div>
            <div className="dealbook-section-title"><strong>Decision evidence</strong><span><FileText size={11} /> {record.documents.length} documents</span></div>
            <div className="evidence-mini">{record.documents.slice(0, 3).map((document) => <div key={document.id}><span>{document.title}</span><StatusPill status={document.status} /></div>)}</div>
            {record.redFlags.length > 0 && <div className="dealbook-risk"><strong>{record.redFlags.length} risks to resolve</strong><small>{record.redFlags.slice(0, 2).map((flag) => flag.title).join(' · ')}</small></div>}
          </article>
        ))}
      </div>
    </AppShell>
  );
}
