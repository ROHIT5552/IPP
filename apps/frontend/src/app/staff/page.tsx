'use client';

import { FormEvent, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Eye, EyeOff, Zap } from 'lucide-react';
import { NewraLoader } from '../../components/DataState';
import { useAuth } from '../../features/auth/AuthProvider';

export default function StaffPage() {
  const { signIn, ready } = useAuth();
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [visible, setVisible] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  async function submit(event: FormEvent) {
    event.preventDefault();
    setError('');
    setLoading(true);
    try {
      await signIn(email, password);
      router.replace('/dashboard');
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to sign in.');
    } finally {
      setLoading(false);
    }
  }

  if (!ready) return <NewraLoader label="Opening sign in" />;

  return (
    <main className="signin-page">
      <section className="signin-panel signin-panel-solo">
        <form className="signin-card" onSubmit={submit}>
          <div className="gate-brand"><span className="brand-mark"><Zap size={18} fill="currentColor" /></span> newra<span className="brand-dot">.</span></div>
          <h2>Sign in</h2>
          <label htmlFor="work-email">Email</label>
          <input id="work-email" type="email" autoComplete="username" value={email} onChange={(event) => setEmail(event.target.value)} required />
          <label htmlFor="work-password">Password</label>
          <div className="password-field">
            <input id="work-password" type={visible ? 'text' : 'password'} autoComplete="current-password" value={password} onChange={(event) => setPassword(event.target.value)} required />
            <button type="button" aria-label={visible ? 'Hide password' : 'Show password'} onClick={() => setVisible(!visible)}>{visible ? <EyeOff size={17} /> : <Eye size={17} />}</button>
          </div>
          {error && <div className="form-error" role="alert">{error}</div>}
          <button className="primary-button" type="submit" disabled={loading}>{loading ? 'Signing in…' : 'Continue'}</button>
        </form>
      </section>
    </main>
  );
}
