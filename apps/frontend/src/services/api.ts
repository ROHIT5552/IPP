import { ApiError, request, SESSION_EXPIRED, tokenStore } from './http';

export { ApiError, SESSION_EXPIRED, tokenStore };

/** GES and IPP lists stay cached, then refresh on this interval. */
export const LIST_REFRESH_MS = 5 * 60 * 1000;
export const listQuery = { staleTime: LIST_REFRESH_MS, refetchInterval: LIST_REFRESH_MS };

export const api = {
  get: <T>(path: string) => request<T>(path),
  post: <T>(path: string, body?: unknown) =>
    request<T>(path, { method: 'POST', body: JSON.stringify(body ?? {}) }),
  patch: <T>(path: string, body: unknown) =>
    request<T>(path, { method: 'PATCH', body: JSON.stringify(body) }),
  put: <T>(path: string, body: unknown) =>
    request<T>(path, { method: 'PUT', body: JSON.stringify(body) }),
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
