import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'GES workspace',
  'Review your GES profile and independent power producers in NewRa IPP Comparator.',
  '/client/profile',
);

export default function ClientLayout({ children }: { children: React.ReactNode }) {
  return children;
}
