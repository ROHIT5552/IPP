'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { NewraLoader } from '../../components/DataState';
import { PROFILE_KEY, useAuth } from '../../features/auth/AuthProvider';
import { householdStore } from '../../features/auth/household';
import { CodeStep, ProfileGate, useCountdown } from '../../features/auth/ProfileGate';
import { api } from '../../services/api';
import { GesLoginProfile, GesOtpChallenge } from '../../types/api';

export default function WhosWatchingPage() {
  const { user, ready, signInWithCode } = useAuth();
  const router = useRouter();
  const household = useQuery({
    queryKey: ['household', user?.id],
    queryFn: async () => {
      const result = await api.household();
      if (result.gesId) householdStore.save(result);
      return result;
    },
    enabled: Boolean(user?.gesId),
  });
  const [challenge, setChallenge] = useState<GesOtpChallenge | null>(null);
  const [pendingEmail, setPendingEmail] = useState('');
  const [mode, setMode] = useState<'pick' | 'switch' | 'add'>('pick');
  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');
  const [loading, setLoading] = useState(false);
  const [token, setToken] = useState(0);
  const secondsLeft = useCountdown(challenge?.resendInSeconds ?? 30, token);
  const expiresLeft = useCountdown(challenge?.expiresInSeconds ?? 300, token);

  function enter(profileId: string) {
    window.sessionStorage.setItem(PROFILE_KEY, profileId);
    router.replace('/client/profile');
  }

  async function choose(profile: GesLoginProfile) {
    if (profile.id === user?.id) {
      enter(profile.id);
      return;
    }
    setError('');
    setLoading(true);
    try {
      const next = await api.requestGesOtp(profile.id);
      setChallenge(next);
      setMode('switch');
      setToken((current) => current + 1);
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to send the code.');
    } finally {
      setLoading(false);
    }
  }

  async function add(input: { name: string; email: string; phone: string }) {
    setError('');
    setLoading(true);
    try {
      const next = await api.addProfile(input);
      setPendingEmail(input.email);
      setChallenge(next);
      setMode('add');
      setToken((current) => current + 1);
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Unable to add that profile.');
      setLoading(false);
      throw cause;
    }
    setLoading(false);
  }

  async function confirmSwitch(code: string) {
    if (!challenge) return;
    setLoading(true);
    setError('');
    try {
      const signedIn = await signInWithCode(challenge.profileId, code);
      enter(signedIn.id);
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'That code could not be confirmed.');
    } finally {
      setLoading(false);
    }
  }

  async function confirmAdd(code: string) {
    setLoading(true);
    setError('');
    try {
      await api.verifyAddedProfile(pendingEmail, code);
      setNotice('NewRa Grids has the request, including the phone number. This profile can sign in only after that access is accepted.');
      setMode('pick');
      setChallenge(null);
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'That code could not be confirmed.');
    } finally {
      setLoading(false);
    }
  }

  if (!ready || !user || household.isLoading) return <NewraLoader label="Loading profiles" />;

  if ((mode === 'switch' || mode === 'add') && challenge) {
    return (
      <CodeStep
        title={mode === 'add' ? 'Confirm the new profile' : 'Enter the code'}
        detail={`We sent a 4-digit code to ${challenge.maskedEmail}.`}
        devCode={challenge.devCode}
        secondsLeft={secondsLeft}
        expiresLeft={expiresLeft}
        error={error}
        onSubmit={mode === 'add' ? confirmAdd : confirmSwitch}
        onResend={() => { if (mode === 'switch' && challenge) void api.requestGesOtp(challenge.profileId).then((next) => { setChallenge(next); setToken((current) => current + 1); }); }}
        onBack={() => { setMode('pick'); setChallenge(null); setError(''); }}
      />
    );
  }

  return (
    <>
      <ProfileGate
        gesName={household.data?.gesName ?? ''}
        profiles={household.data?.profiles ?? []}
        onChoose={(profile) => { void choose(profile); }}
        onAdd={add}
        adding={loading}
      />
      {notice && <p className="gate-note">{notice}</p>}
      {error && <p className="gate-error" role="alert">{error}</p>}
    </>
  );
}
