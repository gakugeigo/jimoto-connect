'use client';

import Link from 'next/link';

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
};

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-[#FDF8F5] text-[#3d2c1a]">
      {/* Header */}
      <header className="sticky top-0 z-50 bg-[#FDF8F5]/95 backdrop-blur-sm border-b border-[#e8d5c4]">
        <div className="container mx-auto px-6 h-20 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="bg-[#8b6f47] text-[#FDF8F5] px-2.5 py-1.5 rounded-lg font-bold text-lg shadow-sm border border-[#6b5344]">
              JC
            </div>
            <span className="font-bold text-lg tracking-tight">Jimoto-Connect</span>
          </div>
          <div className="flex gap-3">
            <Link
              href="/sign-in?redirect_url=/v2/dashboard"
              className="px-5 py-2.5 text-sm font-bold text-[#5c4a3a] hover:text-[#8b6f47] transition"
            >
              ログイン
            </Link>
            <Link
              href="/sign-up?redirect_url=/v2/dashboard"
              className="px-5 py-2.5 bg-[#d4c4a8] text-[#3d2c1a] rounded-lg text-sm font-bold border border-[#b8a088] shadow-sm hover:bg-[#c4b498] transition"
            >
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
                <div className="inline-block px-4 py-1.5 bg-white/90 border border-[#e8d5c4] rounded-full text-sm font-bold text-[#8b6f47] shadow-sm mb-6">
                  ✨ 中学・高校の仲間が、近くにいる。
                </div>

                <h1 className="text-4xl md:text-6xl font-black tracking-tight leading-[1.1] mb-6 text-[#3d2c1a]">
                  懐かしいあの頃の、
                  <br />
                  <span className="text-[#8b6f47] relative inline-block">
                    同郷の仲間を見つける
                    <span className="absolute -bottom-1 left-0 w-full h-2 bg-[#d4c4a8]/50 -z-10 rounded" />
                  </span>
                </h1>

                <p className="text-lg text-[#5c4a3a] leading-relaxed mb-8 max-w-lg mx-auto lg:mx-0">
                  Jimoto-Connectは、<strong>中学校・高校</strong>の同級生や部活の仲間を、
                  今住んでいるエリアで見つけられるSNSです。
                  <br />
                  「近くにいる地元の友達や仲間」を今すぐ見つけよう。
                </p>

                {/* 検索バー */}
                <div className="bg-white/90 p-2 rounded-2xl shadow-xl border border-[#e8d5c4] max-w-md mx-auto lg:mx-0 mb-8 flex items-center gap-2">
                  <div className="pl-4 text-[#8b6f47]">
                    <Icons.Search />
                  </div>
                  <div className="flex-1 text-left">
                    <div className="text-xs font-bold text-[#5c4a3a]">出身校を検索</div>
                    <div className="text-[#3d2c1a] font-bold">例：那覇高校 2015年卒 野球部</div>
                  </div>
                  <Link
                    href="/sign-up?redirect_url=/v2/dashboard"
                    className="bg-[#8b6f47] text-[#FDF8F5] px-6 py-3 rounded-xl font-bold border border-[#6b5344] hover:bg-[#6b5344] transition"
                  >
                    探す
                  </Link>
                </div>

                <div className="flex flex-col sm:flex-row justify-center lg:justify-start gap-4 text-sm font-bold text-[#5c4a3a]">
                  <span>✅ 登録無料</span>
                  <span>✅ 実名制で安心</span>
                  <span>✅ 今のエリアで検索</span>
                </div>
              </div>

              {/* Right: Image */}
              <div className="relative">
                <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[120%] h-[120%] bg-[#e8d5c4]/40 rounded-full blur-3xl -z-10" />
                <div className="relative rounded-3xl overflow-hidden shadow-2xl border-4 border-white/90 rotate-1 hover:rotate-0 transition-transform duration-500 group">
                  <img
                    src="https://images.unsplash.com/photo-1517927033932-b3d18e61fb3a?q=80&w=1000&auto=format&fit=crop"
                    alt=""
                    className="w-full h-auto object-cover group-hover:scale-105 transition-transform duration-700"
                  />
                  <div className="absolute bottom-8 left-8 bg-white/95 backdrop-blur-sm px-5 py-3 rounded-2xl shadow-lg border border-[#e8d5c4]">
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 rounded-full bg-[#e8d5c4] flex items-center justify-center text-xl">🎓</div>
                      <div>
                        <div className="text-xs font-bold text-[#8b6f47]">見つかった！</div>
                        <div className="text-sm font-bold text-[#3d2c1a]">同級生が近くに</div>
                      </div>
                    </div>
                  </div>
                  <div className="absolute top-8 right-8 bg-white/95 backdrop-blur-sm px-5 py-3 rounded-2xl shadow-lg border border-[#e8d5c4]">
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 rounded-full bg-[#d4c4a8] flex items-center justify-center text-xl">⚾</div>
                      <div>
                        <div className="text-xs font-bold text-[#8b6f47]">見つかった！</div>
                        <div className="text-sm font-bold text-[#3d2c1a]">野球部OB (東京在住)</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* サービス説明 */}
        <section className="py-20 bg-white/60 border-t border-[#e8d5c4]">
          <div className="container mx-auto px-6">
            <div className="text-center mb-16">
              <h2 className="text-3xl font-bold text-[#3d2c1a] mb-4">あの頃の仲間が、近くにいるかも。</h2>
              <p className="text-[#5c4a3a]">中学・高校の同級生や部活の仲間を、今のエリアで探せます。</p>
            </div>

            <div className="grid md:grid-cols-2 gap-8 max-w-4xl mx-auto">
              <div className="bg-[#FDF8F5] p-10 rounded-3xl border border-[#e8d5c4] text-left hover:shadow-lg transition-shadow">
                <div className="w-16 h-16 bg-[#e8d5c4] rounded-2xl flex items-center justify-center mb-6 text-[#8b6f47]">
                  <Icons.School />
                </div>
                <h3 className="text-2xl font-bold text-[#3d2c1a] mb-3">母校・部活で探せる</h3>
                <p className="text-[#5c4a3a] leading-relaxed">
                  「〇〇中学校」「〇〇高校 2015年卒」「野球部」など、
                  ピンポイントな条件で検索。同じバックグラウンドを持つ仲間がすぐに見つかります。
                </p>
              </div>

              <div className="bg-[#FDF8F5] p-10 rounded-3xl border border-[#e8d5c4] text-left hover:shadow-lg transition-shadow">
                <div className="w-16 h-16 bg-[#e8d5c4] rounded-2xl flex items-center justify-center mb-6 text-[#8b6f47]">
                  <Icons.MapPin />
                </div>
                <h3 className="text-2xl font-bold text-[#3d2c1a] mb-3">今いる場所でつながる</h3>
                <p className="text-[#5c4a3a] leading-relaxed">
                  「東京にいる同郷の人」だけで集まったり、
                  懐かしいローカルネタで盛り上がったり。帰省しなくても、地元の空気感を楽しめます。
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* CTA */}
        <section className="py-20 bg-[#3d2c1a] text-[#FDF8F5]">
          <div className="container mx-auto px-6 text-center">
            <h2 className="text-3xl md:text-5xl font-bold mb-6">
              まずは、あなたの母校を検索してみませんか？
            </h2>
            <p className="text-[#d4c4a8] text-lg mb-10 max-w-xl mx-auto">
              登録して、プロフィールを入力するだけ。<br />
              懐かしい再会があなたを待っています。
            </p>
            <Link
              href="/sign-up?redirect_url=/v2/dashboard"
              className="inline-block px-12 py-4 bg-[#d4c4a8] text-[#3d2c1a] rounded-xl font-bold border-2 border-[#b8a088] shadow-lg hover:bg-[#c4b498] transition"
            >
              仲間を探しに行く
            </Link>
          </div>
        </section>

        {/* Footer */}
        <footer className="bg-white/80 text-[#5c4a3a] py-12 border-t border-[#e8d5c4]">
          <div className="container mx-auto px-6 flex flex-col md:flex-row justify-between items-center gap-6">
            <div className="font-bold text-lg text-[#3d2c1a]">Jimoto-Connect</div>
            <div className="flex flex-wrap gap-4 md:gap-6 text-sm items-center">
              <a href="/v1" className="hover:text-[#8b6f47] transition">デザイン1を見る</a>
              <a href="#" className="hover:text-[#8b6f47] transition">利用規約</a>
              <a href="#" className="hover:text-[#8b6f47] transition">プライバシーポリシー</a>
            </div>
            <div className="text-xs">© 2026 Jimoto Connect</div>
          </div>
        </footer>
      </main>
    </div>
  );
}
