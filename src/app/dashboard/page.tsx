import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';

// --- Icons (SVG) ---
const Icons = {
  Home: ({ active }: { active?: boolean }) => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill={active ? "currentColor" : "none"} stroke="currentColor" strokeWidth={active ? "0" : "2"} strokeLinecap="round" strokeLinejoin="round" className="w-6 h-6">
      <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" />
      <polyline points="9 22 9 12 15 12 15 22" />
    </svg>
  ),
  Users: ({ active }: { active?: boolean }) => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill={active ? "currentColor" : "none"} stroke="currentColor" strokeWidth={active ? "0" : "2"} strokeLinecap="round" strokeLinejoin="round" className="w-6 h-6">
      <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
      <circle cx="9" cy="7" r="4" />
      <path d="M23 21v-2a4 4 0 0 0-3-3.87" />
      <path d="M16 3.13a4 4 0 0 1 0 7.75" />
    </svg>
  ),
  MapPin: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-4 h-4">
      <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z" />
      <circle cx="12" cy="10" r="3" />
    </svg>
  ),
  School: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-5 h-5">
      <path d="m4 6 8-4 8 4" />
      <path d="m18 10 4 2v8a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2v-8l4-2" />
      <path d="M14 22v-4a2 2 0 0 0-2-2v0a2 2 0 0 0-2 2v4" />
      <path d="M18 5v17" />
      <path d="M6 5v17" />
      <circle cx="12" cy="9" r="2" />
    </svg>
  ),
  Trophy: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-5 h-5">
      <path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6" />
      <path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18" />
      <path d="M4 22h16" />
      <path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22" />
      <path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22" />
      <path d="M18 2H6v7a6 6 0 0 0 12 0V2Z" />
    </svg>
  ),
  Calendar: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-5 h-5">
      <rect width="18" height="18" x="3" y="4" rx="2" ry="2" />
      <line x1="16" x2="16" y1="2" y2="6" />
      <line x1="8" x2="8" y1="2" y2="6" />
      <line x1="3" x2="21" y1="10" y2="10" />
    </svg>
  ),
  MessageCircle: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-5 h-5">
      <path d="M7.9 20A9 9 0 1 0 4 16.1L2 22Z" />
    </svg>
  ),
  Heart: () => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-5 h-5">
      <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z" />
    </svg>
  )
};

