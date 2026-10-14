import type { Metadata } from 'next';

export const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL ?? 'http://localhost:3010';

export const SITE_DESCRIPTION =
  'Score and compare independent power producers for a GES account. NewRa IPP Comparator brings questionnaire ratings, tariffs, and the scorecard into one workspace.';

export function pageMetadata(title: string, description: string, path: string): Metadata {
  return {
    title,
    description,
    alternates: { canonical: path },
    openGraph: { title, description, url: path },
    twitter: { title, description },
  };
}
