'use client';

import Link from 'next/link';
import { FormEvent, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { toast } from 'sonner';
import { PageHeader } from '../../components/AppShell';
import { api } from '../../services/api';
import { IppCatalogRow } from '../../types/api';

const empty = {
  referenceNo: '',
  name: '',
  loiScope: '',
  portfolioCapacity: '',
  headquarters: '',
  leadership: '',
  keyContact: '',
  cin: '',
  notes: '',
};

function fromAccount(account: IppCatalogRow) {
  return {
    referenceNo: account.referenceNo || '',
    name: account.name,
    loiScope: account.loiScope || '',
    portfolioCapacity: account.portfolioCapacity || '',
    headquarters: account.headquarters === 'Not specified' ? '' : account.headquarters,
    leadership: account.leadership || '',
    keyContact: account.keyContact || '',
    cin: account.cin || '',
    notes: account.notes || '',
  };
}

export function IppAccountForm({ account, cancelHref = '/ipps' }: { account?: IppCatalogRow; cancelHref?: string }) {
  const router = useRouter();
  const client = useQueryClient();
  const [form, setForm] = useState(account ? fromAccount(account) : empty);
  const save = useMutation({
    mutationFn: () => account
      ? api.patch<IppCatalogRow[]>(`/ipps/${account.id}`, { mode: 'register', ...form })
      : api.post<IppCatalogRow[]>('/ipps', { mode: 'register', ...form }),
    onSuccess: async (rows) => {
      toast.success(account ? 'IPP updated' : 'IPP added');
      client.setQueryData(['ipp-catalog'], rows);
      router.push(account ? `/ipps/${account.id}` : '/ipps');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'IPP could not be saved'),
  });

  function submit(event: FormEvent) {
    event.preventDefault();
    save.mutate();
  }

  function set(key: keyof typeof empty, value: string) {
    setForm((current) => ({ ...current, [key]: value }));
  }

  return (
    <>
      <PageHeader eyebrow="INDEPENDENT POWER PRODUCER" title={account ? 'Edit IPP' : 'Add IPP'} description="Company, scope, capacity, office, leadership, contact, and CIN. Notes stay visible to the GES." />
      <section className="card">
        <form className="card-body" onSubmit={submit}>
          <div className="form-grid">
            <label className="form-field">No.<input value={form.referenceNo} onChange={(event) => set('referenceNo', event.target.value)} /></label>
            <label className="form-field">IPP / company<input value={form.name} onChange={(event) => set('name', event.target.value)} required /></label>
            <label className="form-field form-span">Proposed LOI scope<textarea value={form.loiScope} onChange={(event) => set('loiScope', event.target.value)} /></label>
            <label className="form-field">Portfolio / capacity<input value={form.portfolioCapacity} onChange={(event) => set('portfolioCapacity', event.target.value)} placeholder="For example 8.5 GWp" /></label>
            <label className="form-field">Head office<input value={form.headquarters} onChange={(event) => set('headquarters', event.target.value)} /></label>
            <label className="form-field">Company leadership<input value={form.leadership} onChange={(event) => set('leadership', event.target.value)} /></label>
            <label className="form-field">Key contact / decision-maker<input value={form.keyContact} onChange={(event) => set('keyContact', event.target.value)} /></label>
            <label className="form-field">CIN<input value={form.cin} onChange={(event) => set('cin', event.target.value)} /></label>
            <label className="form-field form-span">Notes<textarea value={form.notes} onChange={(event) => set('notes', event.target.value)} placeholder="Visible to the GES" /></label>
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