export default async function DashboardPage() {
  const { userId } = await auth();
  if (!userId) {
    redirect('/sign-in');
  }

  const supabase = await createClient();

  // ユーザー情報と学校情報を取得
  const { data: profile, error } = await supabase
    .from('profiles')
    .select(`
      *,
      profile_schools (
        graduation_year,
        club_activities,
        class_room,
        schools (
          id,
          name,
          prefecture,
          city
        )
      )
    `)
    .eq('clerk_user_id', userId)
    .single();

  if (error || !profile) {
    redirect('/onboarding');
  }

  if (!profile.profile_schools || profile.profile_schools.length === 0) {
    redirect('/onboarding');
  }

  const mainSchoolData = profile.profile_schools[0];
  const school = mainSchoolData.schools;
  const club = mainSchoolData.club_activities?.[0] || '帰宅部';
  const graduationYear = mainSchoolData.graduation_year;
  const classRoom = mainSchoolData.class_room || 'クラス不明';

  return (
    <div className="min-h-screen bg-[#F5F5F0] text-[#333] font-sans">
      
      {/* --- Header --- */}
      <header className="sticky top-0 z-50 bg-white border-b border-[#E0E0E0] shadow-sm h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <div className="bg-orange-600 text-white p-1.5 rounded-lg font-bold text-xl">JC</div>
          <span className="font-bold text-lg text-stone-700">Jimoto-Connect</span>
        </div>
        <div className="flex items-center gap-4">
           <div className="flex items-center gap-2 bg-[#F5F5F0] px-3 py-1.5 rounded-full">
             <div className="w-6 h-6 rounded-full bg-stone-300 overflow-hidden">
               <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${profile.display_name}`} alt="User" />
             </div>
             <span className="text-sm font-bold text-stone-600">{profile.display_name}</span>
           </div>
        </div>
      </header>

      <div className="max-w-6xl mx-auto p-6 grid grid-cols-1 lg:grid-cols-12 gap-8">
        
        {/* --- Left Sidebar (Profile Summary) --- */}
        <aside className="hidden lg:block lg:col-span-3 space-y-6">
          <div className="bg-white rounded-xl border border-[#E0E0E0] p-6 shadow-sm">
             <div className="text-center mb-4">
               <div className="w-20 h-20 mx-auto bg-stone-100 rounded-full mb-3 overflow-hidden border-2 border-white shadow-sm">
                 <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${profile.display_name}`} alt="User" />
               </div>
               <h2 className="font-bold text-lg">{profile.display_name}</h2>
               <p className="text-sm text-stone-500">@{profile.clerk_user_id.slice(0, 8)}</p>
             </div>
             <div className="space-y-3 text-sm">
               <div className="flex items-center gap-3 p-2 bg-orange-50 rounded-lg text-orange-800 font-bold">
                 <Icons.School />
                 <span>{school?.name} ({graduationYear}卒)</span>
               </div>
               <div className="flex items-center gap-3 p-2 bg-blue-50 rounded-lg text-blue-800 font-bold">
                 <Icons.Trophy />
                 <span>{club}</span>
               </div>
               <div className="flex items-center gap-3 p-2 bg-green-50 rounded-lg text-green-800 font-bold">
                 <Icons.Users />
                 <span>{classRoom}</span>
               </div>
               <div className="flex items-center gap-3 p-2 bg-stone-50 rounded-lg text-stone-600">
                 <Icons.MapPin />
                 <span>{profile.current_prefecture}在住</span>
               </div>
             </div>
          </div>

          <nav className="bg-white rounded-xl border border-[#E0E0E0] overflow-hidden shadow-sm">
            <div className="p-4 font-bold text-stone-400 text-xs border-b border-[#E0E0E0]">ショートカット</div>
            <a href="#" className="flex items-center gap-3 p-4 hover:bg-stone-50 transition border-b border-[#E0E0E0] last:border-0">
              <span className="w-8 h-8 rounded-full bg-green-100 text-green-600 flex items-center justify-center font-bold">同</span>
              <span className="font-bold text-stone-700">同窓会イベント</span>
            </a>
            <a href="#" className="flex items-center gap-3 p-4 hover:bg-stone-50 transition border-b border-[#E0E0E0] last:border-0">
              <span className="w-8 h-8 rounded-full bg-yellow-100 text-yellow-600 flex items-center justify-center font-bold">地</span>
              <span className="font-bold text-stone-700">地元ニュース</span>
            </a>
          </nav>
        </aside>


        {/* --- Center Column (Community Dashboard) --- */}
        <main className="lg:col-span-6 space-y-8">
          
          {/* 1. School Dashboard Card */}
          <section className="bg-white rounded-2xl border border-[#E0E0E0] overflow-hidden shadow-sm">
            <div className="h-32 bg-[#2E6B52] relative">
              <div className="absolute inset-0 bg-black/10"></div>
              <div className="absolute bottom-4 left-6 text-white">
                <div className="flex items-center gap-2 mb-1 opacity-90">
                  <Icons.School />
                  <span className="text-sm font-bold tracking-wider">MY SCHOOL</span>
                </div>
                <h1 className="text-3xl font-black tracking-tight">{school?.name}</h1>
              </div>
            </div>
            
            <div className="p-6">
              <div className="flex gap-4 mb-6 overflow-x-auto pb-2">
                <button className="flex-shrink-0 px-4 py-2 bg-[#2E6B52] text-white rounded-full font-bold text-sm shadow-md">
                  🏫 全体掲示板
                </button>
                <button className="flex-shrink-0 px-4 py-2 bg-white border border-[#E0E0E0] text-stone-600 rounded-full font-bold text-sm hover:bg-stone-50">
                  🎓 {graduationYear}年卒 (同級生)
                </button>
                <button className="flex-shrink-0 px-4 py-2 bg-white border border-[#E0E0E0] text-stone-600 rounded-full font-bold text-sm hover:bg-stone-50">
                  ⚾ {club}OB
                </button>
              </div>

              {/* Pinned / Important Info */}
              <div className="bg-amber-50 border border-amber-100 rounded-xl p-4 mb-6 flex gap-4 items-start">
                <div className="bg-amber-100 text-amber-600 p-2 rounded-lg">
                  <Icons.Calendar />
                </div>
                <div>
                  <h3 className="font-bold text-amber-900 mb-1">【重要】{school?.name} 同窓会のお知らせ</h3>
                  <p className="text-sm text-amber-800 leading-relaxed">
                    現在、{profile.current_prefecture}エリアでの同窓会を企画中です。参加希望者はアンケートにご回答ください。
                  </p>
                </div>
              </div>

              {/* Feed Items (Bulletin Board Style) */}
              <div className="space-y-4">
                <h3 className="font-bold text-stone-700 flex items-center gap-2">
                  <span className="w-1.5 h-6 bg-orange-500 rounded-full"></span>
                  新着の書き込み
                </h3>

                {/* Post Item 1 */}
                <div className="border-b border-[#E0E0E0] py-4 last:border-0">
                  <div className="flex items-center gap-2 mb-2">
                    <span className="bg-blue-100 text-blue-700 text-xs font-bold px-2 py-0.5 rounded">{club}</span>
                    <span className="text-stone-400 text-xs">2時間前</span>
                  </div>
                  <p className="font-bold text-stone-800 mb-2 cursor-pointer hover:text-orange-600 transition">
                    {school?.name}の近くにあったあの定食屋、まだあるのかな？
                  </p>
                  <div className="flex items-center gap-2">
                    <div className="w-6 h-6 rounded-full bg-stone-200 overflow-hidden">
                       <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Jack" alt="User" />
                    </div>
                    <span className="text-xs text-stone-500 font-bold">先輩ユーザー (2014卒)</span>
                    <div className="ml-auto flex gap-3 text-stone-400 text-xs font-bold">
                      <span className="flex items-center gap-1"><Icons.MessageCircle /> 5</span>
                      <span className="flex items-center gap-1"><Icons.Heart /> 12</span>
                    </div>
                  </div>
                </div>

              </div>
              
              <button className="w-full mt-4 py-3 text-center text-stone-500 font-bold text-sm hover:bg-stone-50 rounded-xl transition">
                もっと見る...
              </button>
            </div>
          </section>

          {/* 2. Club Room Card */}
          <section className="bg-white rounded-2xl border border-[#E0E0E0] p-6 shadow-sm">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-3">
                <div className="p-3 bg-blue-50 text-blue-600 rounded-xl">
                  <Icons.Trophy />
                </div>
                <div>
                  <h2 className="font-bold text-lg text-stone-800">{club} 部室</h2>
                  <p className="text-xs text-stone-500">メンバー募集中</p>
                </div>
              </div>
              <button className="text-blue-600 font-bold text-sm bg-blue-50 px-4 py-2 rounded-full hover:bg-blue-100 transition">
                書き込む
              </button>
            </div>
            
            <div className="bg-stone-50 rounded-xl p-4 text-center">
              <p className="text-stone-500 text-sm mb-3">最近の活動報告や、OB会の連絡はこちら</p>
              <div className="flex justify-center -space-x-2">
                {[1,2,3].map(i => (
                  <div key={i} className="w-8 h-8 rounded-full border-2 border-white bg-stone-200 overflow-hidden">
                    <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${i}`} alt="User" />
                  </div>
                ))}
                <div className="w-8 h-8 rounded-full border-2 border-white bg-stone-100 flex items-center justify-center text-xs font-bold text-stone-500">
                  +
                </div>
              </div>
            </div>
          </section>

        </main>


        {/* --- Right Sidebar (Local Info) --- */}
        <aside className="hidden lg:block lg:col-span-3 space-y-6">
          <div className="bg-white rounded-xl border border-[#E0E0E0] p-5 shadow-sm">
            <h3 className="font-bold text-stone-700 mb-4 flex items-center gap-2">
              <span className="text-orange-500">📍</span> {profile.home_prefecture}の話題
            </h3>
            <div className="space-y-4">
              <div className="flex gap-3 items-start">
                <div className="w-16 h-16 bg-stone-200 rounded-lg overflow-hidden flex-shrink-0">
                  <img src="https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=800&auto=format&fit=crop" className="w-full h-full object-cover" />
                </div>
                <div>
                  <div className="font-bold text-sm text-stone-800 hover:text-orange-600 cursor-pointer">地元のニュース</div>
                  <div className="text-xs text-stone-400 mt-1">{profile.home_prefecture} • ニュース</div>
                </div>
              </div>
            </div>
          </div>
        </aside>

      </div>
    </div>
  );
}
