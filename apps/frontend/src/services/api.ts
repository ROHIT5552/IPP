const API_URL = process.env.NEXT_PUBLIC_API_URL ?? 'http://localhost:4010/api';

/** GES and IPP lists stay cached, then refresh on this interval. */
export const LIST_REFRESH_MS = 5 * 60 * 1000;
export const listQuery = { staleTime: LIST_REFRESH_MS, refetchInterval: LIST_REFRESH_MS };
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
  if (response.status === 401 && retry && token && path !== '/auth/login' && path !== '/auth/refresh' && path !== '/auth/logout') {
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
  logout: () => request<unknown>('/auth/logout', { method: 'POST', body: '{}' }, false),
  login: (email: string, password: string) =>
    request<{ user: import('../types/api').AuthUser; accessToken: string }>(
      '/auth/login',
      { method: 'POST', body: JSON.stringify({ email, password }) },
      false,
    ),
  gesProfiles: () => request<import('../types/api').GesLoginProfile[]>('/auth/ges-profiles'),
  requestGesOtp: (profileId: string) =>
    request<import('../types/api').GesOtpChallenge>(
      '/auth/ges-otp',
      { method: 'POST', body: JSON.stringify({ profileId }) },
      false,
    ),
  verifyGesOtp: (profileId: string, code: string) =>
    request<{ user: import('../types/api').AuthUser; accessToken: string }>(
      '/auth/ges-otp/verify',
      { method: 'POST', body: JSON.stringify({ profileId, code }) },
      false,
    ),
  requestGesOtpByEmail: (email: string) =>
    request<import('../types/api').GesOtpChallenge>(
      '/auth/ges-otp/email',
      { method: 'POST', body: JSON.stringify({ email }) },
      false,
    ),
  startSignup: (body: { name: string; email: string; gesName: string; phone: string }) =>
    request<import('../types/api').GesOtpChallenge>('/auth/signup', { method: 'POST', body: JSON.stringify(body) }, false),
  verifySignup: (email: string, code: string) =>
    request<{ pending: true; emailSent: boolean }>('/auth/signup/verify', { method: 'POST', body: JSON.stringify({ email, code }) }, false),
  household: () => request<import('../types/api').GesHousehold>('/auth/household'),
  addProfile: (body: { name: string; email: string; phone: string }) =>
    request<import('../types/api').GesOtpChallenge>('/auth/profiles', { method: 'POST', body: JSON.stringify(body) }),
  verifyAddedProfile: (email: string, code: string) =>
    request<{ pending: true; emailSent: boolean }>('/auth/profiles/verify', { method: 'POST', body: JSON.stringify({ email, code }) }, false),
  gesAccess: () => request<import('../types/api').GesAccessRow[]>('/auth/ges-access'),
  addGesAccess: (body: { name: string; email: string; phone: string; gesId: string }) =>
    request<{ id: string }>('/auth/ges-access', { method: 'POST', body: JSON.stringify(body) }),
  approveGesAccess: (userId: string) => request<{ id: string }>(`/auth/ges-access/${userId}/approve`, { method: 'POST', body: '{}' }),
  removeGesAccess: (userId: string) => request<{ id: string }>(`/auth/ges-access/${userId}`, { method: 'DELETE' }),
};
