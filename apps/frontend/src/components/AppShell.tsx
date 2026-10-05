'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import {
  Activity,
  ArrowUpRight,
  Bell,
  BookOpen,
  ChevronDown,
  CircleHelp,
  ClipboardCheck,
  LayoutDashboard,
  LogOut,
  Scale,
  Settings2,
  Sun,
  UsersRound,
  Zap,
} from 'lucide-react';
import { PropsWithChildren, useEffect } from 'react';
import { NewraLoader } from './DataState';
import { useAuth } from '../features/auth/AuthProvider';
import { useWorkspace } from '../features/workspace/WorkspaceProvider';
import { api, listQuery } from '../services/api';
import { GesAccount } from '../types/api';

const staffPrimary = [
  { href: '/dashboard', label: 'Overview', icon: LayoutDashboard },
  { href: '/ges', label: 'GES', icon: UsersRound },
  { href: '/ipps', label: 'Independent power producer', icon: Sun },
  { href: '/comparison', label: 'IPP comparator', icon: Scale },
];

const customerPrimary = [
  { href: '/client/profile', label: 'GES profile', icon: UsersRound },
  { href: '/client/requirements', label: 'GES requirement', icon: ClipboardCheck },
  { href: '/client/ipps', label: 'IPP catalogue', icon: Sun },
  { href: '/client/my-ipps', label: 'My IPPs', icon: BookOpen },
  { href: '/comparison', label: 'IPP comparator', icon: Scale },
];

const staffWorkflow = [
  { href: '/profile', label: 'GES profile', icon: UsersRound },
  { href: '/requirements', label: 'GES requirement', icon: ClipboardCheck },
  { href: '/catalogue', label: 'Consider an IPP', icon: Sun },
  { href: '/selections', label: 'Selected IPPs', icon: BookOpen },
  { href: '/negotiation', label: 'Negotiation', icon: ArrowUpRight },
  { href: '/psoa', label: 'PSOA evidence', icon: ClipboardCheck },
  { href: '/dealbook', label: 'Dealbook', icon: BookOpen },
];

