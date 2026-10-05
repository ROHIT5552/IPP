'use client';

import { FormEvent, useEffect, useState } from 'react';
import Link from 'next/link';
import { Zap } from 'lucide-react';
import { NewraLoader } from '../../components/DataState';
import { AccessFlow, CodeStep, useCountdown } from '../../features/auth/ProfileGate';
import { useAuth } from '../../features/auth/AuthProvider';
import { api } from '../../services/api';
import { GesOtpChallenge } from '../../types/api';

export default function SignupPage() {
  const { ready, user } = useAuth();
  const [step, setStep] = useState<'email' | 'details' | 'code' | 'pending'>('email');
  const [email, setEmail] = useState('');
  const [name, setName] = useState('');
  const [phone, setPhone] = useState('');
  const [gesName, setGesName] = useState('');
  const [challenge, setChallenge] = useState<GesOtpChallenge | null>(null);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [token, setToken] = useState(0);
  const [emailSent, setEmailSent] = useState(false);
  useEffect(() => {
    const preset = new URLSearchParams(window.location.search).get('email');
    if (preset) setEmail(preset);
  }, []);
  const secondsLeft = useCountdown(challenge?.resendInSeconds ?? 30, token);
  const expiresLeft = useCountdown(challenge?.expiresInSeconds ?? 300, token);

  async function sendCode(event?: FormEvent) {
    event?.preventDefault();
    setError('');
    setLoading(true);
    try {
      const next = await api.startSignup({ email, name, gesName, phone });
      setChallenge(next);
      setStep('code');
      setToken((current) => current + 1);
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to send the code.');
    } finally {
      setLoading(false);
    }
  }

  async function verify(code: string) {
    setError('');
    setLoading(true);
    try {
      const result = await api.verifySignup(email, code);
      setEmailSent(result.emailSent);
      setStep('pending');
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'That code could not be confirmed.');
    } finally {
      setLoading(false);
    }
  }

  if (!ready || user) return <NewraLoader label="Opening your workspace" />;

  if (step === 'pending') {
    return (
      <main className="gate-page">
        <div className="gate-brand"><span className="brand-mark"><Zap size={18} fill="currentColor" /></span> newra<span className="brand-dot">.</span></div>
        <section className="gate-card">
          <h1>Waiting for NewRa Grids</h1>
          <p>{emailSent
            ? 'We emailed NewRa Grids with your name, organisation and phone number. You can sign in only after they accept you.'
            : 'Your request is saved, but the email to NewRa Grids was not sent. NewRa Grids can still accept you from GES access inside the app.'}</p>
          <Link className="gate-link" href="/login">Back to sign in</Link>
        </section>
      </main>
    );
  }

  if (step === 'code' && challenge) {
    return (
      <CodeStep
        title="Enter the code"
        detail={`We sent a 4-digit code to ${challenge.maskedEmail}.`}
        devCode={challenge.devCode}
        secondsLeft={secondsLeft}
        expiresLeft={expiresLeft}
        error={error}
        onSubmit={verify}
        onResend={() => { if (!loading) void sendCode(); }}
        onBack={() => setStep('details')}
      />
    );
  }

  return (
    <main className="gate-page">
      <div className="gate-brand"><span className="brand-mark"><Zap size={18} fill="currentColor" /></span> newra<span className="brand-dot">.</span></div>
      <form className="gate-card" onSubmit={step === 'email' ? (event) => { event.preventDefault(); setStep('details'); } : sendCode}>
        <div className="login-label">{step === 'email' ? 'STEP 1 OF 2' : 'STEP 2 OF 2'}</div>
        <h1>{step === 'email' ? 'Create your account' : 'Tell us who you are'}</h1>
        <p>{step === 'email' ? 'Use the email where you want to receive your sign-in code.' : 'NewRa Grids uses your phone number to recognise this request.'}</p>
        {step === 'email' && <AccessFlow />}
        {step === 'email' ? (
          <>
            <label htmlFor="signup-email">Email</label>
            <input id="signup-email" type="email" autoComplete="email" value={email} onChange={(event) => setEmail(event.target.value)} required />
          </>
        ) : (
          <>
            <label htmlFor="signup-name">Your name</label>
            <input id="signup-name" autoComplete="name" value={name} onChange={(event) => setName(event.target.value)} required minLength={2} />
            <label htmlFor="signup-ges">Organisation</label>
            <input id="signup-ges" value={gesName} onChange={(event) => setGesName(event.target.value)} required minLength={2} />
            <label htmlFor="signup-phone">Phone</label>
            <input id="signup-phone" type="tel" autoComplete="tel" value={phone} onChange={(event) => setPhone(event.target.value)} required minLength={10} />
          </>
        )}
        {error && <div className="form-error" role="alert">{error}</div>}
        <button className="primary-button" type="submit" disabled={loading}>{loading ? 'Sending code…' : step === 'email' ? 'Get started' : 'Email me a code'}</button>
        {step === 'details' && <button className="gate-link" type="button" onClick={() => setStep('email')}>Back</button>}
        <Link className="gate-link" href="/login">Already have a profile? Sign in</Link>
      </form>
    </main>
  );
}
