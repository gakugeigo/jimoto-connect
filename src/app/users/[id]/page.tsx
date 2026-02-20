import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect, notFound } from 'next/navigation';
import Link from 'next/link';

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

  return (
    <div className="min-h-screen bg-[#F5F5F0] text-[#333] font-sans">
      <header className="sticky top-0 z-50 bg-white border-b border-[#E0E0E0] shadow-sm h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-orange-600 text-white p-1.5 rounded-lg font-bold text-xl">JC</Link>
          <span className="font-bold text-lg text-stone-700">Jimoto-Connect</span>
        </div>
        <Link href="/search" className="text-sm font-medium text-stone-600 hover:text-orange-600 transition-colors">
          ← 検索に戻る
        </Link>
      </header>

      <div className="max-w-2xl mx-auto p-6">
        <div className="bg-white rounded-2xl border border-[#E0E0E0] shadow-sm overflow-hidden">
          <div className="p-6 border-b border-[#E0E0E0]">
            <div className="flex items-center gap-4">
              <div className="w-20 h-20 rounded-full bg-stone-100 overflow-hidden border-2 border-white shadow-sm flex-shrink-0">
                <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${profile.display_name}`} alt="" />
              </div>
              <div>
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
                <div key={ps.schools?.id} className="p-4 bg-stone-50 rounded-xl">
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
