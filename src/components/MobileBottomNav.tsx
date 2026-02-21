'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useAuth } from '@clerk/nextjs';

const navItems = [
  { href: '/v2/dashboard', label: 'ホーム', icon: '🏠' },
  { href: '/search', label: '検索', icon: '🔍' },
  { href: '/messages', label: 'メッセージ', icon: '💬' },
  { href: '/map', label: 'マップ', icon: '📍' },
  { href: '/profile', label: 'プロフィール', icon: '👤' },
];

function isActive(pathname: string, href: string) {
  if (href === '/v2/dashboard') return pathname === '/dashboard' || pathname === '/' || pathname === '/v2/dashboard';
  if (href === '/messages') return pathname.startsWith('/messages');
  if (href === '/profile') return pathname.startsWith('/profile');
  return pathname.startsWith(href);
}

export function MobileBottomNav() {
  const pathname = usePathname();
  const { isSignedIn } = useAuth();

  const showPaths = ['/dashboard', '/v2/dashboard', '/search', '/messages', '/map', '/profile', '/groups', '/events', '/residents', '/users'];
  const shouldShow = isSignedIn && (pathname === '/' || showPaths.some((p) => pathname.startsWith(p)));

  if (!shouldShow) return null;

  return (
    <nav
      className="fixed bottom-0 left-0 right-0 z-50 lg:hidden bg-white/95 backdrop-blur border-t border-stone-200/80 shadow-[0_-4px_20px_rgba(0,0,0,0.06)] pb-[env(safe-area-inset-bottom,0)]"
      aria-label="メインナビゲーション"
    >
      <div className="flex items-stretch justify-around">
        {navItems.map((item) => {
          const active = isActive(pathname, item.href);
          return (
            <Link
              key={item.href}
              href={item.href}
              className={`flex flex-col items-center justify-center min-h-[56px] flex-1 py-2 px-1 transition-colors ${
                active ? 'text-orange-600 font-semibold' : 'text-stone-500'
              }`}
            >
              <span className="text-xl leading-none">{item.icon}</span>
              <span className="text-[10px] mt-0.5">{item.label}</span>
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
