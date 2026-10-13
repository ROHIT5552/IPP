'use client';

import { FormEvent, useState } from 'react';
import { Eye, EyeOff, Zap } from 'lucide-react';
import { NewraLoader } from '../../components/DataState';
import { useAuth } from '../../features/auth/AuthProvider';

export default function LoginPage() {
  const { signIn, ready, user } = useAuth();
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

  if (!ready || user) return <NewraLoader label="Opening your workspace" />;

  return (
    <main className="signin-page">
      <section className="signin-hero">
        <div className="gate-brand"><span className="brand-mark"><Zap size={18} fill="currentColor" /></span> newra<span className="brand-dot">.</span></div>
        <h1>Your energy decisions, in one place.</h1>
      </section>
      <section className="signin-panel">
        <form className="signin-card" onSubmit={submit}>
          <h2>Sign in</h2>
          <p>Use the login given to you by NewRa.</p>
          <label htmlFor="identity">Login</label>
          <input id="identity" autoComplete="username" placeholder="Login or email" value={identity} onChange={(event) => setIdentity(event.target.value)} required />
          <label htmlFor="password">Password</label>
          <div className="password-field">
            <input id="password" type={visible ? 'text' : 'password'} autoComplete="current-password" value={password} onChange={(event) => setPassword(event.target.value)} required minLength={8} />
            <button type="button" aria-label={visible ? 'Hide password' : 'Show password'} onClick={() => setVisible(!visible)}>{visible ? <EyeOff size={17} /> : <Eye size={17} />}</button>
          </div>
          {error && <div className="form-error" role="alert">{error}</div>}
          <button className="primary-button" type="submit" disabled={loading}>{loading ? 'Signing in…' : 'Continue'}</button>
        </form>
      </section>
    </main>
  );
}
