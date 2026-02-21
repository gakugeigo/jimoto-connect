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
  const schoolId = (formData.get('schoolId') as string)?.trim() || '';
  const boardType = (formData.get('boardType') as string) || 'all'; // 掲示板種別: all | classmates | club

  if (!content && !imageFile) {
    throw new Error('Content or image is required');
  }
  if (!schoolId) {
    throw new Error('投稿先の学校を選択してください');
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
  const boardTypeValue = ['all', 'classmates', 'club'].includes(boardType) ? boardType : 'all';

  let { error: postError } = await supabase
    .from('posts')
    .insert({
      author_id: profile.id,
      school_id: schoolId,
      content: postContent,
      image_url: imageUrl,
      board_type: boardTypeValue,
    });

  // board_type カラムが未作成の場合のフォールバック（マイグレーション未実行時）
  if (postError) {
    const msg = String(postError.message || '');
    const isColumnError = /board_type|column|does not exist/i.test(msg);
    if (isColumnError) {
      const { error: fallbackError } = await supabase
        .from('posts')
        .insert({
          author_id: profile.id,
          school_id: schoolId,
          content: postContent,
          image_url: imageUrl,
        });
      if (!fallbackError) {
        postError = null; // フォールバック成功
      } else {
        console.error('Post creation error (fallback):', fallbackError);
      }
    }
    if (postError) {
      console.error('Post creation error:', postError);
      throw new Error('投稿に失敗しました。');
    }
  }

  revalidatePath('/dashboard');
  return { success: true };
}
