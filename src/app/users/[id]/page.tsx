import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect, notFound } from 'next/navigation';
import Link from 'next/link';
import { getAvatarUrl } from '@/lib/avatar';

export default async function UserProfilePage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const { userId } = await auth();
  if (!userId) redirect('/sign-in');

  const supabase = await createClient();

  const { data: profile, error } = await supabase
    .from('profiles')
    .select(`
      id,
      display_name,
      avatar_url,
      maiden_name,
      current_prefecture,
      current_city,
      is_hometown_visit,
      industry,
      occupation,
      profile_schools (
        graduation_year,
        club_activities,
        class_room,
        schools (id, name, type, prefecture, city)
      )
    `)
    .eq('id', id)
    .single();

  if (error || !profile) notFound();

  const { data: me } = await supabase
    .from('profiles')
    .select('id')
    .eq('clerk_user_id', userId)
    .single();

  const isOwnProfile = me?.id === profile.id;

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800">
      <header className="sticky top-0 z-50 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-2 rounded-xl font-bold text-xl shadow-lg shadow-orange-200/40">JC</Link>
          <span className="font-bold text-lg text-stone-700">Jimoto-Connect</span>
        </div>
        <div className="flex items-center gap-4">
          <Link href="/messages" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors">
            メッセージ
          </Link>
          {!isOwnProfile && (
            <Link href={`/messages/${profile.id}`} className="px-4 py-2 bg-orange-500 text-white font-bold rounded-xl hover:bg-orange-600 transition shadow-lg shadow-orange-200/40">
              メッセージを送る
            </Link>
          )}
          <Link href="/search" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors">
            ← 検索に戻る
          </Link>
        </div>
      </header>

      <div className="max-w-2xl mx-auto p-6">
        <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 overflow-hidden">
          <div className="p-6 sm:p-8 border-b border-stone-100">
            <div className="flex flex-col sm:flex-row items-center sm:items-start gap-6">
              <div className="w-24 h-24 sm:w-28 sm:h-28 rounded-2xl overflow-hidden ring-2 ring-stone-200/60 shadow-xl shadow-stone-200/40 flex-shrink-0">
                <img src={getAvatarUrl(profile)} alt="" className="w-full h-full object-cover" />
              </div>
              <div className="flex-1 text-center sm:text-left">
                <div className="flex items-center gap-2 flex-wrap">
                  <h1 className="text-xl font-bold text-stone-800">{profile.display_name}</h1>
                  {profile.is_hometown_visit && (
                    <span className="px-2 py-0.5 bg-green-100 text-green-700 text-xs font-bold rounded-full">
                      帰省中
                    </span>
                  )}
                </div>
                {profile.maiden_name && (
                  <p className="text-sm text-stone-500">(旧姓: {profile.maiden_name})</p>
                )}
                <p className="text-sm text-stone-600 mt-1">
                  📍 {profile.current_prefecture} {profile.current_city}在住
                </p>
                {(profile.industry || profile.occupation) && (
                  <p className="text-sm text-stone-500 mt-1">
                    💼 {[profile.industry, profile.occupation].filter(Boolean).join(' ・ ')}
                  </p>
                )}
              </div>
            </div>
          </div>

          <div className="p-6">
            <h2 className="font-bold text-stone-700 mb-4">出身校・部活</h2>
            <div className="space-y-4">
              {(profile.profile_schools ?? []).map((ps: any) => (
                <div key={ps.schools?.id} className="p-4 bg-stone-50/80 rounded-2xl border border-stone-200/40">
                  <p className="font-bold text-stone-800">
                    {ps.schools?.type === 'high' ? '🏫' : '📚'} {ps.schools?.name}
                  </p>
                  <p className="text-sm text-stone-600 mt-1">
                    {ps.graduation_year}年卒
                    {ps.club_activities?.[0] && ` ・ ${ps.club_activities[0]}`}
                    {ps.class_room && ` ・ ${ps.class_room}`}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
