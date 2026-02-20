'use server';

import { createServiceRoleClient } from '@/lib/supabase/service-role';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';

/** コメントを追加 */
export async function createComment(postId: string, content: string) {
  const { userId } = await auth();
  if (!userId) throw new Error('Unauthorized');

  const trimmed = content?.trim();
  if (!trimmed) throw new Error('コメントを入力してください');

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

  const { error } = await supabase.from('comments').insert({
    post_id: postId,
    user_id: profile.id,
    content: trimmed,
  });

  if (error) {
    console.error('Comment error:', error);
    throw new Error('コメントの投稿に失敗しました');
  }

  revalidatePath('/dashboard');
  return { success: true };
}
