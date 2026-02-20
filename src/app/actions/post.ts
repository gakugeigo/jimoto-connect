'use server';

import { createServiceRoleClient } from '@/lib/supabase/service-role';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';

// --- 投稿の作成 ---
export async function createPost(formData: FormData) {
  const { userId } = await auth();
  if (!userId) {
    throw new Error('Unauthorized');
  }

  const content = formData.get('content') as string;
  const imageFile = formData.get('image') as File | null;
  const schoolId = formData.get('schoolId') as string; // 投稿先の学校ID

  if (!content && !imageFile) {
    throw new Error('Content or image is required');
  }

  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error('SUPABASE_SERVICE_ROLE_KEY が設定されていません。');
  }

  const supabase = createServiceRoleClient();

  // 1. 投稿者のプロフィールIDを取得
  const { data: profile } = await supabase
    .from('profiles')
    .select('id')
    .eq('clerk_user_id', userId)
    .single();

  if (!profile) {
    throw new Error('Profile not found');
  }

  let imageUrl = null;

  // 2. 画像のアップロード (ある場合)
  if (imageFile && imageFile.size > 0) {
    const fileExt = imageFile.name.split('.').pop();
    const fileName = `${userId}-${Date.now()}.${fileExt}`;
    const filePath = `${fileName}`;

    const { error: uploadError } = await supabase.storage
      .from('post-images')
      .upload(filePath, imageFile);

    if (uploadError) {
      console.error('Image upload error:', uploadError);
      throw new Error('Failed to upload image');
    }

    // 公開URLの取得
    const { data: { publicUrl } } = supabase.storage
      .from('post-images')
      .getPublicUrl(filePath);
    
    imageUrl = publicUrl;
  }

  // 3. 投稿データの保存（contentは必須のため画像のみの場合はプレースホルダー）
  const postContent = content?.trim() || (imageUrl ? '(画像)' : '(投稿)');
  const { error: postError } = await supabase
    .from('posts')
    .insert({
      author_id: profile.id,
      school_id: schoolId || null,
      content: postContent,
      image_url: imageUrl,
    });

  if (postError) {
    console.error('Post creation error:', postError);
    throw new Error('Failed to create post');
  }

  revalidatePath('/dashboard');
  return { success: true };
}
