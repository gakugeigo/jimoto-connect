'use server';

import { createServiceRoleClient } from '@/lib/supabase/service-role';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';

/** プロフィールの旧姓を更新（後から追加・編集可能） */
export async function updateMaidenName(maidenName: string) {
  const { userId } = await auth();
  if (!userId) {
    throw new Error('Unauthorized');
  }

  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error('SUPABASE_SERVICE_ROLE_KEY が設定されていません。');
  }

  const supabase = createServiceRoleClient();

  const { error } = await supabase
    .from('profiles')
    .update({ maiden_name: maidenName?.trim() || null })
    .eq('clerk_user_id', userId);

  if (error) {
    console.error('Profile update error:', error);
    throw new Error('プロフィールの更新に失敗しました');
  }

  revalidatePath('/profile');
  revalidatePath('/dashboard');
}

/** 帰省中チェックインのトグル */
export async function toggleHometownVisit() {
  const { userId } = await auth();
  if (!userId) throw new Error('Unauthorized');

  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error('SUPABASE_SERVICE_ROLE_KEY が設定されていません。');
  }

  const supabase = createServiceRoleClient();

  const { data: profile } = await supabase
    .from('profiles')
    .select('id, is_hometown_visit')
    .eq('clerk_user_id', userId)
    .single();

  if (!profile) throw new Error('Profile not found');

  const newValue = !profile.is_hometown_visit;

  const { error } = await supabase
    .from('profiles')
    .update({ is_hometown_visit: newValue })
    .eq('id', profile.id);

  if (error) {
    console.error('Toggle hometown visit error:', error);
    throw new Error('更新に失敗しました');
  }

  revalidatePath('/profile');
  revalidatePath('/dashboard');
  return { isHometownVisit: newValue };
}

/** 業界・職種・旧姓を更新 */
export async function updateProfileDetails(maidenName: string, industry: string, occupation: string) {
  const { userId } = await auth();
  if (!userId) throw new Error('Unauthorized');

  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error('SUPABASE_SERVICE_ROLE_KEY が設定されていません。');
  }

  const supabase = createServiceRoleClient();

  const { error } = await supabase
    .from('profiles')
    .update({
      maiden_name: maidenName?.trim() || null,
      industry: industry?.trim() || null,
      occupation: occupation?.trim() || null,
    })
    .eq('clerk_user_id', userId);

  if (error) {
    console.error('Profile update error:', error);
    throw new Error('プロフィールの更新に失敗しました');
  }

  revalidatePath('/profile');
  revalidatePath('/dashboard');
}
