import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'Portfolio',
  'Portfolio overview for GES accounts in NewRa IPP Comparator.',
  '/dashboard',
);

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  return children;
}
