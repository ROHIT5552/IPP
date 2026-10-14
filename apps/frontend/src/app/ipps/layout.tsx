import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'Independent power producers',
  'Review independent power producers, capacity, contacts, and company records in NewRa IPP Comparator.',
  '/ipps',
);

export default function IppLayout({ children }: { children: React.ReactNode }) {
  return children;
}
