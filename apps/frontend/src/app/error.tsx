'use client';

import { RouteErrorScreen } from '../components/StatusScreens';

export default function Error({ reset }: { error: Error & { digest?: string }; reset: () => void }) {
  return <RouteErrorScreen reset={reset} />;
}