export function AppShell({ children }: PropsWithChildren) {
  const pathname = usePathname();
  const { user, ready, signOut } = useAuth();
  useEffect(() => {
    if (user?.gesId && pathname && pathname !== '/whos-watching') {
      window.sessionStorage.setItem('newra.ges-return', pathname);
    }
  }, [user, pathname]);
  const { gesId, selectGes } = useWorkspace();
  const accountsQuery = useQuery({
    queryKey: ['ges'],
    queryFn: () => api.get<GesAccount[]>('/ges'),
    enabled: Boolean(user),
    ...listQuery,
  });
  const liveAccounts = accountsQuery.data?.map((account) => ({ id: account.id, code: account.code, name: account.name, state: account.state ?? '' }));
  useEffect(() => {
    if (!user || user.gesId || !accountsQuery.data?.length) return;
    if (accountsQuery.data.some((account) => account.id === gesId)) return;
    const fromPath = pathname.match(/^\/ges\/(ges_[^/]+)/)?.[1];
    const next = accountsQuery.data.find((account) => account.id === fromPath)?.id ?? accountsQuery.data[0].id;
    selectGes(next);
  }, [user, accountsQuery.data, gesId, pathname, selectGes]);
  const customer = Boolean(user?.gesId);
  const primaryNav = customer
    ? customerPrimary
    : [...staffPrimary, ...(user?.role === 'ADMIN' ? [{ href: '/ges-access', label: 'GES access', icon: UsersRound }] : [])];
  const workflowNav = customer ? [] : staffWorkflow;
  const accounts = (liveAccounts ?? []).filter((item) => !user?.gesId || item.id === user.gesId);
  const currentGes = accounts.find((item) => item.id === gesId) ?? accounts[0];
  const isActive = (href: string) => {
    if (href === '/ges') return pathname === '/ges' || pathname === '/ges/new' || pathname.endsWith('/edit') || /^\/ges\/[^/]+$/.test(pathname);
    if (href === '/ipps') return pathname.startsWith('/ipps');
    if (href === '/comparison') return pathname.includes('/comparison');
    if (href.startsWith('/client/')) return pathname === href || pathname.startsWith(`${href}/`);
    return pathname.endsWith(href);
  };
  const crumb = pathname.startsWith('/ipps')
    ? 'Independent power producer'
    : pathname === '/ges' || pathname === '/ges/new' || pathname.endsWith('/edit')
      ? 'GES'
      : /^\/ges\/ges_/.test(pathname)
        ? currentGes?.name ?? 'GES'
        : 'Portfolio overview';
  const hrefFor = (href: string) =>
    ['/comparison', '/negotiation', '/psoa', '/dealbook', '/profile', '/requirements', '/catalogue', '/selections'].includes(href)
      ? `/ges/${currentGes?.id ?? gesId}${href}`
      : href;
  if (!ready || !user) return <NewraLoader label="Opening your workspace" />;

  const roleLabel = customer
    ? 'GES account'
    : user?.role === 'ADMIN'
      ? 'NewRa Grids'
      : user?.role === 'NEWRA_ADMIN'
        ? 'NewRa Admin'
        : (user?.role ?? '').replaceAll('_', ' ').toLowerCase();

  return (
    <div className="workspace">
      <aside className="sidebar">
        <Link href={customer ? '/client/profile' : '/dashboard'} className="brand">
          <span className="brand-mark"><Zap size={19} fill="currentColor" /></span>
          <span>newra<span className="brand-dot">.</span><small>ENERGY DECISIONS</small></span>
        </Link>
        <div className="nav-heading">PLATFORM</div>
        <nav className="nav-list">
          {primaryNav.map((item) => {
            const Icon = item.icon;
            return (
              <Link className={isActive(item.href) ? 'nav-link active' : 'nav-link'} href={hrefFor(item.href)} key={item.href}>
                <Icon size={17} strokeWidth={1.8} />
                <span>{item.label}</span>
              </Link>
            );
          })}
        </nav>
        {workflowNav.length > 0 && <div className="nav-heading workflow-heading">GES WORKFLOW</div>}
        <nav className="nav-list">
          {workflowNav.map((item) => {
            const Icon = item.icon;
            return (
              <Link className={pathname.endsWith(item.href) ? 'nav-link active' : 'nav-link'} href={hrefFor(item.href)} key={item.href}>
                <Icon size={17} strokeWidth={1.8} />
                <span>{item.label}</span>
              </Link>
            );
          })}
        </nav>
        <div className="sidebar-bottom">
          <div className="sidebar-help"><CircleHelp size={16} /><span>Demo workspace</span><span className="help-version">v1.0</span></div>
          <button className="user-row" onClick={signOut}>
            <span className="avatar">{user?.name.split(' ').map((part) => part[0]).join('').slice(0, 2)}</span>
            <span className="user-meta"><strong>{user?.name}</strong><small>{user?.gesId ? user.title : roleLabel}</small></span>
            <LogOut size={16} />
          </button>
        </div>
      </aside>
      <main className="main-shell">
        <header className="topbar">
          <div className="breadcrumbs">
            <span>Energy platform</span><span className="crumb-separator">/</span>
            <strong>{crumb}</strong>
          </div>
          <div className="topbar-actions">
            <label className="ges-switcher">
              <span>GES account</span>
              {accountsQuery.isLoading ? <span className="skeleton skeleton-switch" aria-hidden="true" /> : (
                <>
                  <select value={currentGes?.id ?? ''} onChange={(event) => selectGes(event.target.value)} aria-label="Select GES account" disabled={Boolean(user?.gesId)}>
                    {accounts.map((account) => <option key={account.id} value={account.id}>{account.name}</option>)}
                  </select>
                  <ChevronDown size={14} />
                </>
              )}
            </label>
            <button className="icon-button" aria-label="Notifications"><Bell size={18} /><i /></button>
            <button className="icon-button" aria-label="Settings"><Settings2 size={18} /></button>
            <div className="top-avatar">{user?.name.split(' ').map((part) => part[0]).join('').slice(0, 2)}</div>
          </div>
        </header>
        <div className="content-area">{children}</div>
        <footer className="page-footer"><span><Activity size={13} /> All decision scores calculated by the NewRa evaluation API</span><span>Internal energy decision workspace</span></footer>
      </main>
    </div>
  );
}

export function PageHeader({
  eyebrow,
  title,
  description,
  children,
}: PropsWithChildren<{ eyebrow?: string; title: string; description?: string }>) {
  return (
    <div className="page-heading">
      <div>
        {eyebrow && <div className="eyebrow">{eyebrow}</div>}
        <h1>{title}</h1>
        {description && <p>{description}</p>}
      </div>
      {children && <div className="heading-actions">{children}</div>}
    </div>
  );
}
