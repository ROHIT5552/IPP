import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'GES access',
  'Review and approve GES access requests in NewRa IPP Comparator.',
  '/ges-access',
);

export default function GesAccessLayout({ children }: { children: React.ReactNode }) {
  return children;
}
