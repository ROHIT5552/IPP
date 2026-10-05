'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { NewraLoader } from '../components/DataState';
import { destinationFor, useAuth } from '../features/auth/AuthProvider';

export default function Home() {
  const { user, ready } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (!ready) return;
    router.replace(destinationFor(user));
  }, [ready, user, router]);

  return <NewraLoader label="Opening your workspace" />;
}
