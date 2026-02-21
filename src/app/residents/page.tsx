import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';
import { ResidentsClient } from './ResidentsClient';

export default async function ResidentsPage() {
  const { userId } = await auth();
  if (!userId) redirect('/sign-in');

  const supabase = await createClient();

  const { data: profile } = await supabase
    .from('profiles')
    .select('id, profile_schools (school_id, graduation_year, schools (id, name, type))')
    .eq('clerk_user_id', userId)
    .single();

  if (!profile || !profile.profile_schools?.length) redirect('/onboarding');

  const schools = (profile.profile_schools ?? [])
    .map((ps: any) => ps.schools)
    .filter(Boolean)
    .filter((s: any, i: number, arr: any[]) => arr.findIndex((x: any) => x?.id === s?.id) === i);

  const years = Array.from(
    new Set(
      (profile.profile_schools ?? []).map((ps: any) => ps.graduation_year).filter(Boolean)
    )
  ).sort((a, b) => (b as number) - (a as number));

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800">
      <header className="sticky top-0 z-40 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 min-h-[52px] flex items-center justify-between px-4 sm:px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-2 rounded-xl font-bold text-xl shadow-lg shadow-orange-200/40 min-h-[44px] min-w-[44px] flex items-center justify-center">
            JC
          </Link>
          <span className="font-bold text-base sm:text-lg text-stone-700">居住地一覧</span>
        </div>
        <div className="hidden lg:flex items-center gap-4">
          <Link href="/map" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors py-2">
            マップで見る
          </Link>
          <Link href="/dashboard" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors py-2">
            ダッシュボード
          </Link>
        </div>
      </header>

      <div className="max-w-2xl mx-auto p-4 sm:p-6">
        <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 overflow-hidden">
          <div className="p-6 border-b border-stone-100">
            <h1 className="text-xl font-bold text-stone-800 mb-2">同級生の居住地一覧</h1>
            <p className="text-sm text-stone-500">
              都道府県ごとに同級生の人数と一覧を表示します。タップで詳細を開けます。
            </p>
          </div>

          <ResidentsClient schools={schools} years={years} />
        </div>
      </div>
    </div>
  );
}
