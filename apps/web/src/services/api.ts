const API_URL = process.env.NEXT_PUBLIC_API_URL ?? 'http://localhost:4010/api';
const TOKEN_KEY = 'newra.access-token';

export const tokenStore = {
  get() {
    return typeof window === 'undefined' ? null : window.localStorage.getItem(TOKEN_KEY);
  },
  set(token: string) {
    window.localStorage.setItem(TOKEN_KEY, token);
  },
  clear() {
    window.localStorage.removeItem(TOKEN_KEY);
  },
};

export class ApiError extends Error {
  status: number;
  constructor(status: number, message: string) {
    super(message);
    this.status = status;
  }
}

async function request<T>(path: string, init: RequestInit = {}, retry = true): Promise<T> {
  const token = tokenStore.get();
  let response = await fetch(`${API_URL}${path}`, {
    ...init,
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...init.headers,
    },
  });
  if (response.status === 401 && retry && path !== '/auth/login') {
    const refreshed = await fetch(`${API_URL}/auth/refresh`, {
      method: 'POST',
      credentials: 'include',
    });
    if (refreshed.ok) {
      const result = (await refreshed.json()) as { accessToken?: string; data?: { accessToken?: string } };
      const accessToken = result.data?.accessToken ?? result.accessToken;
      if (accessToken) tokenStore.set(accessToken);
      return request<T>(path, init, false);
    }
    tokenStore.clear();
  }
  if (!response.ok) {
    const body = await response.json().catch(() => null);
    const message = Array.isArray(body?.message)
      ? body.message.join(' ')
      : body?.message ?? `Request failed (${response.status}).`;
    throw new ApiError(response.status, message);
  }
  const payload = (await response.json()) as T & { success?: boolean; data?: T };
  if (payload && typeof payload === 'object' && 'success' in payload && 'data' in payload) {
    return payload.data as T;
  }
  return payload;
}

export const api = {
  get: <T>(path: string) => request<T>(path),
  post: <T>(path: string, body?: unknown) =>
    request<T>(path, { method: 'POST', body: JSON.stringify(body ?? {}) }),
  patch: <T>(path: string, body: unknown) =>
    request<T>(path, { method: 'PATCH', body: JSON.stringify(body) }),
  delete: <T>(path: string) => request<T>(path, { method: 'DELETE' }),
  login: (email: string, password: string) =>
    request<{ user: import('../types/api').AuthUser; accessToken: string }>(
      '/auth/login',
      { method: 'POST', body: JSON.stringify({ email, password }) },
      false,
    ),
};
