'use client';

import { useMemo, useState } from 'react';
import { keepPreviousData, useQuery } from '@tanstack/react-query';
import { AppShell, PageHeader } from '../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../components/DataState';
import { useAuth } from '../../features/auth/AuthProvider';
import { FactorChartModal } from '../../features/ipp/FactorChartModal';
import { useWorkspace } from '../../features/workspace/WorkspaceProvider';
import { api } from '../../services/api';

interface ScoreIpp {
  ipp: { id: string; name: string; tariff: number | null };
  evaluation: { overallScore: number; scored?: boolean; parameters: { key: string; shortLabel: string; score: number; normalizedScore: number; weight: number; weightedContribution: number }[] };
  gates: { name: string; status: string }[];
  suitability: { status: string };
  tariff: { sustainability: string };
}

interface ComparisonPayload {
  providerOptions: { id: string; name: string }[];
  selectedIpps: ScoreIpp[];
}

const ROWS = [
  ['execution', 'Execution Record', 10],
  ['financial', 'Financial Capability', 10],
  ['ehv', 'EHV Capability', 10],
  ['engineering', 'Engineering', 10],
  ['fdre', 'FDRE Capability', 10],
  ['epc', 'EPC/Procurement', 10],
  ['cod', 'COD Certainty', 15],
  ['capex', 'CAPEX Credibility', 10],
  ['tariff', 'Tariff Sustainability', 10],
  ['regulatory', 'Regulatory Protection', 5],
] as const;

function points(ipp: ScoreIpp, key: string) {
  if (!ipp.evaluation.scored) return null;
  const row = ipp.evaluation.parameters.find((item) => item.key === key);
  return row ? row.weightedContribution : null;
}

function gateSummary(ipp: ScoreIpp) {
  if (!ipp.gates.length) return '—';
  const failed = ipp.gates.filter((gate) => gate.status === 'FAIL').length;
  const pending = ipp.gates.filter((gate) => gate.status !== 'PASS' && gate.status !== 'FAIL').length;
  if (failed) return 'Fail';
  if (pending) return 'Conditional';
  return 'Pass';
}

