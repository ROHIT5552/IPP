import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'IPP comparator',
  'Compare scored independent power producers, gates, and quoted tariffs for a GES account.',
  '/comparison',
);

export default function ComparisonLayout({ children }: { children: React.ReactNode }) {
  return children;
}
