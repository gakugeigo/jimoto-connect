'use client';

import Link from 'next/link';

// --- Icons (SVG) ---
const Icons = {
  Search: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" className="w-6 h-6">
      <circle cx="11" cy="11" r="8" />
      <path d="m21 21-4.3-4.3" />
    </svg>
  ),
  School: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-12 h-12">
      <path d="m4 6 8-4 8 4" />
      <path d="m18 10 4 2v8a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2v-8l4-2" />
      <path d="M14 22v-4a2 2 0 0 0-2-2v0a2 2 0 0 0-2 2v4" />
      <path d="M18 5v17" />
      <path d="M6 5v17" />
      <circle cx="12" cy="9" r="2" />
    </svg>
  ),
  Users: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-12 h-12">
      <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
      <circle cx="9" cy="7" r="4" />
      <path d="M22 21v-2a4 4 0 0 0-3-3.87" />
      <path d="M16 3.13a4 4 0 0 1 0 7.75" />
    </svg>
  ),
  MapPin: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-12 h-12">
      <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z" />
      <circle cx="12" cy="10" r="3" />
    </svg>
  ),
  ArrowRight: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-5 h-5">
      <path d="M5 12h14" />
      <path d="m12 5 7 7-7 7" />
    </svg>
  )
};

export default function V1LandingPage() {
  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800 font-sans selection:bg-orange-200">
      
      {/* Header */}
      <header className="sticky top-0 z-50 bg-white/90 backdrop-blur-md border-b border-orange-100">
        <div className="container mx-auto px-6 h-20 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="bg-orange-600 text-white p-1.5 rounded-lg font-bold text-xl">JC</div>
            <span className="font-bold text-xl tracking-tight">Jimoto-Connect</span>
          </div>
          <div className="flex gap-4">
            <Link href="/sign-in" className="px-6 py-2.5 text-sm font-bold text-stone-600 hover:text-orange-600 transition">
              ログイン
            </Link>
            <Link href="/sign-up" className="px-6 py-2.5 bg-orange-600 text-white rounded-full text-sm font-bold shadow-lg shadow-orange-200 hover:bg-orange-700 transition hover:-translate-y-0.5">
              はじめる
            </Link>
          </div>
        </div>
      </header>

      <main>
        {/* Hero Section */}
        <section className="relative pt-12 pb-20 lg:pt-24 lg:pb-32 overflow-hidden">
          <div className="container mx-auto px-6">
            <div className="grid lg:grid-cols-2 gap-12 items-center">
              
              {/* Left: Text Content */}
              <div className="text-center lg:text-left z-10">
                <div className="inline-block px-4 py-1.5 bg-white border border-orange-100 rounded-full text-sm font-bold text-orange-600 shadow-sm mb-6">
                  ✨ 同じ高校の仲間が、近くにいる。
                </div>
                
                <h1 className="text-4xl md:text-6xl font-black tracking-tight leading-[1.1] mb-6 text-stone-900">
                  懐かしいあの場所に、<br />
                  <span className="text-orange-600 relative inline-block">
                    今すぐ帰ろう。
                    <svg className="absolute -bottom-2 left-0 w-full h-3 text-orange-200 -z-10" viewBox="0 0 100 10" preserveAspectRatio="none">
                      <path d="M0 5 Q 50 10 100 5" stroke="currentColor" strokeWidth="8" fill="none" />
                    </svg>
                  </span>
                </h1>
                
                <p className="text-lg text-stone-500 leading-relaxed mb-8 max-w-lg mx-auto lg:mx-0">
                  Jimoto-Connectは、あなたの中学高校の同級生や部活の仲間を
                  今住んでいるエリアで見つけられるSNSです。<br/>
                  <strong>「近くにいる地元の友達や仲間」</strong>を今すぐ見つけよう。
                </p>

                {/* Mock Search Bar (Interactive Feel) */}
                <div className="bg-white p-2 rounded-2xl shadow-xl border border-stone-100 max-w-md mx-auto lg:mx-0 mb-8 flex items-center gap-2 transform hover:scale-[1.02] transition-transform duration-300">
                  <div className="pl-4 text-stone-400">
                    <Icons.Search />
                  </div>
                  <div className="flex-1 text-left">
                    <div className="text-xs font-bold text-stone-400">出身校を検索</div>
                    <div className="text-stone-800 font-bold">例：那覇高校 2015年卒 野球部</div>
                  </div>
                  <Link href="/sign-up" className="bg-orange-600 text-white px-6 py-3 rounded-xl font-bold shadow-md hover:bg-orange-700 transition">
                    探す
                  </Link>
                </div>

                <div className="flex flex-col sm:flex-row justify-center lg:justify-start gap-4 text-sm font-bold text-stone-500">
                  <span className="flex items-center gap-1">✅ 登録無料</span>
                  <span className="flex items-center gap-1">✅ 実名制で安心</span>
                  <span className="flex items-center gap-1">✅ 今のエリアで検索</span>
                </div>
              </div>

              {/* Right: Image */}
              <div className="relative">
                {/* Decorative Blob */}
                <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[120%] h-[120%] bg-orange-100 rounded-full blur-3xl -z-10 opacity-60"></div>
                
                {/* Main Image (Fixed URL) */}
                <div className="relative rounded-3xl overflow-hidden shadow-2xl border-4 border-white rotate-2 hover:rotate-0 transition-transform duration-500 group">
                  <img 
                    src="https://images.unsplash.com/photo-1517927033932-b3d18e61fb3a?q=80&w=1000&auto=format&fit=crop" 
                    alt="High school baseball team huddle" 
                    className="w-full h-auto object-cover group-hover:scale-105 transition-transform duration-700"
                  />
                  
                  {/* Overlay Badge 1: User Found */}
                  <div className="absolute bottom-8 left-8 bg-white/95 backdrop-blur-sm px-5 py-3 rounded-2xl shadow-lg border border-stone-100 animate-fade-in-up">
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 rounded-full bg-orange-100 flex items-center justify-center text-xl">🎓</div>
                      <div>
                        <div className="text-xs font-bold text-stone-400">FOUND!</div>
                        <div className="text-sm font-bold text-stone-800">同級生が見つかりました</div>
                      </div>
                    </div>
                  </div>

                  {/* Overlay Badge 2: Club Found */}
                  <div className="absolute top-8 right-8 bg-white/95 backdrop-blur-sm px-5 py-3 rounded-2xl shadow-lg border border-stone-100 animate-fade-in-up delay-100">
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center text-xl">⚾</div>
                      <div>
                        <div className="text-xs font-bold text-stone-400">FOUND!</div>
                        <div className="text-sm font-bold text-stone-800">野球部OB (東京在住)</div>
                      </div>
                    </div>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </section>

        {/* Features Section */}
        <section className="py-20 bg-white border-t border-orange-50">
          <div className="container mx-auto px-6">
            <div className="text-center mb-16">
              <h2 className="text-3xl font-bold text-stone-800 mb-4">あの頃の仲間が、近くにいるかも。</h2>
              <p className="text-stone-500">Jimoto-Connectなら、ピンポイントでつながれます。</p>
            </div>

            <div className="grid md:grid-cols-2 gap-8 max-w-4xl mx-auto">
              {/* Feature 1: Search Focus */}
              <div className="bg-[#FDF8F5] p-10 rounded-3xl border border-orange-100 text-left hover:shadow-lg transition-shadow duration-300 group relative overflow-hidden">
                <div className="absolute top-0 right-0 p-8 opacity-10 group-hover:scale-110 transition-transform duration-500">
                  <Icons.Search />
                </div>
                <div className="w-16 h-16 bg-white rounded-2xl flex items-center justify-center mb-6 text-orange-500 shadow-sm">
                  <Icons.School />
                </div>
                <h3 className="text-2xl font-bold text-stone-800 mb-3">母校・部活で探せる</h3>
                <p className="text-stone-600 leading-relaxed">
                  「〇〇高校 2015年卒」「野球部」など、<br/>
                  ピンポイントな条件で検索。<br/>
                  同じバックグラウンドを持つ仲間がすぐに見つかります。
                </p>
              </div>

              {/* Feature 2: Connect Focus */}
              <div className="bg-[#FDF8F5] p-10 rounded-3xl border border-orange-100 text-left hover:shadow-lg transition-shadow duration-300 group relative overflow-hidden">
                <div className="absolute top-0 right-0 p-8 opacity-10 group-hover:scale-110 transition-transform duration-500">
                  <Icons.Users />
                </div>
                <div className="w-16 h-16 bg-white rounded-2xl flex items-center justify-center mb-6 text-blue-500 shadow-sm">
                  <Icons.Users />
                </div>
                <h3 className="text-2xl font-bold text-stone-800 mb-3">今いる場所でつながる</h3>
                <p className="text-stone-600 leading-relaxed">
                  「東京にいる同郷の人」だけで集まったり、<br/>
                  懐かしいローカルネタで盛り上がったり。<br/>
                  帰省しなくても、地元の空気感を楽しめます。
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* CTA Section */}
        <section className="py-20 bg-stone-900 text-white relative overflow-hidden">
          <div className="container mx-auto px-6 text-center relative z-10">
            <h2 className="text-3xl md:text-5xl font-black mb-6 tracking-tight">
              まずは、あなたの母校を<br/>検索してみませんか？
            </h2>
            <p className="text-stone-400 text-lg mb-10 max-w-xl mx-auto">
              登録して、プロフィールを入力するだけ。<br/>
              懐かしい再会があなたを待っています。
            </p>
            <Link href="/sign-up" className="inline-block h-16 px-12 bg-orange-600 text-white rounded-2xl text-xl font-bold shadow-2xl hover:bg-orange-700 transition-all hover:scale-105 active:scale-95">
              仲間を探しに行く
            </Link>
          </div>
        </section>

        {/* Footer */}
        <footer className="bg-white text-stone-400 py-12 border-t border-stone-100">
          <div className="container mx-auto px-6 flex flex-col md:flex-row justify-between items-center gap-6">
            <div className="font-bold text-xl text-stone-800">Jimoto-Connect</div>
            <div className="flex flex-wrap gap-4 md:gap-6 text-sm items-center">
              <a href="/" className="text-stone-500 hover:text-orange-600 transition">デザイン2（レトロ×モダン）を見る</a>
              <a href="#" className="hover:text-orange-600 transition">利用規約</a>
              <a href="#" className="hover:text-orange-600 transition">プライバシーポリシー</a>
              <a href="#" className="hover:text-orange-600 transition">お問い合わせ</a>
            </div>
            <div className="text-xs">
              © 2026 Jimoto Connect, Inc.
            </div>
          </div>
        </footer>
      </main>
    </div>
  );
}
