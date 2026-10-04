'use client';

import { FormEvent, useState } from 'react';
import { ArrowRight, Eye, EyeOff, ShieldCheck, Zap } from 'lucide-react';
import { useAuth } from '../../features/auth/AuthProvider';

export default function LoginPage() {
  const { signIn } = useAuth();
  const [email, setEmail] = useState('admin@newra.demo');
  const [password, setPassword] = useState('NewraDemo#2026');
  const [visible, setVisible] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  async function submit(event: FormEvent) {
    event.preventDefault();
    setError('');
    setLoading(true);
    try {
      await signIn(email, password);
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to sign in.');
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="login-page">
      <section className="login-brand-panel">
        <div className="login-brand">
          <span className="brand-mark"><Zap size={20} fill="currentColor" /></span>
          <span>newra<span className="brand-dot">.</span></span>
        </div>
        <div className="login-story">
          <div className="story-chip"><span className="live-dot" /> ENERGY PROCUREMENT INTELLIGENCE</div>
          <h1>Make every<br />energy decision<br /><em>with confidence.</em></h1>
          <p>One clear view across consumer requirements, provider capability, risk, and commercial fit.</p>
          <div className="story-steps">
            <div><span>01</span><strong>Understand the requirement</strong></div>
            <div><span>02</span><strong>Compare real capability</strong></div>
            <div><span>03</span><strong>Move with evidence</strong></div>
          </div>
        </div>
        <div className="login-panel-foot"><ShieldCheck size={15} /> Internal NewRa workspace <span>•</span> Demo values are illustrative</div>
      </section>
      <section className="login-form-panel">
        <div className="login-form-wrap">
          <div className="login-mobile-brand"><span className="brand-mark"><Zap size={19} fill="currentColor" /></span> newra<span className="brand-dot">.</span></div>
          <div className="login-label">WELCOME BACK</div>
          <h2>Sign in to your workspace</h2>
          <p className="login-sub">Use your internal credentials to continue.</p>
          <form onSubmit={submit}>
            <label className="field-label" htmlFor="email">Work email</label>
            <input id="email" type="email" autoComplete="username" value={email} onChange={(event) => setEmail(event.target.value)} required />
            <label className="field-label password-label" htmlFor="password">Password</label>
            <div className="password-field">
              <input id="password" type={visible ? 'text' : 'password'} autoComplete="current-password" value={password} onChange={(event) => setPassword(event.target.value)} required />
              <button type="button" aria-label={visible ? 'Hide password' : 'Show password'} onClick={() => setVisible(!visible)}>{visible ? <EyeOff size={17} /> : <Eye size={17} />}</button>
            </div>
            {error && <div className="form-error" role="alert">{error}</div>}
            <button className="primary-button login-button" type="submit" disabled={loading}>
              {loading ? 'Signing in…' : 'Sign in'} {!loading && <ArrowRight size={17} />}
            </button>
          </form>
          <div className="demo-credential"><div className="demo-icon"><ShieldCheck size={16} /></div><div><strong>Demo access</strong><span>admin@newra.demo · Super Admin · NewraDemo#2026</span><span>newra.admin@newra.demo · NewRa Admin</span></div></div>
          <div className="ges-login-list">
            <strong>Individual GES logins</strong>
            <span>ges.admin.aster@newra.demo · Aster GES Admin</span>
            <span>ges.aster@newra.demo · Aster Manufacturing Group</span>
            <span>ges.nova@newra.demo · Nova Industrial Works</span>
            <span>ges.vertex@newra.demo · Vertex Metals &amp; Engineering</span>
            <span>ges.helix@newra.demo · Helix Chemicals</span>
            <span>Same password · NewraDemo#2026</span>
          </div>
          <div className="role-note">Role-based permissions are enforced by the API.</div>
        </div>
        <div className="login-copyright">© 2026 NewRa <span>•</span> Energy Decision Platform</div>
      </section>
    </main>
  );
}
