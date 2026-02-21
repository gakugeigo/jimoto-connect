'use client';

import { useState, useEffect } from 'react';
import { getAvatarUrl } from '@/lib/avatar';
import { useRouter } from 'next/navigation';
import { UserButton } from '@clerk/nextjs';
import { CreatePostModal } from '@/components/create-post-modal';
import { toggleLike } from '@/app/actions/like';
import { createComment } from '@/app/actions/comment';
import { toggleHometownVisit } from '@/app/actions/profile';
import { ErrorMessage } from '@/components/ui/ErrorMessage';

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
  Heart: ({ filled }: { filled?: boolean }) => (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill={filled ? 'currentColor' : 'none'} stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-5 h-5">
      <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z" />
    </svg>
  )
};

function getSchoolId(s: any) {
  return s?.school_id ?? s?.schools?.id;
}

function formatRelativeTime(dateStr: string) {
  const d = new Date(dateStr);
  const now = new Date();
  const diffMs = now.getTime() - d.getTime();
  const diffM = Math.floor(diffMs / 60000);
  const diffH = Math.floor(diffMs / 3600000);
  const diffD = Math.floor(diffMs / 86400000);
  if (diffM < 1) return 'たった今';
  if (diffM < 60) return `${diffM}分前`;
  if (diffH < 24) return `${diffH}時間前`;
  if (diffD < 7) return `${diffD}日前`;
  return d.toLocaleDateString('ja-JP', { month: 'short', day: 'numeric' });
}

type Theme = 'default' | 'v2';

