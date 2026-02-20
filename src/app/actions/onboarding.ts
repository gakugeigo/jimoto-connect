'use server';

import { createClient } from '@/lib/supabase/server';
import { createServiceRoleClient } from '@/lib/supabase/service-role';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';

// --- 学校検索 ---
export async function searchSchools(query: string, prefecture: string, type: 'junior_high' | 'high') {
  if (!query || query.length < 2) return [];

  const supabase = await createClient();
  
  let dbQuery = supabase
    .from('schools')
    .select('*')
    .eq('type', type)
    .ilike('name', `%${query}%`);

  if (prefecture) {
    dbQuery = dbQuery.eq('prefecture', prefecture);
  }

  const { data, error } = await dbQuery.limit(10);

  if (error) {
    console.error('School search error:', error);
    return [];
  }

  return data;
}

type SchoolData = {
  schoolId?: string;
  schoolName: string;
  prefecture: string;
  city?: string;
  graduationYear: number;
  club: string;
  classRoom: string;
};

// --- プロフィール登録 (オンボーディング完了) ---
export async function completeOnboarding(formData: {
  displayName: string;
  maidenName: string;
  currentPrefecture: string;
  currentCountry?: string; // 追加: 海外の場合の国名
  juniorHigh?: SchoolData;
  highSchool?: SchoolData;
}) {
  const { userId } = await auth();
  if (!userId) {
    throw new Error('Unauthorized');
  }

  if (!formData.juniorHigh?.schoolName && !formData.highSchool?.schoolName) {
    throw new Error('At least one school is required');
  }

  // RLSをバイパスするため、書き込みはサービスロールで実行（Clerk JWT未連携時も動作）
  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error('SUPABASE_SERVICE_ROLE_KEY が設定されていません。Supabase ダッシュボードの Settings > API から取得し .env.local に追加してください。');
  }
  const supabase = createServiceRoleClient();

  // 1. プロフィールの作成 (または更新)
  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .upsert({
      clerk_user_id: userId,
      display_name: formData.displayName,
      maiden_name: formData.maidenName,
      email: '', 
      home_prefecture: '', 
      current_prefecture: formData.currentPrefecture,
      home_city: '', 
      current_city: formData.currentCountry || '', // 海外の場合はここに国名を入れる
    }, { onConflict: 'clerk_user_id' })
    .select()
    .single();

  if (profileError) {
    console.error('Profile creation error:', profileError);
    throw new Error('Failed to create profile');
  }

  // 2. 学校情報の登録
  await supabase
    .from('profile_schools')
    .delete()
    .eq('profile_id', profile.id);

  const schoolsToInsert = [];

  const getOrCreateSchoolId = async (data: SchoolData, type: 'junior_high' | 'high') => {
    if (data.schoolId) return data.schoolId;

    const { data: newSchool, error } = await supabase
      .from('schools')
      .insert({
        name: data.schoolName,
        type: type,
        prefecture: data.prefecture,
        city: data.city || '',
      })
      .select('id')
      .single();

    if (error) {
      console.error('Create school error:', error);
      throw new Error(`Failed to create school: ${data.schoolName}`);
    }
    return newSchool.id;
  };

  const toClubArray = (club: string) => [club?.trim() || '帰宅部'];

  if (formData.juniorHigh?.schoolName) {
    const schoolId = await getOrCreateSchoolId(formData.juniorHigh, 'junior_high');
    schoolsToInsert.push({
      profile_id: profile.id,
      school_id: schoolId,
      graduation_year: formData.juniorHigh.graduationYear,
      club_activities: toClubArray(formData.juniorHigh.club),
      class_room: formData.juniorHigh.classRoom || null,
    });
  }

  if (formData.highSchool?.schoolName) {
    const schoolId = await getOrCreateSchoolId(formData.highSchool, 'high');
    schoolsToInsert.push({
      profile_id: profile.id,
      school_id: schoolId,
      graduation_year: formData.highSchool.graduationYear,
      club_activities: toClubArray(formData.highSchool.club),
      class_room: formData.highSchool.classRoom || null,
    });
  }

  const { error: schoolError } = await supabase
    .from('profile_schools')
    .insert(schoolsToInsert);

  if (schoolError) {
    console.error('School registration error:', schoolError);
    throw new Error('Failed to register school');
  }

  revalidatePath('/');
  revalidatePath('/dashboard');
  return { success: true };
}