export default function ComparisonPage() {
  const { user } = useAuth();
  const { gesId } = useWorkspace();
  const accountId = user?.gesId || gesId;
  const [picked, setPicked] = useState<string[]>([]);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [draft, setDraft] = useState<string[]>([]);
  const [chart, setChart] = useState<ScoreIpp | null>(null);
  const query = useQuery({
    queryKey: ['scorecard', accountId, picked.join(',')],
    queryFn: () => api.get<ComparisonPayload>(`/ges/${accountId}/comparison${picked.length ? `?ippIds=${picked.join(',')}` : ''}`),
    enabled: Boolean(accountId),
    placeholderData: keepPreviousData,
  });
  const columns = useMemo(() => (query.data?.selectedIpps ?? []).slice(0, 4), [query.data]);

  const selectedIds = picked.length ? picked : columns.map((item) => item.ipp.id);

  function openPicker() {
    setDraft(selectedIds);
    setPickerOpen(true);
  }

  function toggleDraft(id: string) {
    setDraft((current) => {
      if (current.includes(id)) return current.filter((item) => item !== id);
      if (current.length >= 4) return current;
      return [...current, id];
    });
  }

  function submitPicker() {
    setPicked(draft.slice(0, 4));
    setPickerOpen(false);
  }

  if (!accountId) return <AppShell><PageHeader eyebrow="Comparison" title="IPP comparator" description="Choose a GES account first." /></AppShell>;
  if (query.isLoading) return <AppShell><PageSkeleton variant="table" /></AppShell>;
  if (query.isError || !query.data) return <AppShell><ErrorState message="The comparison could not be loaded." retry={() => void query.refetch()} /></AppShell>;

  return (
    <AppShell>
      <PageHeader className="page-heading-top" eyebrow="Final comparison" title="IPP comparator" description="For final comparison NewRa prepares this scorecard. Up to four IPPs.">
        <button className="secondary-button ipp-select-btn" type="button" onClick={openPicker}>
          <span>Selected IPPs</span>
          <span className="ipp-select-count">{columns.length}</span>
        </button>
      </PageHeader>
      <section className="card">
        <div className="data-table-wrap">
          <table className="data-table scorecard">
            <thead>
              <tr>
                <th>Parameter</th>
                {columns.map((item, index) => (
                  <th key={item.ipp.id}>
                    <div className="score-head">
                      IPP {index + 1}
                      <span className="number-sub">{item.ipp.name}</span>
                      <button className="small-button chart-button" type="button" onClick={() => setChart(item)}>View chart</button>
                    </div>
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {ROWS.map(([key, label, weight]) => (
                <tr key={key}>
                  <td>{label} /{weight}</td>
                  {columns.map((item) => <td key={item.ipp.id}>{points(item, key) ?? '—'}</td>)}
                </tr>
              ))}
              <tr>
                <td><strong>TOTAL /100</strong></td>
                {columns.map((item) => <td key={item.ipp.id}><strong>{item.evaluation.scored ? item.evaluation.overallScore : '—'}</strong></td>)}
              </tr>
              <tr>
                <td>Critical Gates</td>
                {columns.map((item) => <td key={item.ipp.id}>{item.evaluation.scored ? gateSummary(item) : '—'}</td>)}
              </tr>
              <tr>
                <td>Quoted Tariff</td>
                {columns.map((item) => <td key={item.ipp.id}>{item.ipp.tariff == null ? '—' : `₹${item.ipp.tariff}/kWh`}</td>)}
              </tr>
              <tr>
                <td>NewRa Risk-Adjusted View</td>
                {columns.map((item) => <td key={item.ipp.id}>{item.evaluation.scored ? item.tariff.sustainability || '—' : '—'}</td>)}
              </tr>
              <tr>
                <td>Status</td>
                {columns.map((item) => <td key={item.ipp.id}>{item.evaluation.scored ? (item.suitability.status || '—').replaceAll('_', ' ') : '—'}</td>)}
              </tr>
            </tbody>
          </table>
        </div>
      </section>
      {pickerOpen && (
        <div className="modal-backdrop" onMouseDown={() => setPickerOpen(false)}>
          <div className="tariff-modal ipp-picker-modal" role="dialog" aria-modal="true" aria-labelledby="ipp-picker-title" onMouseDown={(event) => event.stopPropagation()}>
            <header className="tariff-modal-head">
              <div>
                <p className="eyebrow">IPP comparator</p>
                <h2 id="ipp-picker-title">Select IPPs</h2>
                <p>Choose up to four IPPs. Checked names are already on the scorecard.</p>
              </div>
              <button className="small-button" type="button" onClick={() => setPickerOpen(false)}>Close</button>
            </header>
            <div className="ipp-picker-list">
              {query.data.providerOptions.map((option) => {
                const checked = draft.includes(option.id);
                return (
                  <label key={option.id} className={checked ? 'ipp-picker-row checked' : 'ipp-picker-row'}>
                    <input
                      type="checkbox"
                      checked={checked}
                      disabled={!checked && draft.length >= 4}
                      onChange={() => toggleDraft(option.id)}
                    />
                    <span>{option.name}</span>
                  </label>
                );
              })}
            </div>
            <footer className="tariff-modal-foot">
              <span>{draft.length} of 4 selected</span>
              <div className="card-tools">
                <button className="secondary-button" type="button" onClick={() => setPickerOpen(false)}>Cancel</button>
                <button className="primary-button" type="button" onClick={submitPicker} disabled={!draft.length}>Submit</button>
              </div>
            </footer>
          </div>
        </div>
      )}
      {chart && (
        <FactorChartModal
          gesId={accountId}
          ippId={chart.ipp.id}
          ippName={chart.ipp.name}
          snapshot={chart.evaluation}
          onClose={() => setChart(null)}
        />
      )}
    </AppShell>
  );
}
