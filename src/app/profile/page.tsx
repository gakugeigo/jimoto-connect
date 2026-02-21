import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';
import { ProfileEditForm } from './ProfileEditForm';
import { HometownVisitButton } from './HometownVisitButton';
import { ProfileAvatarEditor } from './ProfileAvatarEditor';
import { getAvatarUrl } from '@/lib/avatar';

export default async function ProfilePage() {
  const { userId } = await auth();
  if (!userId) {
    redirect('/sign-in');
  }

  const supabase = await createClient();

  const { data: profile, error } = await supabase
    .from('profiles')
    .select('*')
    .eq('clerk_user_id', userId)
    .single();

  if (error || !profile) {
    redirect('/onboarding');
  }

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800">
      <header className="sticky top-0 z-50 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-2 rounded-xl font-bold text-xl shadow-lg shadow-orange-200/40">JC</Link>
          <span className="font-bold text-lg text-stone-700">プロフィール</span>
        </div>
        <Link href="/dashboard" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors">
          ダッシュボードに戻る
        </Link>
      </header>

      <div className="max-w-2xl mx-auto p-6">
        {/* プロフィールヘッダーカード（表示のみ） */}
        <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 overflow-hidden mb-6">
          <div className="p-6 sm:p-8">
            <div className="flex flex-col sm:flex-row items-center sm:items-start gap-6">
              <div className="w-24 h-24 sm:w-28 sm:h-28 rounded-2xl overflow-hidden ring-2 ring-stone-200/60 shadow-lg flex-shrink-0">
                <img src={getAvatarUrl(profile)} alt="" className="w-full h-full object-cover" />
              </div>
              <div className="flex-1 text-center sm:text-left">
                <h1 className="text-2xl font-bold text-stone-800">{profile.display_name}</h1>
                {profile.maiden_name && (
                  <p className="text-sm text-stone-500 mt-0.5">(旧姓: {profile.maiden_name})</p>
                )}
                <p className="text-sm text-stone-400 mt-1">@{profile.clerk_user_id?.slice(0, 12)}...</p>
                {(profile.industry || profile.occupation) && (
                  <p className="text-sm text-stone-600 mt-2 font-medium">
                    💼 {[profile.industry, profile.occupation].filter(Boolean).join(' ・ ')}
                  </p>
                )}
                <p className="text-sm text-stone-500 mt-1">
                  📍 {profile.current_prefecture} {profile.current_city}
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* プロフィール画像の変更 */}
        <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 overflow-hidden mb-6">
          <div className="p-6">
            <ProfileAvatarEditor profile={profile} />
          </div>
        </div>

        {/* 今の状況・編集フォーム */}
        <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 overflow-hidden">
          <div className="p-6 border-b border-stone-100">
            <h2 className="font-bold text-stone-700 mb-3">今の状況</h2>
            <HometownVisitButton isHometownVisit={profile.is_hometown_visit ?? false} />
          </div>
          <div className="p-6">
            <h2 className="font-bold text-stone-700 mb-4">プロフィール編集</h2>
            <ProfileEditForm
              maidenName={profile.maiden_name ?? ''}
              industry={profile.industry ?? ''}
              occupation={profile.occupation ?? ''}
            />
          </div>
        </div>
      </div>
    </div>
  );
}
