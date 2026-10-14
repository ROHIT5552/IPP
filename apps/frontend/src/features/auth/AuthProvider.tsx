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
import { isKnownPath, isPublicPath } from '../../app/routes';
import { api, SESSION_EXPIRED, tokenStore } from '../../services/api';
import { AuthUser } from '../../types/api';

const RETURN_KEY = 'newra.ges-return';
export const PROFILE_KEY = 'newra.profile';

interface AuthState {
  user: AuthUser | null;
  ready: boolean;
  signIn: (email: string, password: string) => Promise<void>;
  signInWithCode: (profileId: string, code: string) => Promise<AuthUser>;
  signOut: () => void;
}

export function destinationFor(current: AuthUser | null) {
  if (!current) return '/login';
  if (current.gesId) return '/client/profile';
  return '/ges';
}

const AuthContext = createContext<AuthState | null>(null);

export function AuthProvider({ children }: PropsWithChildren) {
  const [user, setUser] = useState<AuthUser | null>(null);
  const [ready, setReady] = useState(false);
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    let active = true;
    if (!tokenStore.get()) {
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
    const expire = () => {
      setUser(null);
      const current = window.location.pathname;
      if (isKnownPath(current) && !isPublicPath(current)) router.replace('/login');
    };
    window.addEventListener(SESSION_EXPIRED, expire);
    return () => window.removeEventListener(SESSION_EXPIRED, expire);
  }, [router]);

  useEffect(() => {
    if (!ready || pathname === '/staff' || !isKnownPath(pathname)) return;
    const publicPage = isPublicPath(pathname);
    if (!user) {
      if (!publicPage) router.replace('/login');
      return;
    }
    const destination = destinationFor(user);
    if (destination === pathname) return;
    if (publicPage || pathname === '/whos-watching' || pathname === '/signup' || pathname === '/' || (!user.gesId && pathname === '/dashboard')) {
      router.replace(destination);
    }
  }, [ready, user, pathname, router]);

  const applySession = useCallback((result: { accessToken: string; user: AuthUser }) => {
    tokenStore.set(result.accessToken);
    setUser(result.user);
  }, []);

  const signIn = useCallback(async (email: string, password: string) => {
    applySession(await api.login(email, password));
  }, [applySession]);

  const signInWithCode = useCallback(async (profileId: string, code: string) => {
    const result = await api.verifyGesOtp(profileId, code);
    applySession(result);
    return result.user;
  }, [applySession]);

  const signOut = useCallback(() => {
    void api.logout().catch(() => undefined);
    tokenStore.clear();
    window.sessionStorage.removeItem(PROFILE_KEY);
    setUser(null);
    router.replace('/login');
  }, [router]);

  const value = useMemo(
    () => ({ user, ready, signIn, signInWithCode, signOut }),
    [user, ready, signIn, signInWithCode, signOut],
  );
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const value = useContext(AuthContext);
  if (!value) throw new Error('useAuth must be used inside AuthProvider.');
  return value;
}

/** True only after mount when a saved session exists. Public pages can render their HTML immediately. */
export function useHasSession() {
  const [hasSession, setHasSession] = useState(false);
  useEffect(() => {
    setHasSession(Boolean(tokenStore.get()));
  }, []);
  return hasSession;
}
