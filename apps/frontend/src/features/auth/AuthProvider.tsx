'use client';

import {
  createContext,
  PropsWithChildren,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
} from 'react';
import { usePathname, useRouter } from 'next/navigation';
import { api, tokenStore } from '../../services/api';
import { AuthUser } from '../../types/api';

interface AuthState {
  user: AuthUser | null;
  ready: boolean;
  signIn: (email: string, password: string) => Promise<void>;
  signOut: () => void;
}

const AuthContext = createContext<AuthState | null>(null);

export function AuthProvider({ children }: PropsWithChildren) {
  const [user, setUser] = useState<AuthUser | null>(null);
  const [ready, setReady] = useState(false);
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    let active = true;
    const token = tokenStore.get();
    if (!token) {
      setReady(true);
      return;
    }
    api
      .get<AuthUser>('/auth/me')
      .then((currentUser) => {
        if (active) setUser(currentUser);
      })
      .catch(() => tokenStore.clear())
      .finally(() => {
        if (active) setReady(true);
      });
    return () => {
      active = false;
    };
  }, []);

  useEffect(() => {
    if (ready && !user && pathname !== '/login') router.replace('/login');
    if (ready && user && pathname === '/login') router.replace('/dashboard');
  }, [ready, user, pathname, router]);

  const signIn = useCallback(async (email: string, password: string) => {
    const result = await api.login(email, password);
    tokenStore.set(result.accessToken);
    setUser(result.user);
  }, []);

  const signOut = useCallback(() => {
    tokenStore.clear();
    setUser(null);
    router.replace('/login');
  }, [router]);

  const value = useMemo(() => ({ user, ready, signIn, signOut }), [user, ready, signIn, signOut]);
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const value = useContext(AuthContext);
  if (!value) throw new Error('useAuth must be used inside AuthProvider.');
  return value;
}
