import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'Create an account',
  'Create a NewRa IPP Comparator account for your organisation. NewRa Grids reviews the request before you can sign in.',
  '/signup',
);

export default function SignupLayout({ children }: { children: React.ReactNode }) {
  return children;
}
