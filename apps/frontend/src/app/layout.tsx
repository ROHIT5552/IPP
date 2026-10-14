import type { Metadata, Viewport } from 'next';
import { Providers } from '../components/Providers';
import { WorkspaceProvider } from '../features/workspace/WorkspaceProvider';
import { SITE_DESCRIPTION, SITE_URL } from '../seo/metadata';
import { fontVariables } from './fonts';
import './globals.css';
import './globals-extra.css';

export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: { default: 'NewRa IPP Comparator', template: '%s · NewRa IPP Comparator' },
  description: SITE_DESCRIPTION,
  applicationName: 'NewRa IPP Comparator',
  keywords: ['NewRa', 'NewRa Grids', 'IPP comparator', 'independent power producer', 'GES', 'renewable energy', 'tariff'],
  authors: [{ name: 'NewRa Grids', url: 'https://newragrids.in' }],
  creator: 'NewRa Grids',
  alternates: { canonical: '/' },
  openGraph: {
    type: 'website',
    locale: 'en_IN',
    url: '/',
    siteName: 'NewRa IPP Comparator',
    title: 'NewRa IPP Comparator',
    description: SITE_DESCRIPTION,
  },
  twitter: { card: 'summary', title: 'NewRa IPP Comparator', description: SITE_DESCRIPTION },
  robots: { index: true, follow: true },
  icons: { icon: [{ url: '/favicon.png', type: 'image/png' }] },
  category: 'business',
};

export const viewport: Viewport = {
  width: 'device-width',
  initialScale: 1,
  themeColor: '#09193C',
};

const jsonLd = {
  '@context': 'https://schema.org',
  '@type': 'SoftwareApplication',
  name: 'NewRa IPP Comparator',
  applicationCategory: 'BusinessApplication',
  operatingSystem: 'Web',
  description: SITE_DESCRIPTION,
  url: SITE_URL,
  provider: { '@type': 'Organization', name: 'NewRa Grids', url: 'https://newragrids.in' },
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en" className={fontVariables}>
      <body>
        <a className="skip-link" href="#main">Skip to content</a>
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
        <Providers>
          <WorkspaceProvider>{children}</WorkspaceProvider>
        </Providers>
      </body>
    </html>
  );
}
