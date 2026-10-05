'use client';

import { FormEvent, useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import { AppShell, PageHeader } from '../../components/AppShell';
import { ErrorState, PageSkeleton } from '../../components/DataState';
import { api, listQuery } from '../../services/api';
import { GesAccount, GesAccessRow } from '../../types/api';

export default function GesAccessPage() {
  const queryClient = useQueryClient();
  const access = useQuery({ queryKey: ['ges-access'], queryFn: () => api.gesAccess() });
  const accounts = useQuery({ queryKey: ['ges'], queryFn: () => api.get<GesAccount[]>('/ges'), ...listQuery });
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [gesId, setGesId] = useState('');
  const [error, setError] = useState('');
  const [busy, setBusy] = useState('');

  async function refresh() {
    await queryClient.invalidateQueries({ queryKey: ['ges-access'] });
  }

  async function add(event: FormEvent) {
    event.preventDefault();
    setError('');
    setBusy('add');
    try {
      await api.addGesAccess({ name, email, phone, gesId });
      setName('');
      setEmail('');
      setPhone('');
      await refresh();
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to add this user.');
    } finally {
      setBusy('');
    }
  }

  async function decide(row: GesAccessRow, accept: boolean) {
    setError('');
    setBusy(`${row.id}:${accept ? 'accept' : 'remove'}`);
    try {
      if (accept) await api.approveGesAccess(row.id);
      else await api.removeGesAccess(row.id);
      if (!accept) {
        queryClient.setQueryData<GesAccessRow[]>(['ges-access'], (current) => current?.filter((item) => item.id !== row.id));
      }
      await refresh();
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to update this user.');
    } finally {
      setBusy('');
    }
  }

  return (
    <AppShell>
      <PageHeader eyebrow="NewRa Grids" title="GES access" description="Accept a request to open that GES role, or add and remove users. Each request emails NewRa Grids with the phone number." />
      {error && <div className="form-error" role="alert">{error}</div>}
      {access.isLoading && <PageSkeleton variant="table" heading={false} />}
      {access.isError && <ErrorState message="GES access could not be loaded." retry={() => void access.refetch()} />}
      {access.data && (
        <div className="card access-register">
          <div className="data-table-wrap">
            <table className="data-table">
              <thead>
                <tr><th>Name</th><th>Email</th><th>Phone</th><th>Organisation</th><th>Status</th><th></th></tr>
              </thead>
              <tbody>
                {access.data.map((row) => (
                  <tr key={row.id}>
                    <td><strong>{row.name}</strong></td>
                    <td>{row.email}</td>
                    <td>{row.phone || '—'}</td>
                    <td>{row.gesName}</td>
                    <td>{row.accessStatus === 'APPROVED' && row.active ? 'Approved' : row.accessStatus === 'PENDING' ? 'Waiting' : 'Removed'}</td>
                    <td className="row-actions">
                      {row.accessStatus !== 'APPROVED' || !row.active ? (
                        <button className="small-button" type="button" disabled={busy.startsWith(row.id)} onClick={() => void decide(row, true)}>{busy === `${row.id}:accept` ? 'Accepting…' : 'Accept'}</button>
                      ) : null}
                      {row.active && <button className="danger-button" type="button" disabled={busy.startsWith(row.id)} onClick={() => void decide(row, false)}>{busy === `${row.id}:remove` ? 'Removing…' : 'Remove'}</button>}
                    </td>
                  </tr>
                ))}
                {access.data.length === 0 && <tr><td colSpan={6}>No GES users yet.</td></tr>}
              </tbody>
            </table>
          </div>
        </div>
      )}
      <form className="card access-form" onSubmit={add}>
        <div className="card-body form-grid">
          <h2 className="form-span">Add a GES user</h2>
          <label className="form-field">Name<input value={name} onChange={(event) => setName(event.target.value)} required minLength={2} /></label>
          <label className="form-field">Email<input type="email" value={email} onChange={(event) => setEmail(event.target.value)} required /></label>
          <label className="form-field">Phone<input type="tel" value={phone} onChange={(event) => setPhone(event.target.value)} required minLength={10} /></label>
          <label className="form-field">GES account
            <select value={gesId} onChange={(event) => setGesId(event.target.value)} required>
              <option value="">Select an organisation</option>
              {(accounts.data ?? []).map((account) => <option key={account.id} value={account.id}>{account.name}</option>)}
            </select>
          </label>
          <button className="primary-button form-span" type="submit" disabled={busy === 'add'}>{busy === 'add' ? 'Saving…' : 'Add and email the user'}</button>
        </div>
      </form>
    </AppShell>
  );
}
