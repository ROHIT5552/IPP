import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'Staff sign in',
  'Staff sign in for NewRa IPP Comparator.',
  '/staff',
);

export default function StaffLayout({ children }: { children: React.ReactNode }) {
  return children;
}
