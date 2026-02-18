'use server';

import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';
import { redirect } from 'next/navigation';

// --- 学校検索 ---
export async function searchSchools(query: string, prefecture: string) {
  if (!query || query.length < 2) return [];

  const supabase = await createClient();
  
  // 学校名で部分一致検索 (都道府県で絞り込み)
  let dbQuery = supabase
    .from('schools')
    .select('*')
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

// --- プロフィール登録 (オンボーディング完了) ---
export async function completeOnboarding(formData: {
  displayName: string;
  homePrefecture: string;
  currentPrefecture: string;
  schoolId: string;
  graduationYear: number;
  club: string;
  classRoom: string; // 追加
}) {
  const { userId } = await auth();
  if (!userId) {
    throw new Error('Unauthorized');
  }

  const supabase = await createClient();

  // 1. プロフィールの作成 (または更新)
  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .upsert({
      clerk_user_id: userId,
      display_name: formData.displayName,
      email: '', 
      home_prefecture: formData.homePrefecture,
      current_prefecture: formData.currentPrefecture,
      home_city: '', 
      current_city: '', 
    }, { onConflict: 'clerk_user_id' })
    .select()
    .single();

  if (profileError) {
    console.error('Profile creation error:', profileError);
    throw new Error('Failed to create profile');
  }

  // 2. 学校・部活情報の登録 (profile_schools)
  await supabase
    .from('profile_schools')
    .delete()
    .eq('profile_id', profile.id);

  const { error: schoolError } = await supabase
    .from('profile_schools')
    .insert({
      profile_id: profile.id,
      school_id: formData.schoolId,
      graduation_year: formData.graduationYear,
      club_activities: [formData.club], 
      class_room: formData.classRoom, // 追加
    });

  if (schoolError) {
    console.error('School registration error:', schoolError);
    throw new Error('Failed to register school');
  }

  // 3. キャッシュ更新とリダイレクト
  revalidatePath('/');
  redirect('/dashboard');
}
