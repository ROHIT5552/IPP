'use client';

import { Info } from 'lucide-react';
import { useEffect, useId, useRef, useState } from 'react';
import { TERMS } from './terms';

export function InfoTooltip({ term }: { term: string }) {
  const entry = TERMS[term];
  const [open, setOpen] = useState(false);
  const root = useRef<HTMLSpanElement>(null);
  const titleId = useId();
  useEffect(() => {
    if (!open) return;
    function close(event: MouseEvent) {
      if (!root.current?.contains(event.target as Node)) setOpen(false);
    }
    function onKey(event: KeyboardEvent) {
      if (event.key === 'Escape') setOpen(false);
    }
    document.addEventListener('mousedown', close);
    document.addEventListener('keydown', onKey);
    return () => {
      document.removeEventListener('mousedown', close);
      document.removeEventListener('keydown', onKey);
    };
  }, [open]);
  if (!entry) return null;
  return (
    <span className="term-info" ref={root}>
      <button
        type="button"
        className="term-info-button"
        aria-label={`About ${entry.title}`}
        aria-expanded={open}
        aria-describedby={open ? titleId : undefined}
        onClick={(event) => { event.stopPropagation(); setOpen((current) => !current); }}
      >
        <Info size={12} />
      </button>
      {open && (
        <span className="term-info-panel" role="tooltip" id={titleId}>
          <strong>{entry.title}</strong>
          <span>{entry.description}</span>
          <em>Why it matters</em>
          <span>{entry.why}</span>
        </span>
      )}
    </span>
  );
}
