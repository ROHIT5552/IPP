'use client';

import { Info } from 'lucide-react';
import { ReactNode, useEffect, useId, useRef, useState } from 'react';
import { createPortal } from 'react-dom';
import { findTerm, TERMS } from './terms';

function tooltipBox(rect: DOMRect) {
  const width = Math.min(280, window.innerWidth * 0.72);
  const height = 170;
  let left = rect.left;
  if (left + width > window.innerWidth - 12) left = window.innerWidth - width - 12;
  if (left < 12) left = 12;
  const below = rect.bottom + 8;
  const top = below + height > window.innerHeight - 12 ? Math.max(12, rect.top - height - 8) : below;
  return { left, top };
}

export function InfoTooltip({ term }: { term: string }) {
  const entry = TERMS[term];
  const [open, setOpen] = useState(false);
  const [box, setBox] = useState<{ left: number; top: number } | null>(null);
  const root = useRef<HTMLSpanElement>(null);
  const panel = useRef<HTMLSpanElement>(null);
  const titleId = useId();
  useEffect(() => {
    if (!open) return;
    function close(event: MouseEvent) {
      const target = event.target as Node;
      if (root.current?.contains(target) || panel.current?.contains(target)) return;
      setOpen(false);
    }
    function onKey(event: KeyboardEvent) {
      if (event.key === 'Escape') setOpen(false);
    }
    function dismiss() {
      setOpen(false);
    }
    document.addEventListener('mousedown', close);
    document.addEventListener('keydown', onKey);
    window.addEventListener('scroll', dismiss, true);
    window.addEventListener('resize', dismiss);
    return () => {
      document.removeEventListener('mousedown', close);
      document.removeEventListener('keydown', onKey);
      window.removeEventListener('scroll', dismiss, true);
      window.removeEventListener('resize', dismiss);
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
        onClick={(event) => {
          event.stopPropagation();
          if (open) {
            setOpen(false);
            return;
          }
          setBox(tooltipBox(event.currentTarget.getBoundingClientRect()));
          setOpen(true);
        }}
      >
        <Info size={12} />
      </button>
      {open && box && createPortal(
        <span ref={panel} className="term-info-panel term-layer" role="tooltip" id={titleId} style={{ left: box.left, top: box.top }}>
          <strong>{entry.title}</strong>
          <span>{entry.description}</span>
          <em>Why it matters</em>
          <span>{entry.why}</span>
        </span>,
        document.body,
      )}
    </span>
  );
}

export function TermLabel({ label, children }: { label: string; children?: ReactNode }) {
  const entry = findTerm(label);
  const [box, setBox] = useState<{ left: number; top: number } | null>(null);
  if (!entry) return <>{children ?? label}</>;
  return (
    <span
      className="term-hover"
      tabIndex={0}
      onMouseEnter={(event) => setBox(tooltipBox(event.currentTarget.getBoundingClientRect()))}
      onMouseLeave={() => setBox(null)}
      onFocus={(event) => setBox(tooltipBox(event.currentTarget.getBoundingClientRect()))}
      onBlur={() => setBox(null)}
    >
      <span className="term-hover-label">{children ?? label}</span>
      {box && createPortal(
        <span className="term-float term-layer" role="tooltip" style={{ left: box.left, top: box.top }}>
          <strong>{entry.title}</strong>
          <span>{entry.description}</span>
          <em>Why it matters</em>
          <span>{entry.why}</span>
        </span>,
        document.body,
      )}
    </span>
  );
}
