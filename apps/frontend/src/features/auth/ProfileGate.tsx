'use client';

import { FormEvent, useEffect, useState } from 'react';
import { Plus, Zap } from 'lucide-react';
import { GesLoginProfile } from '../../types/api';
import { OtpFields, profileColor } from './OtpFields';

export function AccessFlow() {
  return (
    <ol className="access-flow">
      <li>Create an account with your name, organisation, email and phone.</li>
      <li>Enter the 4-digit code sent to your email.</li>
      <li>NewRa Grids gets your details and phone number, then accepts you.</li>
      <li>Sign in with your email. You get a new code, then choose your profile.</li>
    </ol>
  );
}

export function ProfileGate({
  gesName,
  profiles,
  onChoose,
  onAdd,
  onForget,
  adding,
}: {
  gesName: string;
  profiles: GesLoginProfile[];
  onChoose: (profile: GesLoginProfile) => void;
  onAdd?: (input: { name: string; email: string; phone: string }) => Promise<void>;
  onForget?: () => void;
  adding?: boolean;
}) {
  const [composer, setComposer] = useState(false);
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');

  async function add(event: FormEvent) {
    event.preventDefault();
    if (!onAdd) return;
    await onAdd({ name, email, phone });
    setName('');
    setEmail('');
    setPhone('');
    setComposer(false);
  }

  return (
    <main className="gate-page">
      <div className="gate-brand"><span className="brand-mark"><Zap size={18} fill="currentColor" /></span> newra<span className="brand-dot">.</span></div>
      <h1>Who&apos;s signing in?</h1>
      <p>{gesName ? `${gesName} on this device` : 'Choose a profile to open the workspace'}</p>
      <div className="profile-row">
        {profiles.map((profile) => (
          <button className="profile-card" key={profile.id} type="button" onClick={() => onChoose(profile)}>
            <span className="profile-avatar" style={{ background: profileColor(profile.name) }}>{profile.initials}</span>
            <strong>{profile.name}</strong>
            <small>{profile.gesName}</small>
          </button>
        ))}
        {onAdd && (
          <button className="profile-card add-profile" type="button" onClick={() => setComposer(true)}>
            <span className="profile-avatar"><Plus size={28} /></span>
            <strong>Add profile</strong>
          </button>
        )}
      </div>
      {composer && onAdd && (
        <form className="gate-card" onSubmit={add}>
          <h2>Add a profile</h2>
          <label htmlFor="profile-name">Name</label>
          <input id="profile-name" value={name} onChange={(event) => setName(event.target.value)} required minLength={2} />
          <label htmlFor="profile-email">Email</label>
          <input id="profile-email" type="email" value={email} onChange={(event) => setEmail(event.target.value)} required />
          <label htmlFor="profile-phone">Phone</label>
          <input id="profile-phone" type="tel" value={phone} onChange={(event) => setPhone(event.target.value)} required minLength={10} />
          <button className="primary-button" type="submit" disabled={adding}>{adding ? 'Sending code…' : 'Send code'}</button>
        </form>
      )}
      {onForget && <button className="gate-link" type="button" onClick={onForget}>Use a different organisation</button>}
    </main>
  );
}

export function CodeStep({
  title,
  detail,
  devCode,
  secondsLeft,
  expiresLeft,
  error,
  onSubmit,
  onResend,
  onBack,
}: {
  title: string;
  detail: string;
  devCode?: string;
  secondsLeft: number;
  expiresLeft: number;
  error: string;
  onSubmit: (code: string) => void;
  onResend: () => void;
  onBack: () => void;
}) {
  const [code, setCode] = useState('');

  return (
    <main className="gate-page">
      <div className="gate-brand"><span className="brand-mark"><Zap size={18} fill="currentColor" /></span> newra<span className="brand-dot">.</span></div>
      <form className="gate-card" onSubmit={(event) => { event.preventDefault(); if (code.length === 4) onSubmit(code); }}>
        <h1>{title}</h1>
        <p>{detail}</p>
        <OtpFields value={code} onChange={setCode} />
        <p className="gate-note">Code expires in {formatClock(expiresLeft)}. You can resend it after 30 seconds.</p>
        {devCode && <p className="gate-note">Mail is not configured on this machine, so the code is {devCode}.</p>}
        {error && <div className="form-error" role="alert">{error}</div>}
        <button className="primary-button" type="submit" disabled={code.length < 4}>Continue</button>
        <button className="gate-link" type="button" disabled={secondsLeft > 0} onClick={onResend}>
          {secondsLeft > 0 ? `Resend code in ${secondsLeft}s` : 'Resend code'}
        </button>
        <button className="gate-link" type="button" onClick={onBack}>Back</button>
      </form>
    </main>
  );
}

export function useCountdown(start: number, token: number) {
  const [left, setLeft] = useState(start);
  useEffect(() => {
    setLeft(start);
    const timer = window.setInterval(() => setLeft((current) => (current > 0 ? current - 1 : 0)), 1000);
    return () => window.clearInterval(timer);
  }, [start, token]);
  return left;
}

function formatClock(total: number) {
  const minutes = Math.floor(Math.max(total, 0) / 60);
  const seconds = Math.max(total, 0) % 60;
  return `${minutes}:${seconds.toString().padStart(2, '0')}`;
}
