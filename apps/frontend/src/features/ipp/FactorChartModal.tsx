'use client';

import { useLayoutEffect, useRef, useState } from 'react';
import { createPortal } from 'react-dom';
import { useQuery } from '@tanstack/react-query';
import { PolarAngleAxis, PolarGrid, PolarRadiusAxis, Radar, RadarChart, ResponsiveContainer, Tooltip } from 'recharts';
import { CHART_COLORS, CHART_THEME } from '../../constants/demo';
import { findTerm } from '../terms/terms';
import { api } from '../../services/api';

interface Parameter {
  key: string;
  shortLabel: string;
  score: number;
  normalizedScore: number;
  weight: number;
  weightedContribution: number;
}

interface ComparisonPayload {
  selectedIpps: { ipp: { id: string; name: string }; evaluation: { overallScore: number; scored?: boolean; parameters: Parameter[] } }[];
}

function AxisTermTick({
  x = 0,
  y = 0,
  payload,
  textAnchor = 'middle',
}: {
  x?: number;
  y?: number;
  payload?: { value?: string };
  textAnchor?: 'inherit' | 'end' | 'start' | 'middle';
}) {
  const label = String(payload?.value ?? '');
  const entry = findTerm(label);
  const anchor = useRef<DOMRect | null>(null);
  const panel = useRef<HTMLDivElement>(null);
  const [tip, setTip] = useState<{ left: number; top: number; ready: boolean } | null>(null);
  function open(rect: DOMRect) {
    anchor.current = rect;
    setTip({ left: rect.left, top: rect.bottom + 10, ready: false });
  }
  useLayoutEffect(() => {
    if (!tip || tip.ready || !panel.current || !anchor.current) return;
    const box = panel.current.getBoundingClientRect();
    const rect = anchor.current;
    const margin = 12;
    const gap = 10;
    let left = rect.left + rect.width / 2 - box.width / 2;
    if (left + box.width > window.innerWidth - margin) left = window.innerWidth - box.width - margin;
    if (left < margin) left = margin;
    const below = rect.bottom + gap;
    const top = below + box.height > window.innerHeight - margin ? Math.max(margin, rect.top - box.height - gap) : below;
    setTip({ left, top, ready: true });
  }, [tip]);
  return (
    <g>
      <text
        x={x}
        y={y}
        textAnchor={textAnchor}
        fill={CHART_THEME.tick}
        fontSize={11}
        style={{ cursor: entry ? 'pointer' : 'default' }}
        onMouseEnter={(event) => {
          if (!entry) return;
          open(event.currentTarget.getBoundingClientRect());
        }}
        onMouseLeave={() => setTip(null)}
        onFocus={(event) => {
          if (!entry) return;
          open(event.currentTarget.getBoundingClientRect());
        }}
        onBlur={() => setTip(null)}
      >
        {label}
      </text>
      {tip && entry && createPortal(
        <div ref={panel} className="term-float" role="tooltip" style={{ left: tip.left, top: tip.top, visibility: tip.ready ? 'visible' : 'hidden' }}>
          <strong>{entry.title}</strong>
          <span>{entry.description}</span>
          <em>Why it matters</em>
          <span>{entry.why}</span>
        </div>,
        document.body,
      )}
    </g>
  );
}

const FACTOR_LABELS = [
  ['execution', 'Execution Record'],
  ['financial', 'Financial Capability'],
  ['ehv', 'EHV Capability'],
  ['engineering', 'Engineering'],
  ['fdre', 'FDRE Capability'],
  ['epc', 'EPC/Procurement'],
  ['cod', 'COD Certainty'],
  ['capex', 'CAPEX Credibility'],
  ['tariff', 'Tariff Sustainability'],
  ['regulatory', 'Regulatory Protection'],
] as const;

