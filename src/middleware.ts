import { clerkMiddleware, createRouteMatcher } from '@clerk/nextjs/server';
import { NextResponse } from 'next/server';

// 公開ルート (認証不要)
const isPublicRoute = createRouteMatcher([
  '/', 
  '/v1',           // デザイン1 LP（旧デザイン）
  '/v2',           // / へリダイレクト
  '/sign-in(.*)', 
  '/sign-up(.*)',
  '/api/webhooks(.*)' // Clerk Webhook用
]);

// オンボーディングルート
const isOnboardingRoute = createRouteMatcher(['/onboarding']);

export default clerkMiddleware(async (auth, req) => {
  const { userId, redirectToSignIn } = await auth();

  // 1. 未ログインで非公開ルートにアクセスした場合 -> サインインへ
  if (!userId && !isPublicRoute(req)) {
    return redirectToSignIn();
  }

  // 2. ログイン済みでLPにアクセスした場合 -> ダッシュボードへ（デザイン2をメインに）
  if (userId && req.nextUrl.pathname === '/') {
    return NextResponse.redirect(new URL('/v2/dashboard', req.url));
  }
  if (userId && (req.nextUrl.pathname === '/v2' || req.nextUrl.pathname === '/v1')) {
    return NextResponse.redirect(new URL('/v2/dashboard', req.url));
  }
  // デザイン2をメインにしたため、/dashboard は /v2/dashboard へ
  if (userId && req.nextUrl.pathname === '/dashboard') {
    return NextResponse.redirect(new URL('/v2/dashboard', req.url));
  }

  // 3. (本来はここで「プロフィール未登録ならオンボーディングへ強制遷移」も入れたいが、
  //     DBアクセスが必要になるため、ミドルウェアではなく各ページ(layout.tsx等)でやるのがNext.jsの定石)

  return NextResponse.next();
});

export const config = {
  matcher: [
    // Skip Next.js internals and all static files, unless found in search params
    '/((?!_next|[^?]*\\.(?:html?|css|js(?!on)|jpe?g|webp|png|gif|svg|ttf|woff2?|ico|csv|docx?|xlsx?|zip|webmanifest)).*)',
    // Always run for API routes
    '/(api|trpc)(.*)',
  ],
};
