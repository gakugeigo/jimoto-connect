'use server';

import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';

export type SearchParams = {
  schoolId?: string;
  graduationYear?: number;
  club?: string;
  industry?: string;
  occupation?: string;
  currentPrefecture?: string;
  hometownVisitOnly?: boolean;
};

/** 同窓生検索 */
export async function searchAlumni(params: SearchParams) {
  const { userId } = await auth();
  if (!userId) return [];

  const supabase = await createClient();

  // 自分以外のプロフィールを検索
  let query = supabase
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
        schools (
          id,
          name,
          type,
          prefecture,
          city
        )
      )
    `)
    .neq('clerk_user_id', userId);

  if (params.currentPrefecture) {
    query = query.eq('current_prefecture', params.currentPrefecture);
  }

  const { data: profiles, error } = await query;

  if (error) {
    console.error('Search error:', error);
    return [];
  }

  // クライアント側で schoolId, graduationYear, club でフィルタ
  let filtered = profiles ?? [];

  if (params.schoolId) {
    filtered = filtered.filter((p: any) =>
      p.profile_schools?.some((ps: any) => ps.schools?.id === params.schoolId)
    );
  }

  if (params.graduationYear) {
    filtered = filtered.filter((p: any) =>
      p.profile_schools?.some((ps: any) => ps.graduation_year === params.graduationYear)
    );
  }

  if (params.club?.trim()) {
    const clubLower = params.club.trim().toLowerCase();
    // 部活検索時は学校必須: 同じ profile_school で school と club が両方一致する場合のみ
    if (params.schoolId) {
      filtered = filtered.filter((p: any) =>
        p.profile_schools?.some(
          (ps: any) =>
            ps.schools?.id === params.schoolId &&
            ps.club_activities?.some((c: string) => c.toLowerCase().includes(clubLower))
        )
      );
    } else {
      filtered = []; // 部活検索時は学校未指定なら空
    }
  }

  if (params.industry?.trim()) {
    const indLower = params.industry.trim().toLowerCase();
    filtered = filtered.filter((p: any) =>
      (p.industry || '').toLowerCase().includes(indLower)
    );
  }

  if (params.occupation?.trim()) {
    const occLower = params.occupation.trim().toLowerCase();
    filtered = filtered.filter((p: any) =>
      (p.occupation || '').toLowerCase().includes(occLower)
    );
  }

  if (params.hometownVisitOnly) {
    filtered = filtered.filter((p: any) => p.is_hometown_visit === true);
  }

  return filtered;
}
