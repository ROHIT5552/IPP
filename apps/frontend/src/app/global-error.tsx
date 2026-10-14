'use client';

import { ArrowRight } from 'lucide-react';
import { StatusCard } from '../components/StatusScreens';
import { fontVariables } from './fonts';
import './globals.css';
import './globals-extra.css';

export default function GlobalError({ reset }: { error: Error & { digest?: string }; reset: () => void }) {
  return (
    <html lang="en" className={fontVariables}>
      <body>
        <main id="main" className="signin-page">
          <StatusCard
            code="Error"
            title="The workspace hit a problem."
            message="NewRa IPP Comparator stopped before this page could finish. Try again, or start over."
            actions={(
              <>
                <button className="primary-button" type="button" onClick={reset}>
                  Try again
                  <ArrowRight size={18} />
                </button>
                <a className="secondary-button" href="/">Back to start</a>
              </>
            )}
          />
        </main>
      </body>
    </html>
  );
}
