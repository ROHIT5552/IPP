'use client';

import { FormEvent, useState } from 'react';
import { ArrowRight, Eye, EyeOff } from 'lucide-react';
import { BrandLockup } from '../../components/BrandLockup';
import { NewraLoader } from '../../components/DataState';
import { useAuth, useHasSession } from '../../features/auth/AuthProvider';

export default function LoginPage() {
  const { signIn, ready, user } = useAuth();
  const hasSession = useHasSession();
  const [identity, setIdentity] = useState('');
  const [password, setPassword] = useState('');
  const [visible, setVisible] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  async function submit(event: FormEvent) {
    event.preventDefault();
    setError('');
    setLoading(true);
    try {
      await signIn(identity, password);
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to sign in.');
    } finally {
      setLoading(false);
    }
  }

  if ((hasSession && !ready) || user) return <NewraLoader label="Opening your workspace" />;

  return (
    <main id="main" className="signin-page">
      <form className="signin-card" onSubmit={submit}>
        <div className="gate-brand"><BrandLockup priority /></div>
        <h1>Empowering the Green Shift.</h1>
        <label htmlFor="identity">Login</label>
        <input id="identity" autoComplete="username" placeholder="Enter your email" value={identity} onChange={(event) => setIdentity(event.target.value)} required />
        <label htmlFor="password">Password</label>
        <div className="password-field">
          <input id="password" type={visible ? 'text' : 'password'} autoComplete="current-password" placeholder="Enter your password" value={password} onChange={(event) => setPassword(event.target.value)} required minLength={8} />
          <button type="button" aria-label={visible ? 'Hide password' : 'Show password'} onClick={() => setVisible(!visible)}>{visible ? <EyeOff size={17} /> : <Eye size={17} />}</button>
        </div>
        {error && <div className="form-error" role="alert">{error}</div>}
        <button className="primary-button signin-submit" type="submit" disabled={loading}>
          <span>{loading ? 'Signing in…' : 'Continue'}</span>
          {!loading && <ArrowRight size={18} />}
        </button>
      </form>
    </main>
  );
}
