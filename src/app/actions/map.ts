'use server';

import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';

export type PrefectureCount = {
  prefecture: string;
  count: number;
  users: { id: string; display_name: string; avatar_url?: string | null; current_city: string; is_hometown_visit: boolean }[];
};

/** 同窓生の居住地を都道府県ごとに集計（自分の学校の同窓生のみ） */
export async function getAlumniByPrefecture(params?: {
  schoolId?: string;
  graduationYear?: number;
}): Promise<PrefectureCount[]> {
  const { userId } = await auth();
  if (!userId) return [];

  const supabase = await createClient();

  // 自分のプロフィールと学校取得
  const { data: myProfile } = await supabase
    .from('profiles')
    .select('id, profile_schools (school_id, graduation_year, schools (id))')
    .eq('clerk_user_id', userId)
    .single();

  if (!myProfile?.profile_schools?.length) return [];

  const mySchoolIds = (myProfile.profile_schools as any[])
    .map((ps) => ps.schools?.id ?? ps.school_id)
    .filter(Boolean);

  if (mySchoolIds.length === 0) return [];

  // 自分以外の全プロフィールを取得（居住地・学校情報付き）
  const { data: profiles, error } = await supabase
    .from('profiles')
    .select(`
      id,
      display_name,
      avatar_url,
      current_prefecture,
      current_city,
      is_hometown_visit,
      profile_schools (
        school_id,
        graduation_year,
        schools (id)
      )
    `)
    .neq('clerk_user_id', userId);

  if (error || !profiles) return [];

  // 同窓生でフィルタ（同じ学校に在籍）
  let filtered = profiles.filter((p: any) =>
    p.profile_schools?.some((ps: any) => {
      const sid = ps.schools?.id ?? ps.school_id;
      return mySchoolIds.includes(sid);
    })
  );

  if (params?.schoolId) {
    filtered = filtered.filter((p: any) =>
      p.profile_schools?.some((ps: any) => (ps.schools?.id ?? ps.school_id) === params.schoolId)
    );
  }

  if (params?.graduationYear) {
    filtered = filtered.filter((p: any) =>
      p.profile_schools?.some((ps: any) => ps.graduation_year === params.graduationYear)
    );
  }

  // 都道府県ごとに集計
  const prefectureOrder = [
    '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県',
    '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県',
    '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県',
    '静岡県', '愛知県', '三重県', '滋賀県', '京都府', '大阪府', '兵庫県',
    '奈良県', '和歌山県', '鳥取県', '島根県', '岡山県', '広島県', '山口県',
    '徳島県', '香川県', '愛媛県', '高知県', '福岡県', '佐賀県', '長崎県',
    '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県', '海外'
  ];

  const map = new Map<string, PrefectureCount>();

  for (const pref of prefectureOrder) {
    map.set(pref, { prefecture: pref, count: 0, users: [] });
  }

  for (const p of filtered) {
    const pref = p.current_prefecture?.trim() || '未登録';
    if (!map.has(pref)) {
      map.set(pref, { prefecture: pref, count: 0, users: [] });
    }
    const entry = map.get(pref)!;
    entry.count++;
    entry.users.push({
      id: p.id,
      display_name: p.display_name || '',
      avatar_url: p.avatar_url ?? null,
      current_city: p.current_city || '',
      is_hometown_visit: p.is_hometown_visit ?? false,
    });
  }

  return prefectureOrder.map((pref) => map.get(pref)!);
}
