import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';
import { MapClient } from './MapClient';

const PREFECTURES = [
  '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県',
  '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県',
  '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県',
  '静岡県', '愛知県', '三重県', '滋賀県', '京都府', '大阪府', '兵庫県',
  '奈良県', '和歌山県', '鳥取県', '島根県', '岡山県', '広島県', '山口県',
  '徳島県', '香川県', '愛媛県', '高知県', '福岡県', '佐賀県', '長崎県',
  '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県', '海外'
];

export default async function MapPage() {
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
    <div className="min-h-screen bg-[#F5F5F0] text-[#333] font-sans">
      <header className="sticky top-0 z-50 bg-white border-b border-[#E0E0E0] shadow-sm h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-orange-600 text-white p-1.5 rounded-lg font-bold text-xl">JC</Link>
          <span className="font-bold text-lg text-stone-700">同級生の居住地マップ</span>
        </div>
        <Link href="/dashboard" className="text-sm font-medium text-stone-600 hover:text-orange-600 transition-colors">
          ダッシュボードに戻る
        </Link>
      </header>

      <div className="max-w-4xl mx-auto p-6">
        <div className="bg-white rounded-2xl border border-[#E0E0E0] shadow-sm overflow-hidden">
          <div className="p-6 border-b border-[#E0E0E0]">
            <h1 className="text-xl font-bold text-stone-800 mb-2">同級生はどこにいる？</h1>
            <p className="text-sm text-stone-500">
              都道府県ごとに同級生の居住地を表示します。タップで一覧を表示できます。
            </p>
          </div>

          <MapClient
            schools={schools}
            years={years}
            prefectures={PREFECTURES}
          />
        </div>
      </div>
    </div>
  );
}
