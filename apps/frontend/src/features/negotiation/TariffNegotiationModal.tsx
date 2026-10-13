'use client';

import { useEffect, useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { toast } from 'sonner';
import { api } from '../../services/api';

interface Round {
  ippTariff: string;
  gesOffer: string;
  finalisedRate: string;
}

interface BoardIpp {
  id: string;
  name: string;
  referenceNo: string;
  portfolioCapacity: string;
  headquarters: string;
  loiScope: string;
  rounds: Round[];
  updatedAt: string | null;
}

interface Board {
  gesId: string;
  gesName: string;
  rounds: number;
  ipps: BoardIpp[];
}

export function TariffNegotiationModal({
  gesId,
  ippId,
  canEdit,
  onClose,
}: {
  gesId: string;
  ippId: string;
  canEdit: boolean;
  onClose: () => void;
}) {
  const client = useQueryClient();
  const query = useQuery({
    queryKey: ['tariff-negotiations', gesId],
    queryFn: () => api.get<Board>(`/ges/${gesId}/tariff-negotiations`),
  });
  const [rows, setRows] = useState<Record<string, Round[]>>({});
  const [saved, setSaved] = useState('');

  useEffect(() => {
    if (!query.data) return;
    const next: Record<string, Round[]> = {};
    query.data.ipps.forEach((ipp) => {
      next[ipp.id] = ipp.rounds.map((round) => ({ ...round }));
    });
    setRows(next);
    setSaved(JSON.stringify(next));
  }, [query.data]);

  const dirty = JSON.stringify(rows) !== saved && Boolean(saved);

  const save = useMutation({
    mutationFn: async () => {
      const negotiations = Object.entries(rows).map(([ippId, rounds]) => ({ ippId, rounds }));
      return api.put<Board>(`/ges/${gesId}/tariff-negotiations`, { negotiations });
    },
    onSuccess: (board) => {
      client.setQueryData(['tariff-negotiations', gesId], board);
      const next: Record<string, Round[]> = {};
      board.ipps.forEach((ipp) => {
        next[ipp.id] = ipp.rounds.map((round) => ({ ...round }));
      });
      setRows(next);
      setSaved(JSON.stringify(next));
      toast.success('Tariff negotiation saved');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'Negotiation could not be saved'),
  });

  async function close() {
    if (canEdit && dirty && !save.isPending) {
      try {
        await save.mutateAsync();
      } catch {
        return;
      }
    }
    onClose();
  }

  useEffect(() => {
    function onKey(event: KeyboardEvent) {
      if (event.key === 'Escape') void close();
    }
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  });

  const current = query.data?.ipps.find((ipp) => ipp.id === ippId);
  const currentRounds = (current ? rows[current.id] ?? current.rounds : []).map((round) => ({
    ippTariff: round.ippTariff ?? '',
    gesOffer: round.gesOffer ?? '',
    finalisedRate: round.finalisedRate ?? '',
  }));
  const savedRounds = (() => {
    if (!current || !saved) return [] as Round[];
    try {
      const parsed = JSON.parse(saved) as Record<string, Round[]>;
      return parsed[current.id] ?? [];
    } catch {
      return [] as Round[];
    }
  })();

  function complete(round?: Round) {
    if (!round) return false;
    return [round.ippTariff, round.gesOffer, round.finalisedRate].every((value) => String(value ?? '').trim());
  }

  function roundState(index: number) {
    const locked = complete(savedRounds[index]);
    const open = index === 0 || complete(savedRounds[index - 1]);
    return { locked, editable: canEdit && open && !locked };
  }

  function updateRound(index: number, key: keyof Round, value: string) {
    if (!current || !roundState(index).editable) return;
    setRows((existing) => ({
      ...existing,
      [current.id]: (existing[current.id] ?? current.rounds).map((round, roundIndex) =>
        roundIndex === index ? { ...round, [key]: value } : round,
      ),
    }));
  }

  return (
    <div className="modal-backdrop" onMouseDown={() => void close()}>
      <div
        className="tariff-modal tariff-modal-locked"
        role="dialog"
        aria-modal="true"
        aria-labelledby="tariff-modal-title"
        onMouseDown={(event) => event.stopPropagation()}
      >
        <header className="tariff-modal-head">
          <div>
            <p className="eyebrow">Tariff and negotiation</p>
            <h2 id="tariff-modal-title">{current ? `${current.referenceNo ? `${current.referenceNo}. ` : ''}${current.name}` : 'Negotiation'}</h2>
            <p>{query.data?.gesName ? `${query.data.gesName}. ` : ''}Fill the IPP tariff, the GES offer, and the finalised rate. Saving a completed round locks it and opens the next.</p>
          </div>
          <button className="small-button" type="button" onClick={() => void close()}>Close</button>
        </header>
        {query.isLoading && <p className="tariff-status">Loading IPPs…</p>}
        {query.isError && <p className="tariff-status">The negotiation board could not be loaded.</p>}
        {query.data && !current && <p className="tariff-status">This IPP is not on the negotiation board.</p>}
        {query.data && current && (
          <div className="tariff-modal-body">
            <section>
                <div className="tariff-current">
                  <h3>{current.name}</h3>
                  <p>{[current.loiScope, current.headquarters].filter(Boolean).join(' · ') || 'Add the offer for each round.'}</p>
                </div>
                <div className="tariff-rounds">
                  {currentRounds.map((round, index) => {
                    const state = roundState(index);
                    return (
                    <fieldset key={index} className={state.locked ? 'tariff-round locked' : 'tariff-round'}>
                      <legend>Round {index + 1}</legend>
                      <label>
                        IPP tariff rate
                        <input
                          inputMode="decimal"
                          placeholder="₹/kWh"
                          value={round.ippTariff}
                          disabled={!state.editable}
                          onChange={(event) => updateRound(index, 'ippTariff', event.target.value)}
                        />
                      </label>
                      <label>
                        GES offered rate
                        <input
                          inputMode="decimal"
                          placeholder="₹/kWh"
                          value={round.gesOffer}
                          disabled={!state.editable}
                          onChange={(event) => updateRound(index, 'gesOffer', event.target.value)}
                        />
                      </label>
                      <label>
                        Finalised rate
                        <input
                          inputMode="decimal"
                          placeholder="₹/kWh"
                          value={round.finalisedRate}
                          disabled={!state.editable}
                          onChange={(event) => updateRound(index, 'finalisedRate', event.target.value)}
                        />
                      </label>
                      {state.locked && <p className="tariff-round-note">Locked</p>}
                      {!state.locked && !state.editable && <p className="tariff-round-note">Opens after round {index} is saved</p>}
                    </fieldset>
                    );
                  })}
                </div>
              </section>
          </div>
        )}
        <footer className="tariff-modal-foot">
          <span>{save.isPending ? 'Saving…' : dirty ? 'Unsaved changes. Closing saves them.' : 'Saved for this GES.'}</span>
          {canEdit && (
            <button className="primary-button" type="button" disabled={save.isPending || !dirty} onClick={() => save.mutate()}>
              {save.isPending ? 'Saving…' : 'Save'}
            </button>
          )}
        </footer>
      </div>
    </div>
  );
}
