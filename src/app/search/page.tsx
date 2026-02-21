import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';
import { SearchForm } from './SearchForm';

const PREFECTURES = [
  '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県',
  '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県',
  '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県',
  '静岡県', '愛知県', '三重県', '滋賀県', '京都府', '大阪府', '兵庫県',
  '奈良県', '和歌山県', '鳥取県', '島根県', '岡山県', '広島県', '山口県',
  '徳島県', '香川県', '愛媛県', '高知県', '福岡県', '佐賀県', '長崎県',
  '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県', '海外'
];

export default async function SearchPage() {
  const { userId } = await auth();
  if (!userId) redirect('/sign-in');

  const supabase = await createClient();

  const { data: profile } = await supabase
    .from('profiles')
    .select('id, profile_schools (school_id, schools (id, name, type, prefecture, city))')
    .eq('clerk_user_id', userId)
    .single();

  if (!profile) redirect('/onboarding');

  const mySchools = profile.profile_schools ?? [];
  const schools = mySchools
    .map((ps: any) => ps.schools)
    .filter(Boolean)
    .filter((s: any, i: number, arr: any[]) => arr.findIndex((x: any) => x?.id === s?.id) === i);

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800">
      <header className="sticky top-0 z-40 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 min-h-[52px] flex items-center justify-between px-4 sm:px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-2 rounded-xl font-bold text-xl shadow-lg shadow-orange-200/40 min-h-[44px] min-w-[44px] flex items-center justify-center">JC</Link>
          <span className="font-bold text-base sm:text-lg text-stone-700">同窓生検索</span>
        </div>
        <div className="hidden lg:flex items-center gap-4">
          <Link href="/messages" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors py-2">
            メッセージ
          </Link>
          <Link href="/map" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors py-2">
            居住地マップ
          </Link>
          <Link href="/dashboard" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors py-2">
            ダッシュボードに戻る
          </Link>
        </div>
      </header>

      <div className="max-w-2xl mx-auto p-4 sm:p-6">
        <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 overflow-hidden">
          <div className="p-6 border-b border-stone-100">
            <h1 className="text-xl font-bold text-stone-800 mb-2">同窓生を探す</h1>
            <p className="text-sm text-stone-500">
              学校・卒業年・部活・居住地で絞り込んで検索できます。
            </p>
          </div>

          <div className="p-6">
            <SearchForm schools={schools} prefectures={PREFECTURES} />
          </div>
        </div>
      </div>
    </div>
  );
}
