'use client';

import { FormEvent, useEffect, useMemo, useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { ChevronDown } from 'lucide-react';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../components/DataState';
import { useAuth } from '../../features/auth/AuthProvider';
import { TariffNegotiationModal } from '../../features/negotiation/TariffNegotiationModal';
import { useWorkspace } from '../../features/workspace/WorkspaceProvider';
import { api } from '../../services/api';
import { IppCatalogRow } from '../../types/api';

type Kind = 'numeric' | 'text' | 'long';

interface Question {
  key: string;
  prompt: string;
  kind: Kind;
  unit?: string;
  value: string;
}

interface Section {
  id: string;
  title: string;
  intro?: string;
  rating: number | null;
  suggested: number | null;
  questions: Question[];
}

interface Questionnaire {
  gesId: string;
  gesName: string;
  ippId: string;
  ippName: string;
  answered: number;
  total: number;
  sections: Section[];
}

function suggest(kind: Kind, value: string) {
  const text = value.trim();
  if (!text) return null;
  if (kind === 'numeric') {
    const number = Number(text);
    if (!Number.isFinite(number)) return null;
    if (number <= 0) return 3;
    if (number < 10) return 6;
    if (number < 100) return 8;
    return 10;
  }
  if (text.length < 20) return 5;
  if (text.length < 120) return 7;
  return 9;
}

function suggestSection(section: Section, values: Record<string, string>) {
  const scores = section.questions
    .map((question) => suggest(question.kind, values[question.key] ?? ''))
    .filter((score): score is number => score != null);
  if (!scores.length) return '';
  return String(Math.round((scores.reduce((total, score) => total + score, 0) / scores.length) * 10) / 10);
}

export default function QuestionnairePage() {
  const { user } = useAuth();
  const { gesId } = useWorkspace();
  const client = useQueryClient();
  const accountId = user?.gesId || gesId;
  const canEdit = Boolean(user?.permissions.includes('GES_PROFILE_EDIT') || user?.permissions.includes('GES_EDIT'));
  const ipps = useQuery({
    queryKey: ['ipp-catalog'],
    queryFn: () => api.get<IppCatalogRow[]>('/ipp-catalog'),
    enabled: Boolean(accountId),
  });
  const orderedIpps = useMemo(() => [...(ipps.data ?? [])].sort((left, right) => {
    const leftNo = Number(left.referenceNo);
    const rightNo = Number(right.referenceNo);
    const leftRank = Number.isFinite(leftNo) && left.referenceNo?.trim() ? leftNo : 10000;
    const rightRank = Number.isFinite(rightNo) && right.referenceNo?.trim() ? rightNo : 10000;
    if (leftRank !== rightRank) return leftRank - rightRank;
    return left.name.localeCompare(right.name);
  }), [ipps.data]);
  const [ippId, setIppId] = useState('');
  useEffect(() => {
    if (!ippId && orderedIpps[0]) setIppId(orderedIpps[0].id);
  }, [ippId, orderedIpps]);
  const query = useQuery({
    queryKey: ['questionnaire', accountId, ippId],
    queryFn: () => api.get<Questionnaire>(`/ges/${accountId}/questionnaire?ippId=${ippId}`),
    enabled: Boolean(accountId && ippId),
  });
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [ratings, setRatings] = useState<Record<string, string>>({});
  const [lockedRatings, setLockedRatings] = useState<Set<string>>(new Set());
  const [active, setActive] = useState('');
  const [tariffOpen, setTariffOpen] = useState(false);

  useEffect(() => {
    if (!query.data) return;
    const nextAnswers: Record<string, string> = {};
    const nextRatings: Record<string, string> = {};
    const locked = new Set<string>();
    query.data.sections.forEach((section) => {
      section.questions.forEach((question) => {
        nextAnswers[question.key] = question.value;
      });
      const shown = section.rating ?? section.suggested;
      nextRatings[section.id] = shown == null ? '' : String(shown);
      if (section.rating != null) locked.add(section.id);
    });
    setAnswers(nextAnswers);
    setRatings(nextRatings);
    setLockedRatings(locked);
    setActive((current) => current || query.data.sections[0]?.id || '');
  }, [query.data]);

  const save = useMutation({
    mutationFn: () => api.put<Questionnaire>(`/ges/${accountId}/questionnaire`, {
      ippId,
      answers: Object.fromEntries(Object.keys(answers).map((key) => [key, answers[key] ?? ''])),
      sectionRatings: Object.fromEntries(Object.entries(ratings).map(([sectionId, value]) => [sectionId, value === '' ? null : Number(value)])),
    }),
    onSuccess: (saved) => {
      client.setQueryData(['questionnaire', accountId, ippId], saved);
      void client.invalidateQueries({ queryKey: ['scorecard', accountId] });
      toast.success('Questionnaire saved');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'Questionnaire could not be saved'),
  });

  const section = query.data?.sections.find((item) => item.id === active) ?? query.data?.sections[0];

  function changeAnswer(question: Question, value: string) {
    const owner = query.data?.sections.find((item) => item.questions.some((itemQuestion) => itemQuestion.key === question.key));
    setAnswers((current) => {
      const next = { ...current, [question.key]: value };
      if (owner && !lockedRatings.has(owner.id)) {
        setRatings((existing) => ({ ...existing, [owner.id]: suggestSection(owner, next) }));
      }
      return next;
    });
  }

  function submit(event: FormEvent) {
    event.preventDefault();
    save.mutate();
  }

  if (!accountId) {
    return (
      <AppShell>
        <PageHeader title="Questionnaire" description="Choose a GES account before answering." />
      </AppShell>
    );
  }
  if (ipps.isLoading || (ippId && query.isLoading)) return <AppShell><PageSkeleton variant="form" /></AppShell>;
  if (!orderedIpps.length) {
    return <AppShell><PageHeader title="Questionnaire" description="Add an IPP before answering the questionnaire." /></AppShell>;
  }
  if (query.isError || !query.data || !section) {
    return <AppShell><ErrorState message="The questionnaire could not be loaded." retry={() => void query.refetch()} /></AppShell>;
  }

  return (
    <AppShell>
      <PageHeader className="questionnaire-heading" title="IPP selection questionnaire">
        <label className="focus-select questionnaire-ipp">
          <span>IPP</span>
          <select value={ippId} onChange={(event) => setIppId(event.target.value)} aria-label="Questionnaire IPP">
            {orderedIpps.map((ipp) => <option key={ipp.id} value={ipp.id}>{ipp.referenceNo ? `${ipp.referenceNo}. ` : ''}{ipp.name}</option>)}
          </select>
          <ChevronDown size={14} />
        </label>
        <button className="secondary-button tariff-button" type="button" onClick={() => setTariffOpen(true)}>Tariff and negotiation</button>
      </PageHeader>
      <div className="questionnaire-layout">
        <nav className="card questionnaire-nav" aria-label="Questionnaire sections">
          {query.data.sections.map((item) => {
            const done = item.questions.filter((question) => answers[question.key]?.trim()).length;
            return (
              <button
                key={item.id}
                type="button"
                className={item.id === section.id ? 'questionnaire-link active' : 'questionnaire-link'}
                onClick={() => setActive(item.id)}
              >
                <span>{item.title}</span>
                <span className="questionnaire-meta">
                  <small>{done}/{item.questions.length}</small>
                  {ratings[item.id] ? <em className="score-badge">{ratings[item.id]}</em> : null}
                </span>
              </button>
            );
          })}
        </nav>
        <form id="questionnaire-form" className="card" onSubmit={submit}>
          <div className="card-body">
            <div className="form-section">
              <h3>{section.title}</h3>
              {section.intro && <p>{section.intro}</p>}
            </div>
            <div className="form-grid">
              {section.questions.map((question) => {
                const score = suggest(question.kind, answers[question.key] ?? '');
                return (
                <label key={question.key} className={question.kind === 'long' ? 'form-field form-span' : 'form-field'}>
                  <span>
                    {question.prompt}
                    {question.unit ? ` (${question.unit})` : ''}
                    <small className="field-badge">{question.kind === 'numeric' ? 'Number' : 'Text'}</small>
                    {score != null && <small className="field-badge score-badge">{score}/10</small>}
                  </span>
                  {question.kind === 'long' ? (
                    <textarea
                      value={answers[question.key] ?? ''}
                      onChange={(event) => changeAnswer(question, event.target.value)}
                      disabled={!canEdit}
                      maxLength={4000}
                    />
                  ) : (
                    <input
                      type={question.kind === 'numeric' ? 'number' : 'text'}
                      inputMode={question.kind === 'numeric' ? 'decimal' : 'text'}
                      step={question.kind === 'numeric' ? 'any' : undefined}
                      value={answers[question.key] ?? ''}
                      onChange={(event) => changeAnswer(question, event.target.value)}
                      disabled={!canEdit}
                      maxLength={question.kind === 'text' ? 4000 : undefined}
                    />
                  )}
                </label>
                );
              })}
            </div>
            <label className="section-rating">
              <span className="section-rating-copy">
                <strong>Section rating</strong>
                <small>One score out of 10 for this section. Saving it updates the IPP comparator.</small>
              </span>
              <span className="section-score">
                <input
                  type="number"
                  min={0}
                  max={10}
                  step="0.1"
                  aria-label={`${section.title} rating out of 10`}
                  value={ratings[section.id] ?? ''}
                  disabled={!canEdit}
                  onChange={(event) => {
                    setLockedRatings((current) => new Set(current).add(section.id));
                    setRatings((current) => ({ ...current, [section.id]: event.target.value }));
                  }}
                />
                <span aria-hidden="true">/10</span>
              </span>
            </label>
            {canEdit && (
              <div className="section-rating-actions">
                <button className="primary-button" type="submit" disabled={save.isPending}>{save.isPending ? 'Saving…' : 'Save answers'}</button>
              </div>
            )}
          </div>
        </form>
      </div>
      {tariffOpen && ippId && <TariffNegotiationModal gesId={accountId} ippId={ippId} canEdit={canEdit} onClose={() => setTariffOpen(false)} />}
    </AppShell>
  );
}
