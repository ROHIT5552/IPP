import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'Evaluation',
  'Evaluation workspace for NewRa IPP Comparator.',
  '/evaluation',
);

export default function EvaluationLayout({ children }: { children: React.ReactNode }) {
  return children;
}
