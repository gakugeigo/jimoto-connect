import { 
  SignInButton, 
  SignUpButton, 
  SignedIn, 
  SignedOut, 
  UserButton 
} from '@clerk/nextjs'
import Link from 'next/link'

export function Header() {
  return (
    <header className="sticky top-0 z-50 border-b bg-white/95 backdrop-blur supports-[backdrop-filter]:bg-white/60">
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center justify-between">
          {/* ロゴとナビゲーション */}
          <div className="flex items-center space-x-8">
            <Link href="/" className="text-2xl font-bold text-amber-600">
              Jimoto-Connect
            </Link>
            
            <SignedIn>
              <nav className="hidden md:flex space-x-6">
                <Link 
                  href="/dashboard" 
                  className="text-sm font-medium hover:text-amber-600 transition-colors"
                >
                  ダッシュボード
                </Link>
                <Link 
                  href="/profile" 
                  className="text-sm font-medium hover:text-amber-600 transition-colors"
                >
                  プロフィール
                </Link>
              </nav>
            </SignedIn>
          </div>

          {/* 認証ボタン */}
          <div className="flex items-center space-x-4">
            <SignedOut>
              <SignInButton mode="modal">
                <button className="text-sm font-medium text-gray-700 hover:text-amber-600 transition-colors">
                  ログイン
                </button>
              </SignInButton>
              <SignUpButton mode="modal">
                <button className="px-4 py-2 text-sm font-medium bg-amber-600 text-white rounded-lg hover:bg-amber-700 transition-colors">
                  新規登録
                </button>
              </SignUpButton>
            </SignedOut>
            
            <SignedIn>
              <UserButton 
                afterSignOutUrl="/"
                appearance={{
                  elements: {
                    avatarBox: "w-10 h-10 rounded-full"
                  }
                }}
              />
            </SignedIn>
          </div>
        </div>
      </div>
    </header>
  )
}
