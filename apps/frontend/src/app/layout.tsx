import type { Metadata } from 'next';
import { Providers } from '../components/Providers';
import { WorkspaceProvider } from '../features/workspace/WorkspaceProvider';
import './globals.css';
import './globals-extra.css';

export const metadata: Metadata = {
  title: 'NewRa | Energy Decision Platform',
  description: 'GES and renewable provider comparison workspace',
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body>
        <Providers>
          <WorkspaceProvider>{children}</WorkspaceProvider>
        </Providers>
      </body>
    </html>
  );
}
