'use client';

import { useRef } from 'react';

export function OtpFields({ value, onChange }: { value: string; onChange: (next: string) => void }) {
  const refs = useRef<Array<HTMLInputElement | null>>([]);
  const digits = Array.from({ length: 4 }, (_, index) => value[index] ?? '');

  function write(index: number, next: string) {
    const chars = digits.slice();
    chars[index] = next;
    onChange(chars.join('').replace(/\s/g, ''));
  }

  return (
    <div className="otp-boxes">
      {digits.map((digit, index) => (
        <input
          key={index}
          ref={(node) => { refs.current[index] = node; }}
          inputMode="numeric"
          autoComplete={index === 0 ? 'one-time-code' : 'off'}
          aria-label={`Digit ${index + 1}`}
          maxLength={1}
          value={digit}
          onChange={(event) => {
            const next = event.target.value.replace(/\D/g, '').slice(-1);
            write(index, next);
            if (next) refs.current[index + 1]?.focus();
          }}
          onKeyDown={(event) => {
            if (event.key === 'Backspace' && !digit) {
              refs.current[index - 1]?.focus();
              write(index - 1, '');
            }
          }}
          onPaste={(event) => {
            const pasted = event.clipboardData.getData('text').replace(/\D/g, '').slice(0, 4);
            if (!pasted) return;
            event.preventDefault();
            onChange(pasted);
            refs.current[Math.min(pasted.length, 3)]?.focus();
          }}
        />
      ))}
    </div>
  );
}

const COLORS = ['#b81d24', '#1f6feb', '#18806a', '#c47b17', '#6d4cc4', '#c4527a', '#0f7b8a', '#8a5a2b'];

export function profileColor(name: string) {
  const total = [...name].reduce((sum, char) => sum + char.charCodeAt(0), 0);
  return COLORS[total % COLORS.length];
}
