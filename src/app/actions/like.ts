'use server';

import { createServiceRoleClient } from '@/lib/supabase/service-role';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';

/** いいねのトグル（押すとON/OFF切り替え） */
export async function toggleLike(postId: string) {
  const { userId } = await auth();
  if (!userId) throw new Error('Unauthorized');

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

  const { data: existing } = await supabase
    .from('likes')
    .select('id')
    .eq('post_id', postId)
    .eq('user_id', profile.id)
    .single();

  if (existing) {
    await supabase.from('likes').delete().eq('id', existing.id);
    revalidatePath('/dashboard');
    return { liked: false };
  } else {
    await supabase.from('likes').insert({
      post_id: postId,
      user_id: profile.id,
    });
    revalidatePath('/dashboard');
    return { liked: true };
  }
}
