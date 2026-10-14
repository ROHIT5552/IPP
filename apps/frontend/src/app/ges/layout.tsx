import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'GES accounts',
  'Open a GES account and review its renewable requirement in NewRa IPP Comparator.',
  '/ges',
);

export default function GesLayout({ children }: { children: React.ReactNode }) {
  return children;
}
