'use client';

import { FormEvent, useState } from 'react';
import { useParams } from 'next/navigation';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { ArrowRight, Clock3, GitBranch, Plus } from 'lucide-react';
import { toast } from 'sonner';
import { AppShell, PageHeader } from '../../../../components/AppShell';
import { ErrorState, LoadingState } from '../../../../components/DataState';
import { StatusPill } from '../../../../components/StatusPill';
import { api } from '../../../../services/api';
import { OfferRecord, ProviderOption } from '../../../../types/api';

export default function NegotiationPage() {
  const { gesId } = useParams<{ gesId: string }>();
  const queryClient = useQueryClient();
  const [providerId, setProviderId] = useState('');
  const [draft, setDraft] = useState({
    tariff: 3.8,
    codYear: 2030,
    bessSummary: '4-hour storage capability subject to warranty review',
    paymentTerms: 'Monthly settlement; payment security to be agreed',
    changeInLaw: 'Symmetric change-in-law protection',
    curtailment: 'Curtailment allocation subject to agreed thresholds',
    performanceGuarantee: 'Generation and availability guarantees to be confirmed',
    riskAllocation: 'Grid-side delay allocated to responsible party',
    otherTerms: '',
  });
  const candidates = useQuery({
    queryKey: ['candidates', gesId],
    queryFn: () => api.get<ProviderOption[]>(`/ges/${gesId}/ipps`),
  });
  const offers = useQuery({
    queryKey: ['negotiations', gesId],
    queryFn: () => api.get<OfferRecord[]>(`/ges/${gesId}/negotiations`),
  });
  const create = useMutation({
    mutationFn: () => api.post<OfferRecord>(`/ges/${gesId}/negotiations/offers`, {
      ...draft,
      ippId: providerId,
      offerType: 'COUNTER_OFFER',
    }),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ['negotiations', gesId] });
      toast.success('Offer added as a new immutable version.');
    },
    onError: (error) => toast.error(error.message),
  });

  if (candidates.isLoading || offers.isLoading) return <AppShell><LoadingState label="Loading negotiation workbench" /></AppShell>;
  if (candidates.error || offers.error) return <AppShell><ErrorState message="Negotiation data could not be loaded. Check the user's commercial permissions." retry={() => { void candidates.refetch(); void offers.refetch(); }} /></AppShell>;
  const selected = candidates.data?.find((candidate) => candidate.id === providerId);

  function submit(event: FormEvent) {
    event.preventDefault();
    if (!providerId) {
      toast.error('Select an IPP before creating an offer.');
      return;
    }
    create.mutate();
  }

  return (
    <AppShell>
      <PageHeader eyebrow="COMMERCIAL WORKFLOW" title="Negotiation" description="Versioned offers preserve the negotiation trail; previous terms are never overwritten." />
      <div className="alert-strip"><GitBranch size={14} /> Requirement → provider shortlist → offer → counter offer → provider response → accepted, rejected, or revised.</div>
      <div className="content-grid equal">
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Create counter offer</h2><p className="card-subtitle">Every submission is appended as a new version.</p></div><Plus size={16} color="#5eead4" /></div>
          <div className="card-body">
            <form onSubmit={submit}>
              <div className="form-grid">
                <label className="form-field">Provider<select value={providerId} onChange={(event) => setProviderId(event.target.value)} required><option value="">Choose provider</option>{candidates.data?.map((candidate) => <option key={candidate.id} value={candidate.id}>{candidate.name}</option>)}</select></label>
                <label className="form-field">Counter tariff (₹/kWh)<input type="number" min="0.1" max="100" step="0.01" value={draft.tariff} onChange={(event) => setDraft({ ...draft, tariff: Number(event.target.value) })} required /></label>
                <label className="form-field">Target COD<input type="number" min="2026" max="2045" value={draft.codYear} onChange={(event) => setDraft({ ...draft, codYear: Number(event.target.value) })} required /></label>
                <label className="form-field">BESS terms<input value={draft.bessSummary} onChange={(event) => setDraft({ ...draft, bessSummary: event.target.value })} /></label>
                <label className="form-field">Payment terms<input value={draft.paymentTerms} onChange={(event) => setDraft({ ...draft, paymentTerms: event.target.value })} /></label>
                <label className="form-field">Change in law<input value={draft.changeInLaw} onChange={(event) => setDraft({ ...draft, changeInLaw: event.target.value })} /></label>
                <label className="form-field">Curtailment<input value={draft.curtailment} onChange={(event) => setDraft({ ...draft, curtailment: event.target.value })} /></label>
                <label className="form-field">Performance guarantee<input value={draft.performanceGuarantee} onChange={(event) => setDraft({ ...draft, performanceGuarantee: event.target.value })} /></label>
                <label className="form-field">Risk allocation<input value={draft.riskAllocation} onChange={(event) => setDraft({ ...draft, riskAllocation: event.target.value })} /></label>
                <label className="form-field">Other commercial terms<input value={draft.otherTerms} onChange={(event) => setDraft({ ...draft, otherTerms: event.target.value })} /></label>
              </div>
              {selected && <div className="scenario-result"><span>Current indicative tariff</span><strong>₹{(offers.data?.filter((offer) => offer.ippId === providerId).slice(-1)[0]?.tariff ?? 0).toFixed(2)}<small> /kWh</small></strong></div>}
              <div className="divider" />
              <button className="primary-button" type="submit" disabled={create.isPending}>{create.isPending ? 'Saving offer…' : 'Add offer version'} <ArrowRight size={14} /></button>
            </form>
          </div>
        </section>
        <section className="card">
          <div className="card-head"><div><h2 className="card-title">Offer history</h2><p className="card-subtitle">Offer values remain separately attributable by author and version.</p></div><span className="status-pill status-neutral">{offers.data?.length ?? 0} versions</span></div>
          <div className="card-body">
            {offers.data?.length ? [...offers.data].reverse().map((offer) => (
              <article className="offer-card" key={offer.id}>
                <div className="offer-heading"><div><span className="version-tag">v{offer.version}</span><strong>{candidates.data?.find((item) => item.id === offer.ippId)?.name}</strong></div><StatusPill status={offer.status} /></div>
                <div className="offer-price">₹{offer.tariff.toFixed(2)} <small>/kWh</small><span>COD {offer.codYear}</span></div>
                <div className="offer-meta"><span><Clock3 size={11} /> {new Date(offer.createdAt).toLocaleString()}</span><span>By {offer.createdBy}</span></div>
                <div className="offer-terms">{offer.paymentTerms || 'Commercial terms captured in offer record.'}</div>
              </article>
            )) : <div className="empty-state"><GitBranch size={22} /><div><strong>No offers yet</strong><span>Create an offer to begin the negotiation record.</span></div></div>}
          </div>
        </section>
      </div>
    </AppShell>
  );
}