export function DashboardClient({
  profile,
  schools,
  posts = [],
  likesMap = {},
  commentsMap = {},
  theme = 'default',
  basePath = '',
}: {
  profile: any;
  schools: any[];
  posts?: any[];
  likesMap?: Record<string, { count: number; isLiked: boolean }>;
  commentsMap?: Record<string, any[]>;
  theme?: Theme;
  basePath?: string;
}) {
  const isV2 = theme === 'v2';
  const dashPath = basePath ? `${basePath}/dashboard` : '/dashboard';
  // v2 の profile/search 等は未実装のため、メインのパスへリンク
  const profilePath = '/profile';
  const searchPath = '/search';
  const messagesPath = '/messages';
  const groupsPath = '/groups';
  const eventsPath = '/events';
  const mapPath = '/map';
  const residentsPath = '/residents';
  const router = useRouter();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [activeSchoolId, setActiveSchoolId] = useState(getSchoolId(schools[0]));
  const [activeTab, setActiveTab] = useState<'all' | 'classmates' | 'club'>('all');
  const [expandedPostId, setExpandedPostId] = useState<string | null>(null);
  const [commentInputs, setCommentInputs] = useState<Record<string, string>>({});
  const [isLiking, setIsLiking] = useState<string | null>(null);
  const [isCommenting, setIsCommenting] = useState<string | null>(null);
  const [isTogglingVisit, setIsTogglingVisit] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const currentSchoolData = schools.find((s: any) => getSchoolId(s) === activeSchoolId) || schools[0];
  const school = currentSchoolData.schools;
  const club = currentSchoolData.club_activities?.[0] || '帰宅部';
  const graduationYear = currentSchoolData.graduation_year;
  const classRoom = currentSchoolData.class_room || 'クラス不明';

  // 学校切り替え時にタブを全体にリセット
  useEffect(() => {
    setActiveTab('all');
  }, [activeSchoolId]);

  // タブに応じて投稿をフィルタ（board_type で絞り込み）
  const schoolFiltered = posts.filter((p: any) => p.school_id === activeSchoolId);
  const filteredPosts = schoolFiltered.filter((p: any) => {
    const bt = p.board_type ?? 'all';
    // board_type 未設定の投稿は全体タブにのみ表示（後方互換）
    return bt === activeTab;
  });

  const handleLike = async (postId: string) => {
    if (isLiking) return;
    setIsLiking(postId);
    try {
      await toggleLike(postId);
      router.refresh();
    } finally {
      setIsLiking(null);
    }
  };

  const handleComment = async (postId: string) => {
    const content = commentInputs[postId]?.trim();
    if (!content || isCommenting) return;
    setError(null);
    setIsCommenting(postId);
    try {
      await createComment(postId, content);
      setCommentInputs((prev) => ({ ...prev, [postId]: '' }));
      router.refresh();
    } catch (e) {
      setError(e instanceof Error ? e.message : 'コメントに失敗しました');
    } finally {
      setIsCommenting(null);
    }
  };

  const handleVisitToggle = async () => {
    if (isTogglingVisit) return;
    setError(null);
    setIsTogglingVisit(true);
    try {
      await toggleHometownVisit();
      router.refresh();
    } catch (e) {
      setError(e instanceof Error ? e.message : '更新に失敗しました');
    } finally {
      setIsTogglingVisit(false);
    }
  };

  const homeLabel = profile.home_prefecture || profile.current_prefecture || '地元';

  return (
    <div className={`min-h-screen bg-[#FDF8F5] ${isV2 ? 'text-[#3d2c1a]' : 'text-stone-800'}`}>
      
      {/* --- Header --- */}
      <header className={`sticky top-0 z-50 backdrop-blur-md shadow-sm h-16 flex items-center justify-between px-6 ${
        isV2 ? 'bg-[#FDF8F5]/95 border-b border-[#e8d5c4]' : 'bg-white/95 border-b border-stone-200/80'
      }`}>
        <div className="flex items-center gap-3">
          <a href={dashPath} className="flex items-center gap-2.5 group">
            <div className={`px-2.5 py-1.5 rounded-xl font-bold text-lg transition-shadow ${
              isV2 ? 'bg-[#8b6f47] text-[#FDF8F5] border border-[#6b5344] shadow-sm' : 'bg-gradient-to-br from-orange-500 to-orange-600 text-white shadow-md shadow-orange-200/50 group-hover:shadow-orange-300/60'
            }`}>JC</div>
            <span className={`font-bold text-lg tracking-tight hidden sm:inline ${isV2 ? 'text-[#3d2c1a]' : 'text-stone-800'}`}>Jimoto-Connect</span>
          </a>
        </div>
        <div className="flex items-center gap-4">
           <a href={profilePath} className={`flex items-center gap-2 text-sm font-semibold transition-colors ${isV2 ? 'text-[#5c4a3a] hover:text-[#8b6f47]' : 'text-stone-600 hover:text-orange-600'}`}>
             <span className="hidden sm:inline max-w-[120px] truncate">{profile.display_name}</span>
             <span className="w-9 h-9 rounded-full bg-stone-100 flex items-center justify-center sm:hidden ring-2 ring-stone-200/50" title="プロフィール">
               <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="w-4 h-4"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
             </span>
           </a>
           <UserButton
             afterSignOutUrl={basePath ? `/v2` : '/'}
             appearance={{
               elements: { avatarBox: 'w-9 h-9 ring-2 ring-stone-200/50' }
             }}
           />
        </div>
      </header>

      <div className="max-w-6xl mx-auto p-6 grid grid-cols-1 lg:grid-cols-12 gap-8">
        
        {/* --- Left Sidebar (Profile Summary & School Switcher) --- */}
        <aside className="hidden lg:block lg:col-span-3 space-y-6">
          <div className="bg-white/80 backdrop-blur rounded-2xl border border-stone-200/60 p-6 shadow-lg shadow-stone-200/30">
             <div className="text-center mb-4">
               <a href={profilePath} className="block w-20 h-20 mx-auto rounded-2xl mb-3 overflow-hidden ring-2 ring-stone-200/60 shadow-md hover:ring-orange-300 transition-all">
                 <img src={getAvatarUrl(profile)} alt="User" className="w-full h-full object-cover" />
               </a>
               <a href={profilePath} className={`text-xs font-bold ${isV2 ? 'text-[#8b6f47] hover:text-[#6b5344]' : 'text-orange-600 hover:text-orange-700'}`}>プロフィールを編集</a>
               <h2 className="font-bold text-lg text-stone-800">{profile.display_name}</h2>
               {profile.maiden_name && <p className="text-xs text-stone-500">(旧姓: {profile.maiden_name})</p>}
               <p className="text-sm text-stone-500 mt-1">@{profile.clerk_user_id.slice(0, 8)}</p>
             </div>
             
             <div className="space-y-3 text-sm">
               <div className="flex items-center gap-3 p-2 bg-stone-50 rounded-lg text-stone-600">
                 <Icons.MapPin />
                 <span>{profile.current_prefecture} {profile.current_city}在住</span>
               </div>
               {(profile.industry || profile.occupation) && (
                 <div className="flex items-center gap-3 p-2 bg-stone-50 rounded-lg text-stone-600">
                   <span className="text-base">💼</span>
                   <span>{[profile.industry, profile.occupation].filter(Boolean).join(' ・ ')}</span>
                 </div>
               )}
               <div className={`rounded-lg overflow-hidden ${profile.is_hometown_visit ? 'bg-green-50 ring-1 ring-green-200' : 'bg-stone-50'}`}>
                 {profile.is_hometown_visit ? (
                   <>
                     <div className="px-3 py-2 text-center text-sm font-bold text-green-700 bg-green-100">
                       🏠 帰省中！
                     </div>
                     <button
                       onClick={handleVisitToggle}
                       disabled={isTogglingVisit}
                       className="w-full px-3 py-2 text-sm font-bold text-stone-600 hover:bg-stone-100 transition border-t border-green-200"
                     >
                       帰省が終わりました → クリックして解除
                     </button>
                   </>
                 ) : (
                   <button
                     onClick={handleVisitToggle}
                     disabled={isTogglingVisit}
                     className="w-full flex flex-col items-center gap-0.5 py-3 px-3 text-sm font-bold text-stone-700 hover:bg-stone-100 transition"
                   >
                     <span className="text-xs font-normal text-stone-500">帰省中の人はこちらをクリック</span>
                     <span>🏠 今地元に帰省中</span>
                   </button>
                 )}
               </div>
             </div>

             {/* School Switcher */}
             <div className="mt-6 pt-4 border-t border-stone-100">
               <p className="text-xs font-bold text-stone-400 mb-2">所属コミュニティ</p>
               <div className="space-y-2">
                 {schools.map((s: any) => {
                   const sid = getSchoolId(s);
                   return (
                     <button
                       key={sid}
                       onClick={() => setActiveSchoolId(sid)}
                       className={`w-full text-left p-2 rounded-lg text-sm font-bold flex items-center gap-2 transition ${
                         activeSchoolId === sid 
                           ? 'bg-orange-50 text-orange-800 ring-1 ring-orange-200' 
                           : 'hover:bg-stone-50 text-stone-600'
                       }`}
                     >
                       <span className={`w-2 h-2 rounded-full ${s.schools?.type === 'high' ? 'bg-orange-400' : 'bg-blue-400'}`} />
                       <span className="truncate">{s.schools?.name}</span>
                     </button>
                   );
                 })}
               </div>
             </div>
          </div>

          <nav className="bg-white/80 backdrop-blur rounded-2xl border border-stone-200/60 overflow-hidden shadow-lg shadow-stone-200/30">
            <div className="p-4 font-bold text-stone-500 text-xs uppercase tracking-wider">ショートカット</div>
            <a href={searchPath} className={`flex items-center gap-3 p-4 transition border-b border-stone-100 ${isV2 ? 'hover:bg-[#e8d5c4]/50' : 'hover:bg-orange-50/50'}`}>
              <span className="w-9 h-9 rounded-xl bg-orange-100 text-orange-600 flex items-center justify-center font-bold text-sm">検</span>
              <span className="font-semibold text-stone-700">同窓生検索</span>
            </a>
            <a href={messagesPath} className={`flex items-center gap-3 p-4 transition border-b border-stone-100 ${isV2 ? 'hover:bg-[#e8d5c4]/50' : 'hover:bg-orange-50/50'}`}>
              <span className="w-9 h-9 rounded-xl bg-teal-100 text-teal-600 flex items-center justify-center">
                <Icons.MessageCircle />
              </span>
              <span className="font-semibold text-stone-700">メッセージ</span>
            </a>
            <a href={mapPath} className={`flex items-center gap-3 p-4 transition border-b border-stone-100 ${isV2 ? 'hover:bg-[#e8d5c4]/50' : 'hover:bg-orange-50/50'}`}>
              <span className="w-9 h-9 rounded-xl bg-sky-100 text-sky-600 flex items-center justify-center font-bold text-sm">地</span>
              <span className="font-semibold text-stone-700">居住地マップ</span>
            </a>
            <a href={residentsPath} className={`flex items-center gap-3 p-4 transition border-b border-stone-100 ${isV2 ? 'hover:bg-[#e8d5c4]/50' : 'hover:bg-orange-50/50'}`}>
              <span className="w-9 h-9 rounded-xl bg-cyan-100 text-cyan-600 flex items-center justify-center font-bold text-sm">住</span>
              <span className="font-semibold text-stone-700">居住地一覧</span>
            </a>
            <a href={groupsPath} className={`flex items-center gap-3 p-4 transition border-b border-stone-100 ${isV2 ? 'hover:bg-[#e8d5c4]/50' : 'hover:bg-orange-50/50'}`}>
              <span className="w-9 h-9 rounded-xl bg-violet-100 text-violet-600 flex items-center justify-center font-bold text-sm">G</span>
              <span className="font-semibold text-stone-700">マイグループ</span>
            </a>
            <a href={eventsPath} className={`flex items-center gap-3 p-4 transition border-b border-stone-100 ${isV2 ? 'hover:bg-[#e8d5c4]/50' : 'hover:bg-orange-50/50'}`}>
              <span className="w-9 h-9 rounded-xl bg-emerald-100 text-emerald-600 flex items-center justify-center font-bold text-sm">同</span>
              <span className="font-semibold text-stone-700">同窓会イベント</span>
            </a>
            <a href={profilePath} className={`flex items-center gap-3 p-4 transition border-b border-stone-100 ${isV2 ? 'hover:bg-[#e8d5c4]/50' : 'hover:bg-orange-50/50'}`}>
              <span className="w-9 h-9 rounded-xl bg-sky-100 text-sky-600 flex items-center justify-center font-bold text-sm">P</span>
              <span className="font-semibold text-stone-700">プロフィール</span>
            </a>
            <a href="#" className="flex items-center gap-3 p-4 hover:bg-orange-50/50 transition last:border-0">
              <span className="w-9 h-9 rounded-xl bg-amber-100 text-amber-600 flex items-center justify-center font-bold text-sm">新</span>
              <span className="font-semibold text-stone-700">地元ニュース</span>
            </a>
          </nav>
        </aside>


        {/* --- Center Column (Community Dashboard) --- */}
        <main className="lg:col-span-6 space-y-8">
          {error && (
            <ErrorMessage message={error} onDismiss={() => setError(null)} />
          )}
          
          {/* Mobile: プロフィール概要・学校切り替え・帰省中 (サイドバー非表示時) */}
          <div className="lg:hidden space-y-3">
            {(profile.industry || profile.occupation) && (
              <div className="bg-white/80 backdrop-blur rounded-2xl border border-stone-200/60 p-4 shadow-lg shadow-stone-200/30">
                <p className="text-xs font-bold text-stone-400 mb-1">自分のプロフィール</p>
                <p className="text-sm font-bold text-stone-700">💼 {[profile.industry, profile.occupation].filter(Boolean).join(' ・ ')}</p>
              </div>
            )}
            <div className="bg-white/80 backdrop-blur rounded-2xl border border-stone-200/60 p-4 shadow-lg shadow-stone-200/30">
              <p className="text-xs font-bold text-stone-500 mb-2 uppercase tracking-wider">所属コミュニティ</p>
              <select
                value={activeSchoolId ?? ''}
                onChange={(e) => setActiveSchoolId(e.target.value)}
                className="w-full p-3 rounded-xl border border-stone-200/80 bg-white font-semibold text-stone-700 focus:ring-2 focus:ring-orange-200 focus:border-orange-400 outline-none transition"
              >
                {schools.map((s: any) => {
                  const sid = getSchoolId(s);
                  return (
                    <option key={sid} value={sid}>
                      {s.schools?.type === 'high' ? '🏫' : '📚'} {s.schools?.name}
                    </option>
                  );
                })}
              </select>
            </div>
            <div className={`rounded-2xl overflow-hidden shadow-lg ${profile.is_hometown_visit ? 'bg-emerald-50/80 ring-2 ring-emerald-200/60' : 'bg-white/80 backdrop-blur border border-stone-200/60'}`}>
              {profile.is_hometown_visit ? (
                <>
                  <div className="px-3 py-2 text-center text-sm font-bold text-green-700 bg-green-100">
                    🏠 帰省中！
                  </div>
                  <button
                    onClick={handleVisitToggle}
                    disabled={isTogglingVisit}
                    className="w-full px-3 py-2 text-sm font-bold text-stone-600 hover:bg-stone-100 transition border-t border-green-200"
                  >
                    帰省が終わりました → クリックして解除
                  </button>
                </>
              ) : (
                <button
                  onClick={handleVisitToggle}
                  disabled={isTogglingVisit}
                  className="w-full flex flex-col items-center gap-0.5 py-3 px-3 text-sm font-bold text-stone-700 hover:bg-stone-100 transition"
                >
                  <span className="text-xs font-normal text-stone-500">帰省中の人はこちらをクリック</span>
                  <span>🏠 今地元に帰省中</span>
                </button>
              )}
            </div>
            <div className="space-y-2">
              <p className="text-xs font-bold text-stone-500 uppercase tracking-wider">ショートカット</p>
              <div className="grid grid-cols-2 gap-2">
                <a href="/search" className={`flex flex-col items-start justify-center min-h-[52px] p-3 rounded-xl border border-stone-200/60 bg-white/80 backdrop-blur transition shadow-md ${isV2 ? 'hover:bg-[#e8d5c4]/30' : 'hover:bg-orange-50/50'}`}>
                  <span className="text-sky-600 font-bold text-sm">🔍 同窓生検索</span>
                </a>
                <a href="/messages" className={`flex flex-col items-start justify-center min-h-[52px] p-3 rounded-xl border border-stone-200/60 bg-white/80 backdrop-blur transition shadow-md ${isV2 ? 'hover:bg-[#e8d5c4]/30' : 'hover:bg-orange-50/50'}`}>
                  <span className="text-sky-600 font-bold text-sm">💬 メッセージ</span>
                </a>
                <a href={mapPath} className={`flex flex-col items-start justify-center min-h-[52px] p-3 rounded-xl border border-stone-200/60 bg-white/80 backdrop-blur transition shadow-md ${isV2 ? 'hover:bg-[#e8d5c4]/30' : 'hover:bg-orange-50/50'}`}>
                  <span className="text-sky-600 font-bold text-sm">📍 居住地マップ</span>
                </a>
                <a href="/residents" className={`flex flex-col items-start justify-center min-h-[52px] p-3 rounded-xl border border-stone-200/60 bg-white/80 backdrop-blur transition shadow-md ${isV2 ? 'hover:bg-[#e8d5c4]/30' : 'hover:bg-orange-50/50'}`}>
                  <span className="text-sky-600 font-bold text-sm">📋 居住地一覧</span>
                </a>
                <a href="/groups" className={`flex flex-col items-start justify-center min-h-[52px] p-3 rounded-xl border border-stone-200/60 bg-white/80 backdrop-blur transition shadow-md ${isV2 ? 'hover:bg-[#e8d5c4]/30' : 'hover:bg-orange-50/50'}`}>
                  <span className="text-sky-600 font-bold text-sm">👥 マイグループ</span>
                </a>
                <a href="/events" className={`flex flex-col items-start justify-center min-h-[52px] p-3 rounded-xl border border-stone-200/60 bg-white/80 backdrop-blur transition shadow-md ${isV2 ? 'hover:bg-[#e8d5c4]/30' : 'hover:bg-orange-50/50'}`}>
                  <span className="text-sky-600 font-bold text-sm">📅 同窓会イベント</span>
                </a>
                <a href="/profile" className={`flex flex-col items-start justify-center min-h-[52px] p-3 rounded-xl border border-stone-200/60 bg-white/80 backdrop-blur transition shadow-md col-span-2 ${isV2 ? 'hover:bg-[#e8d5c4]/30' : 'hover:bg-orange-50/50'}`}>
                  <span className="text-sky-600 font-bold text-sm">👤 プロフィール</span>
                </a>
              </div>
            </div>
          </div>

          {/* 1. School Dashboard Card */}
          <section className={`bg-white/90 backdrop-blur rounded-2xl overflow-hidden shadow-xl animate-fade-in ${isV2 ? 'border border-[#e8d5c4] shadow-[#e8d5c4]/20' : 'border border-stone-200/60 shadow-stone-200/40'}`}>
            <div className={`h-36 relative overflow-hidden ${
              isV2 ? 'bg-gradient-to-br from-[#8b6f47] to-[#6b5344]' : school?.type === 'high' ? 'bg-gradient-to-br from-orange-500 to-orange-600' : 'bg-gradient-to-br from-emerald-600 to-teal-700'
            }`}>
              <div className="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent"></div>
              <div className="absolute bottom-4 left-6 text-white">
                <div className="flex items-center gap-2 mb-1 opacity-90">
                  <Icons.School />
                  <span className="text-sm font-bold tracking-wider">MY SCHOOL</span>
                </div>
                <h1 className="text-3xl font-black tracking-tight">{school?.name}</h1>
              </div>
            </div>
            
            <div className="p-6">
              <div className="flex gap-3 mb-6 overflow-x-auto pb-2">
                <button
                  onClick={() => setActiveTab('all')}
                  className={`flex-shrink-0 px-5 py-2.5 rounded-xl font-bold text-sm shadow-sm transition ${
                    activeTab === 'all'
                      ? isV2 ? 'bg-[#8b6f47] text-[#FDF8F5] border border-[#6b5344]' : school?.type === 'high' ? 'bg-orange-500 text-white shadow-orange-200/50' : 'bg-emerald-600 text-white shadow-emerald-200/50'
                      : 'bg-white/90 border border-stone-200 text-stone-600 hover:bg-stone-50'
                  }`}
                >
                  🏫 全体掲示板
                </button>
                <button
                  onClick={() => setActiveTab('classmates')}
                  className={`flex-shrink-0 px-5 py-2.5 rounded-xl font-bold text-sm shadow-sm transition ${
                    activeTab === 'classmates'
                      ? isV2 ? 'bg-[#8b6f47] text-[#FDF8F5] border border-[#6b5344]' : school?.type === 'high' ? 'bg-orange-500 text-white shadow-orange-200/50' : 'bg-emerald-600 text-white shadow-emerald-200/50'
                      : 'bg-white/90 border border-stone-200 text-stone-600 hover:bg-stone-50'
                  }`}
                >
                  🎓 {graduationYear}年卒 (同級生)
                </button>
                <button
                  onClick={() => setActiveTab('club')}
                  className={`flex-shrink-0 px-5 py-2.5 rounded-xl font-bold text-sm shadow-sm transition ${
                    activeTab === 'club'
                      ? isV2 ? 'bg-[#8b6f47] text-[#FDF8F5] border border-[#6b5344]' : school?.type === 'high' ? 'bg-orange-500 text-white shadow-orange-200/50' : 'bg-emerald-600 text-white shadow-emerald-200/50'
                      : 'bg-white/90 border border-stone-200 text-stone-600 hover:bg-stone-50'
                  }`}
                >
                  ⚾ {club}OB
                </button>
              </div>

              {/* 重要なお知らせ（全体タブのみ） */}
              {activeTab === 'all' && (
                <div className="bg-amber-50/80 border border-amber-200/60 rounded-2xl p-5 mb-6 flex gap-4 items-start shadow-sm">
                  <div className="bg-amber-100/80 text-amber-700 p-2.5 rounded-xl shrink-0">
                    <Icons.Calendar />
                  </div>
                  <div>
                    <h3 className="font-bold text-amber-900 mb-1">【重要】{school?.name} 同窓会のお知らせ</h3>
                    <p className="text-sm text-amber-800/90 leading-relaxed">
                      現在、{profile.current_prefecture}エリアでの同窓会を企画中です。参加希望者はアンケートにご回答ください。
                    </p>
                  </div>
                </div>
              )}

              {/* Feed Items (Bulletin Board Style) */}
              <div className="space-y-4">
                <div className="flex items-center justify-between gap-4">
                  <h3 className="font-bold text-stone-700 flex items-center gap-2">
                    <span className={`w-1.5 h-6 rounded-full ${school?.type === 'high' ? 'bg-orange-500' : 'bg-emerald-500'}`}></span>
                    {activeTab === 'all' ? '新着の書き込み' : activeTab === 'classmates' ? `${graduationYear}年卒 同級生の書き込み` : `${club}OBの書き込み`}
                  </h3>
                  <button
                    onClick={() => setIsModalOpen(true)}
                    className={`flex-shrink-0 px-4 py-2 rounded-xl font-bold text-sm shadow-sm transition ${
                      isV2 ? 'bg-[#d4c4a8] hover:bg-[#c4b498] text-[#3d2c1a] border border-[#b8a088]' : school?.type === 'high' ? 'bg-orange-500 hover:bg-orange-600 text-white shadow-orange-200/50' : 'bg-emerald-600 hover:bg-emerald-700 text-white shadow-emerald-200/50'
                    }`}
                  >
                    書き込む
                  </button>
                </div>

                {filteredPosts.length === 0 ? (
                  <div className="py-12 text-center text-stone-500">
                    {activeTab === 'all' ? (
                      <>
                        <p className="font-bold mb-2">まだ書き込みがありません</p>
                        <p className="text-sm">「書き込む」ボタンから最初の投稿をしてみましょう！</p>
                      </>
                    ) : activeTab === 'classmates' ? (
                      <>
                        <p className="font-bold mb-2">{graduationYear}年卒の同級生の書き込みはまだありません</p>
                        <p className="text-sm">全体掲示板には投稿があるかもしれません</p>
                      </>
                    ) : (
                      <>
                        <p className="font-bold mb-2">{club}OBの書き込みはまだありません</p>
                        <p className="text-sm">全体掲示板には投稿があるかもしれません</p>
                      </>
                    )}
                  </div>
                ) : (
                  filteredPosts.map((post: any) => {
                    const author = post.profiles ?? post.author;
                    const authorName = author?.display_name ?? '匿名';
                    const authorSeed = author?.clerk_user_id ?? author?.id ?? post.id;
                    const likeInfo = likesMap[post.id] ?? { count: 0, isLiked: false };
                    const comments = commentsMap[post.id] ?? [];
                    const isExpanded = expandedPostId === post.id;
                    return (
                      <div key={post.id} className="border-b border-stone-100 py-5 last:border-0">
                        <div className="flex items-center gap-2 mb-2">
                          <span className={`text-xs font-bold px-2.5 py-1 rounded-lg ${school?.type === 'high' ? 'bg-orange-100 text-orange-700' : 'bg-emerald-100 text-emerald-700'}`}>{club}</span>
                          <span className="text-stone-400 text-xs">{formatRelativeTime(post.created_at)}</span>
                        </div>
                        <p className="font-bold text-stone-800 mb-2 whitespace-pre-wrap">{post.content}</p>
                        {post.image_url && (
                          <img src={post.image_url} alt="" className="rounded-lg max-h-64 object-cover mb-2" />
                        )}
                        <div className="flex items-center gap-2">
                          <div className="w-6 h-6 rounded-full bg-stone-200 overflow-hidden">
                            <img src={getAvatarUrl(author ?? {})} alt="" />
                          </div>
                          <span className="text-xs text-stone-500 font-bold">{authorName}</span>
                          <div className="ml-auto flex gap-4 text-stone-500 text-xs font-bold">
                            <button
                              onClick={() => setExpandedPostId(isExpanded ? null : post.id)}
                              className="flex items-center gap-1 hover:text-orange-600 transition"
                            >
                              <Icons.MessageCircle /> {comments.length}
                            </button>
                            <button
                              onClick={() => handleLike(post.id)}
                              disabled={!!isLiking}
                              className={`flex items-center gap-1 transition ${likeInfo.isLiked ? 'text-red-500' : 'hover:text-red-500'}`}
                            >
                              <Icons.Heart filled={likeInfo.isLiked} />
                              {likeInfo.count}
                            </button>
                          </div>
                        </div>

                        {/* コメントエリア（展開時） */}
                        {isExpanded && (
                          <div className="mt-4 pt-4 border-t border-stone-100 space-y-3">
                            {comments.map((c: any) => {
                              const commentAuthor = c.profiles ?? {};
                              return (
                                <div key={c.id} className="flex gap-2 text-sm">
                                  <div className="w-6 h-6 rounded-full bg-stone-200 overflow-hidden flex-shrink-0">
                                    <img src={getAvatarUrl(commentAuthor ?? { clerk_user_id: String(c.id) })} alt="" />
                                  </div>
                                  <div>
                                    <span className="font-bold text-stone-700">{commentAuthor.display_name ?? '匿名'}</span>
                                    <span className="text-stone-400 text-xs ml-2">{formatRelativeTime(c.created_at)}</span>
                                    <p className="text-stone-600 mt-0.5">{c.content}</p>
                                  </div>
                                </div>
                              );
                            })}
                            <div className="flex gap-2 mt-2">
                              <input
                                type="text"
                                value={commentInputs[post.id] ?? ''}
                                onChange={(e) => setCommentInputs((prev) => ({ ...prev, [post.id]: e.target.value }))}
                                placeholder="コメントを入力..."
                                className={`flex-1 px-3 py-2 rounded-xl border border-stone-200 text-sm outline-none focus:ring-2 ${school?.type === 'high' ? 'focus:ring-orange-200 focus:border-orange-300' : 'focus:ring-emerald-200 focus:border-emerald-300'}`}
                                onKeyDown={(e) => e.key === 'Enter' && handleComment(post.id)}
                              />
                              <button
                                onClick={() => handleComment(post.id)}
                                disabled={!commentInputs[post.id]?.trim() || !!isCommenting}
                                className={`px-4 py-2 text-white text-sm font-bold rounded-xl disabled:opacity-50 ${school?.type === 'high' ? 'bg-orange-500 hover:bg-orange-600' : 'bg-emerald-600 hover:bg-emerald-700'}`}
                              >
                                {isCommenting === post.id ? '送信中...' : '送信'}
                              </button>
                            </div>
                          </div>
                        )}
                      </div>
                    );
                  })
                )}
              </div>
            </div>
          </section>

          {/* 2. Club Room Card */}
          <section className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 p-6 shadow-xl shadow-stone-200/40">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-3 bg-sky-50 text-sky-600 rounded-xl">
                <Icons.Trophy />
              </div>
              <div>
                <h2 className="font-bold text-lg text-stone-800">{club} 部室</h2>
                <p className="text-xs text-stone-500">メンバー募集中</p>
              </div>
            </div>
            
            <div className="bg-stone-50 rounded-xl p-4 text-center">
              <p className="text-stone-500 text-sm mb-3">部活OBタブで活動報告やOB会の連絡を共有できます</p>
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
          <div className="bg-white/80 backdrop-blur rounded-2xl border border-stone-200/60 p-5 shadow-lg shadow-stone-200/30">
            <h3 className="font-bold text-stone-700 mb-4 flex items-center gap-2">
              <span className="text-orange-500">📍</span> {homeLabel}の話題
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

      {/* --- Modals --- */}
      <CreatePostModal 
        isOpen={isModalOpen} 
        onClose={() => setIsModalOpen(false)} 
        schoolId={school?.id ?? ''}
        schoolName={school?.name ?? ''}
        schoolType={school?.type}
        boardType={activeTab}
      />

    </div>
  );
}