export function FactorChartModal({
  gesId,
  ippId,
  ippName,
  onClose,
  snapshot,
}: {
  gesId: string;
  ippId: string;
  ippName: string;
  onClose: () => void;
  snapshot?: { overallScore: number; scored?: boolean; parameters: Parameter[] };
}) {
  const query = useQuery({
    queryKey: ['scorecard', gesId, ippId],
    queryFn: () => api.get<ComparisonPayload>(`/ges/${gesId}/comparison?ippIds=${ippId}`),
    enabled: Boolean(gesId && ippId) && !snapshot,
  });
  const evaluation = snapshot ?? (query.data?.selectedIpps.find((item) => item.ipp.id === ippId) ?? query.data?.selectedIpps[0])?.evaluation;
  const scored = evaluation?.scored === true;
  const points = FACTOR_LABELS.map(([key, label]) => {
    const parameter = evaluation?.parameters.find((item) => item.key === key);
    const factorWeight = parameter?.weight || { execution: 10, financial: 10, ehv: 10, engineering: 10, fdre: 10, epc: 10, cod: 15, capex: 10, tariff: 10, regulatory: 5 }[key];
    const contribution = parameter?.weightedContribution ?? 0;
    return {
      factor: label,
      score: parameter?.normalizedScore ?? (factorWeight ? (contribution / factorWeight) * 100 : 0),
      raw: parameter?.score ?? 0,
      weight: factorWeight,
      contribution,
    };
  });

  return (
    <div className="modal-backdrop" onMouseDown={onClose}>
      <div className="tariff-modal" role="dialog" aria-modal="true" aria-labelledby="factor-chart-title" onMouseDown={(event) => event.stopPropagation()}>
        <header className="tariff-modal-head">
          <div>
            <p className="eyebrow">Capability profile</p>
            <h2 id="factor-chart-title">{ippName}</h2>
            <p>The same ten factors as the IPP comparator. Hover a factor name for what it means. Score is normalized 0–100.</p>
          </div>
          <button className="small-button" type="button" onClick={onClose}>Close</button>
        </header>
        <div className="card-body">
          {!snapshot && query.isLoading && <p className="tariff-status">Loading the factor chart…</p>}
          {!snapshot && query.isError && <p className="tariff-status">The factor chart could not be loaded for this GES.</p>}
          {evaluation && !scored && (
            <p className="tariff-status">No questionnaire ratings for this IPP yet. The chart uses those section ratings, so the placeholder scores are not shown.</p>
          )}
          {evaluation && scored && (
            <>
              <div className="chart-wrap chart-wrap-modal">
                <ResponsiveContainer width="100%" height="100%">
                  <RadarChart data={points} outerRadius="72%">
                    <PolarGrid stroke={CHART_THEME.grid} />
                    <PolarAngleAxis dataKey="factor" tick={<AxisTermTick />} />
                    <PolarRadiusAxis angle={90} domain={[0, 100]} tick={{ fill: CHART_THEME.tickSoft, fontSize: 9 }} axisLine={false} tickCount={5} />
                    <Radar name={ippName} dataKey="score" stroke={CHART_COLORS[0]} fill={CHART_COLORS[0]} fillOpacity={0.16} strokeWidth={2} />
                    <Tooltip content={({ active, payload, label }) => {
                      if (!active || !payload?.length) return null;
                      const row = payload[0].payload as { raw: number; score: number; weight: number; contribution: number };
                      return (
                        <div className="chart-tooltip">
                          <strong>{label}</strong>
                          <span style={{ color: CHART_COLORS[0] }}>{ippName}: {row.raw.toFixed(1)}/5 · {Math.round(row.score)}/100 · weight {row.weight}</span>
                          <span>Scorecard {row.contribution}/{row.weight}</span>
                        </div>
                      );
                    }} />
                  </RadarChart>
                </ResponsiveContainer>
              </div>
              <p className="tariff-status" style={{ marginTop: 8 }}>Comparator total: {evaluation.overallScore || '—'}/100</p>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
