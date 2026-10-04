'use client';

import { PropsWithChildren, createContext, useContext, useEffect, useState } from 'react';
import { usePathname, useRouter } from 'next/navigation';
import { GES_ACCOUNTS } from '../../constants/demo';
import { useAuth } from '../auth/AuthProvider';

interface WorkspaceState {
  gesId: string;
  selectGes: (id: string) => void;
}

const WorkspaceContext = createContext<WorkspaceState | null>(null);

export function WorkspaceProvider({ children }: PropsWithChildren) {
  const { user } = useAuth();
  const lockedGes = user?.gesId || null;
  const [gesId, setGesId] = useState(lockedGes || 'ges_aster');
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    if (lockedGes) {
      setGesId(lockedGes);
      if (pathname === '/ges/new' || pathname.endsWith('/edit')) {
        router.replace('/ges');
        return;
      }
      if (pathname.startsWith('/ges/') && !pathname.startsWith(`/ges/${lockedGes}`)) {
        router.replace(pathname.replace(/^\/ges\/[^/]+/, `/ges/${lockedGes}`));
      }
      return;
    }
    const match = pathname.match(/^\/ges\/(ges_[^/]+)/);
    if (match) setGesId(match[1]);
  }, [pathname, lockedGes, router]);

  const selectGes = (id: string) => {
    if (lockedGes && id !== lockedGes) return;
    setGesId(id);
    const route = window.location.pathname;
    if (/^\/ges\/ges_/.test(route)) {
      router.push(route.replace(/^\/ges\/[^/]+/, `/ges/${id}`));
    }
  };

  return (
    <WorkspaceContext.Provider value={{ gesId, selectGes }}>
      {children}
    </WorkspaceContext.Provider>
  );
}

export function useWorkspace() {
  const value = useContext(WorkspaceContext);
  if (!value) throw new Error('useWorkspace must be used inside WorkspaceProvider.');
  return value;
}

export { GES_ACCOUNTS };
