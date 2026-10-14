const API_URL = process.env.NEXT_PUBLIC_API_URL ?? 'http://localhost:4010/api';
const TOKEN_KEY = 'newra.access-token';
const AUTH_SKIP = new Set(['/auth/login', '/auth/refresh', '/auth/logout']);

export const SESSION_EXPIRED = 'newra:session-expired';

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
  readonly status: number;

  constructor(status: number, message: string) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
  }
}

type HttpRequest = {
  path: string;
  init: RequestInit;
  retry: boolean;
};

type RequestInterceptor = (request: HttpRequest) => Promise<HttpRequest> | HttpRequest;
type ResponseInterceptor = (response: Response, request: HttpRequest) => Promise<Response>;

const requestInterceptors: RequestInterceptor[] = [];
const responseInterceptors: ResponseInterceptor[] = [];

export function addRequestInterceptor(interceptor: RequestInterceptor) {
  requestInterceptors.push(interceptor);
}

export function addResponseInterceptor(interceptor: ResponseInterceptor) {
  responseInterceptors.push(interceptor);
}

export function readErrorMessage(body: unknown, status: number) {
  if (body && typeof body === 'object' && 'message' in body) {
    const message = (body as { message?: unknown }).message;
    if (Array.isArray(message)) return message.map(String).join(' ');
    if (typeof message === 'string' && message.trim()) return message;
  }
  return `Request failed (${status}).`;
}

export function unwrap<T>(payload: unknown): T {
  if (payload && typeof payload === 'object' && 'success' in payload && 'data' in payload) {
    return (payload as { data: T }).data;
  }
  return payload as T;
}

function readAccessToken(body: unknown) {
  if (!body || typeof body !== 'object') return null;
  const record = body as { accessToken?: string; data?: { accessToken?: string } };
  return record.data?.accessToken ?? record.accessToken ?? null;
}

let refreshing: Promise<boolean> | null = null;

function refreshAccessToken() {
  if (!refreshing) {
    refreshing = fetch(`${API_URL}/auth/refresh`, { method: 'POST', credentials: 'include' })
      .then(async (response) => {
        if (!response.ok) return false;
        const token = readAccessToken(await response.json().catch(() => null));
        if (!token) return false;
        tokenStore.set(token);
        return true;
      })
      .catch(() => false)
      .finally(() => {
        refreshing = null;
      });
  }
  return refreshing;
}

function expireSession() {
  tokenStore.clear();
  if (typeof window !== 'undefined') window.dispatchEvent(new Event(SESSION_EXPIRED));
}

async function applyRequestInterceptors(request: HttpRequest) {
  let current = request;
  for (const interceptor of requestInterceptors) current = await interceptor(current);
  return current;
}

function send(request: HttpRequest) {
  return fetch(`${API_URL}${request.path}`, request.init);
}

addRequestInterceptor((request) => {
  const headers = new Headers(request.init.headers);
  if (!headers.has('Content-Type')) headers.set('Content-Type', 'application/json');
  const token = tokenStore.get();
  if (token) headers.set('Authorization', `Bearer ${token}`);
  else headers.delete('Authorization');
  if (!headers.has('X-Request-Id') && typeof crypto !== 'undefined' && 'randomUUID' in crypto) {
    headers.set('X-Request-Id', crypto.randomUUID());
  }
  return { ...request, init: { ...request.init, credentials: 'include', headers } };
});

addResponseInterceptor(async (response, request) => {
  if (response.status !== 401 || !request.retry || !tokenStore.get() || AUTH_SKIP.has(request.path)) return response;
  const refreshed = await refreshAccessToken();
  if (!refreshed) {
    expireSession();
    return response;
  }
  return send(await applyRequestInterceptors({ ...request, retry: false }));
});

export async function request<T>(path: string, init: RequestInit = {}, retry = true): Promise<T> {
  const prepared = await applyRequestInterceptors({ path, init, retry });
  let response = await send(prepared);
  for (const interceptor of responseInterceptors) response = await interceptor(response, prepared);
  if (!response.ok) {
    const body = await response.json().catch(() => null);
    throw new ApiError(response.status, readErrorMessage(body, response.status));
  }
  if (response.status === 204) return undefined as T;
  return unwrap<T>(await response.json());
}
