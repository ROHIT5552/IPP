'use client';

import { FormEvent, useEffect, useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { Zap } from 'lucide-react';
import { NewraLoader } from '../../components/DataState';
import { PROFILE_KEY, useAuth } from '../../features/auth/AuthProvider';
import { householdStore } from '../../features/auth/household';
import { CodeStep, ProfileGate, useCountdown } from '../../features/auth/ProfileGate';
import { api } from '../../services/api';
import { GesHousehold, GesLoginProfile, GesOtpChallenge } from '../../types/api';

export default function LoginPage() {
  const { signInWithCode, ready, user } = useAuth();
  const router = useRouter();
  const [remembered, setRemembered] = useState<GesHousehold | null>(null);
  const [fromProfile, setFromProfile] = useState(false);
  const [mode, setMode] = useState<'profiles' | 'email' | 'code'>('email');
  const [email, setEmail] = useState('');
  const [challenge, setChallenge] = useState<GesOtpChallenge | null>(null);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [token, setToken] = useState(0);

  useEffect(() => {
    const stored = householdStore.read();
    if (!stored) return;
    setRemembered(stored);
    setMode('profiles');
  }, []);

  const secondsLeft = useCountdown(challenge?.resendInSeconds ?? 30, token);
  const expiresLeft = useCountdown(challenge?.expiresInSeconds ?? 300, token);

  async function sendToEmail(event?: FormEvent) {
    event?.preventDefault();
    setError('');
    setLoading(true);
    try {
      const next = await api.requestGesOtpByEmail(email);
      setFromProfile(false);
      setChallenge(next);
      setMode('code');
      setToken((current) => current + 1);
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to send the code.');
    } finally {
      setLoading(false);
    }
  }

  async function sendToProfile(profile: GesLoginProfile) {
    setError('');
    setLoading(true);
    try {
      const next = await api.requestGesOtp(profile.id);
      setFromProfile(true);
      setChallenge(next);
      setMode('code');
      setToken((current) => current + 1);
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to send the code.');
    } finally {
      setLoading(false);
    }
  }

  async function verify(code: string) {
    if (!challenge) return;
    setError('');
    setLoading(true);
    try {
      const signedIn = await signInWithCode(challenge.profileId, code);
      if (fromProfile) {
        window.sessionStorage.setItem(PROFILE_KEY, signedIn.id);
        router.replace('/client/profile');
      } else {
        router.replace('/whos-watching');
      }
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'That code could not be confirmed.');
    } finally {
      setLoading(false);
    }
  }

  if (!ready || user) return <NewraLoader label="Restoring your session" />;

  if (mode === 'profiles' && remembered) {
    return (
      <>
        <ProfileGate
          gesName={remembered.gesName}
          profiles={remembered.profiles}
          onChoose={(profile) => { void sendToProfile(profile); }}
          onForget={() => { householdStore.clear(); setMode('email'); }}
        />
        <div className="gate-actions">
          <Link href="/signup">Create an account</Link>
          {error && <p className="gate-error" role="alert">{error}</p>}
        </div>
      </>
    );
  }

  if (mode === 'code' && challenge) {
    return (
      <CodeStep
        title="Check your email"
        detail={`Enter the 4-digit code sent to ${challenge.maskedEmail}. It works for 5 minutes.`}
        devCode={challenge.devCode}
        secondsLeft={secondsLeft}
        expiresLeft={expiresLeft}
        error={error}
        onSubmit={verify}
        onResend={() => { if (email) void sendToEmail(); else if (challenge) void api.requestGesOtp(challenge.profileId).then((next) => { setChallenge(next); setToken((current) => current + 1); }); }}
        onBack={() => setMode(remembered ? 'profiles' : 'email')}
      />
    );
  }

  return (
    <main className="signin-page">
      <section className="signin-hero">
        <div className="gate-brand"><span className="brand-mark"><Zap size={18} fill="currentColor" /></span> newra<span className="brand-dot">.</span></div>
        <h1>Your energy decisions, in one place.</h1>
      </section>
      <section className="signin-panel">
        <form className="signin-card" onSubmit={sendToEmail}>
          <h2>Sign in</h2>
          <p>Use the email that was accepted for your organisation.</p>
          <label htmlFor="ges-email">Email</label>
          <input id="ges-email" type="email" autoComplete="email" placeholder="name@company.com" value={email} onChange={(event) => setEmail(event.target.value)} required />
          {error && <div className="form-error" role="alert">{error}</div>}
          <button className="primary-button" type="submit" disabled={loading}>{loading ? 'Sending code…' : 'Continue'}</button>
          <p className="signin-switch">New organisation? <Link href={email ? `/signup?email=${encodeURIComponent(email)}` : '/signup'}>Create an account</Link></p>
        </form>
      </section>
    </main>
  );
}
