import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'Sign in',
  'Sign in to NewRa IPP Comparator to score and compare independent power producers for your GES account.',
  '/login',
);

export default function LoginLayout({ children }: { children: React.ReactNode }) {
  return children;
}
