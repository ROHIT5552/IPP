'use client';

import Link from 'next/link';
import { FormEvent, useState } from 'react';
import { Eye, EyeOff } from 'lucide-react';
import { useRouter } from 'next/navigation';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { toast } from 'sonner';
import { PageHeader } from '../../components/AppShell';
import { useAuth } from '../auth/AuthProvider';
import { api } from '../../services/api';
import { GesAccount } from '../../types/api';

type Zone = { name: string; value: string };
type Period = 'annual' | 'monthly';

const empty = {
  name: '',
  consumerNumbers: '',
  plantAddress: '',
  contractDemandKva: '' as number | '',
  existingRooftopSolarKw: '' as number | '',
  period: 'annual' as Period,
  zones: [{ name: '', value: '' }] as Zone[],
  loginEmail: '',
  loginPassword: '',
};

function fromAccount(ges: GesAccount) {
  const zones = ges.zoneConsumption?.zones?.length
    ? ges.zoneConsumption.zones.map((zone) => ({ name: zone.name, value: zone.value ? String(zone.value) : '' }))
    : [{ name: '', value: '' }];
  return {
    name: ges.name,
    consumerNumbers: ges.consumerNumbers || '',
    plantAddress: ges.plantAddress || '',
    contractDemandKva: ges.contractDemandMw ? ges.contractDemandMw * 1000 : '' as number | '',
    existingRooftopSolarKw: ges.existingRooftopMw ? ges.existingRooftopMw * 1000 : '' as number | '',
    period: ges.zoneConsumption?.period === 'monthly' ? 'monthly' as Period : 'annual' as Period,
    zones,
    loginEmail: '',
    loginPassword: '',
  };
}

export function GesAccountForm({ account, cancelHref = '/ges' }: { account?: GesAccount; cancelHref?: string }) {
  const router = useRouter();
  const client = useQueryClient();
  const { user } = useAuth();
  const [form, setForm] = useState(account ? fromAccount(account) : empty);
  const [showPassword, setShowPassword] = useState(false);
  const creating = !account;
  const showLogin = creating && !user?.gesId;
  const save = useMutation({
    mutationFn: () => {
      const payload = {
        name: form.name,
        consumerNumbers: form.consumerNumbers,
        plantAddress: form.plantAddress,
        contractDemandKva: form.contractDemandKva === '' ? null : form.contractDemandKva,
        existingRooftopSolarKw: form.existingRooftopSolarKw === '' ? null : form.existingRooftopSolarKw,
        zoneConsumption: {
          period: form.period,
          zones: form.zones
            .map((zone) => ({ name: zone.name.trim(), value: zone.value === '' ? 0 : Number(zone.value) }))
            .filter((zone) => zone.name),
        },
        ...(showLogin ? { loginEmail: form.loginEmail, loginPassword: form.loginPassword } : {}),
      };
      return account
        ? api.patch<GesAccount[]>(`/ges/${account.id}`, payload)
        : api.post<GesAccount[]>('/ges', payload);
    },
    onSuccess: async (accounts) => {
      toast.success(account ? 'GES saved' : 'GES login created. Share the login with the GES. It is not shown on their profile.');
      client.setQueryData(['ges'], accounts);
      router.push(user?.gesId ? '/client/profile' : account ? `/ges/${account.id}` : '/ges');
    },
    onError: (error) => toast.error(error instanceof Error ? error.message : 'GES could not be saved'),
  });

  function submit(event: FormEvent) {
    event.preventDefault();
    if (showLogin && form.loginPassword.length < 8) {
      toast.error('Login password must be at least 8 characters');
      return;
    }
    save.mutate();
  }

  return (
    <>
      <PageHeader
        eyebrow="GES"
        title={account ? 'GES profile' : 'Add GES'}
        description={showLogin ? 'Create the GES and the login they will use. The password is not shown again on the profile.' : 'Name, supply account, and zone consumption. NewRa and the GES can both update these.'}
      />
      <section className="card">
        <form className="card-body" onSubmit={submit}>
          <div className="form-grid">
            <label className="form-field">Name<input value={form.name} onChange={(event) => setForm({ ...form, name: event.target.value })} required /></label>
            <label className="form-field">Consumer number<input value={form.consumerNumbers} onChange={(event) => setForm({ ...form, consumerNumbers: event.target.value })} /></label>
            <label className="form-field form-span">Plant address<textarea value={form.plantAddress} onChange={(event) => setForm({ ...form, plantAddress: event.target.value })} /></label>
            <label className="form-field">Contract demand (kVA)<input type="number" min={0} step="any" value={form.contractDemandKva} onChange={(event) => setForm({ ...form, contractDemandKva: event.target.value === '' ? '' : Number(event.target.value) })} /></label>
            <label className="form-field">Existing rooftop capacity (kW)<input type="number" min={0} step="any" value={form.existingRooftopSolarKw} onChange={(event) => setForm({ ...form, existingRooftopSolarKw: event.target.value === '' ? '' : Number(event.target.value) })} placeholder="Leave blank if none" /></label>
            <label className="form-field">Zone consumption
              <select value={form.period} onChange={(event) => setForm({ ...form, period: event.target.value as Period })}>
                <option value="annual">Annual</option>
                <option value="monthly">Monthly average</option>
              </select>
            </label>
            <div className="form-span">
              {form.zones.map((zone, index) => (
                <div className="form-grid" key={index} style={{ marginBottom: 8 }}>
                  <label className="form-field">Zone<input value={zone.name} onChange={(event) => setForm({ ...form, zones: form.zones.map((item, itemIndex) => itemIndex === index ? { ...item, name: event.target.value } : item) })} placeholder="Zone name" /></label>
                  <label className="form-field">{form.period === 'annual' ? 'Annual consumption' : 'Monthly average'}<input type="number" min={0} step="any" value={zone.value} onChange={(event) => setForm({ ...form, zones: form.zones.map((item, itemIndex) => itemIndex === index ? { ...item, value: event.target.value } : item) })} /></label>
                </div>
              ))}
              <button className="small-button" type="button" onClick={() => setForm({ ...form, zones: [...form.zones, { name: '', value: '' }] })}>Add zone</button>
            </div>
            {showLogin && (
              <>
                <div className="form-section"><h3>GES login</h3><p>Give these credentials to the GES. They are not displayed on the GES profile.</p></div>
                <label className="form-field">Login email<input type="email" value={form.loginEmail} onChange={(event) => setForm({ ...form, loginEmail: event.target.value })} required /></label>
                <label className="form-field">Password
                  <div className="password-field">
                    <input type={showPassword ? 'text' : 'password'} minLength={8} value={form.loginPassword} onChange={(event) => setForm({ ...form, loginPassword: event.target.value })} required />
                    <button type="button" aria-label={showPassword ? 'Hide password' : 'Show password'} onClick={() => setShowPassword((current) => !current)}>{showPassword ? <EyeOff size={16} /> : <Eye size={16} />}</button>
                  </div>
                </label>
              </>
            )}
          </div>
          <div className="card-tools" style={{ justifyContent: 'flex-start', marginTop: 12 }}>
            <button className="primary-button" type="submit" disabled={save.isPending}>{save.isPending ? 'Saving…' : account ? 'Save' : 'Create GES login'}</button>
            {!user?.gesId && <Link className="secondary-button" href={cancelHref}>Cancel</Link>}
          </div>
        </form>
      </section>
    </>
  );
}
