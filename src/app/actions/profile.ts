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

/** プロフィール画像をアップロードして更新 */
export async function updateProfileAvatar(formData: FormData) {
  const { userId } = await auth();
  if (!userId) throw new Error('Unauthorized');

  const imageFile = formData.get('avatar') as File | null;
  if (!imageFile || imageFile.size === 0) {
    throw new Error('画像を選択してください');
  }

  const allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
  if (!allowedTypes.includes(imageFile.type)) {
    throw new Error('JPEG, PNG, WebP, GIF 形式の画像を選択してください');
  }
  if (imageFile.size > 5 * 1024 * 1024) {
    throw new Error('画像は5MB以下にしてください');
  }

  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error('SUPABASE_SERVICE_ROLE_KEY が設定されていません。');
  }

  const supabase = createServiceRoleClient();

  const { data: profile } = await supabase
    .from('profiles')
    .select('id')
    .eq('clerk_user_id', userId)
    .single();

  if (!profile) throw new Error('Profile not found');

  const fileExt = imageFile.name.split('.').pop() || 'jpg';
  const folderPath = `avatars/${profile.id}`;
  const filePath = `${folderPath}/avatar.${fileExt}`;

  // 既存のアバターを削除（post-images 内の avatars/{id}/ 以下）
  const { data: existing } = await supabase.storage.from('post-images').list(folderPath);
  if (existing?.length) {
    await supabase.storage.from('post-images').remove(existing.map((o) => `${folderPath}/${o.name}`));
  }

  const { error: uploadError } = await supabase.storage
    .from('post-images')
    .upload(filePath, imageFile, { upsert: true });

  if (uploadError) {
    console.error('Avatar upload error:', uploadError);
    throw new Error('画像のアップロードに失敗しました');
  }

  const { data: { publicUrl } } = supabase.storage
    .from('post-images')
    .getPublicUrl(filePath);

  const { error: updateError } = await supabase
    .from('profiles')
    .update({ avatar_url: publicUrl })
    .eq('id', profile.id);

  if (updateError) {
    console.error('Profile avatar update error:', updateError);
    throw new Error('プロフィールの更新に失敗しました');
  }

  revalidatePath('/profile');
  revalidatePath('/dashboard');
  return { avatarUrl: publicUrl };
}

/** プリセットアバターを選択（マイグレーション不要、avatar_url に preset:xxx を保存） */
export async function updateProfileAvatarPreset(style: string) {
  const { userId } = await auth();
  if (!userId) throw new Error('Unauthorized');

  const validStyles = ['lorelei', 'notionists', 'bottts', 'thumbs', 'avataaars', 'micah', 'lorelei-neutral', 'adventurer', 'big-ears', 'big-smile', 'open-peeps', 'fun-emoji', 'icon:notebook-pencil', 'icon:flower-rose', 'icon:flower-tulip', 'icon:flower-sunflower', 'icon:flower-sakura', 'icon:flower-lily'];
  if (!validStyles.includes(style)) {
    throw new Error('無効なスタイルです');
  }

  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error('SUPABASE_SERVICE_ROLE_KEY が設定されていません。');
  }

  const supabase = createServiceRoleClient();

  const { error } = await supabase
    .from('profiles')
    .update({ avatar_url: style.startsWith('icon:') ? style : `preset:${style}` })
    .eq('clerk_user_id', userId);

  if (error) {
    console.error('Profile avatar preset update error:', error);
    throw new Error('プロフィールの更新に失敗しました');
  }

  revalidatePath('/profile');
  revalidatePath('/dashboard');
}
