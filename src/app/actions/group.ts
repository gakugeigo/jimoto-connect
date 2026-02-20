'use server';

import { createClient } from '@/lib/supabase/server';
import { createServiceRoleClient } from '@/lib/supabase/service-role';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';
import { randomBytes } from 'crypto';

function generateInviteToken() {
  return randomBytes(16).toString('hex');
}

/** グループ作成 */
export async function createGroup(name: string, description?: string) {
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

  const inviteToken = generateInviteToken();

  const { data: group, error: groupError } = await supabase
    .from('groups')
    .insert({
      name: name.trim(),
      description: description?.trim() || null,
      created_by: profile.id,
      invite_token: inviteToken,
    })
    .select()
    .single();

  if (groupError) {
    console.error('Group create error:', groupError);
    throw new Error('グループの作成に失敗しました');
  }

  await supabase.from('group_members').insert({
    group_id: group.id,
    profile_id: profile.id,
    role: 'admin',
  });

  revalidatePath('/groups');
  return { success: true, groupId: group.id, inviteToken };
}

/** 招待リンクで参加 */
export async function joinGroupByToken(inviteToken: string) {
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

  const { data: group } = await supabase
    .from('groups')
    .select('id')
    .eq('invite_token', inviteToken.trim())
    .single();

  if (!group) throw new Error('招待リンクが無効です');

  const { data: existing } = await supabase
    .from('group_members')
    .select('id')
    .eq('group_id', group.id)
    .eq('profile_id', profile.id)
    .single();

  if (existing) throw new Error('すでにこのグループに参加しています');

  const { error } = await supabase.from('group_members').insert({
    group_id: group.id,
    profile_id: profile.id,
    role: 'member',
  });

  if (error) {
    console.error('Join group error:', error);
    throw new Error('参加に失敗しました');
  }

  revalidatePath('/groups');
  revalidatePath(`/groups/${group.id}`);
  return { success: true, groupId: group.id };
}

/** グループに投稿 */
export async function createGroupPost(groupId: string, content: string) {
  const { userId } = await auth();
  if (!userId) throw new Error('Unauthorized');

  const trimmed = content?.trim();
  if (!trimmed) throw new Error('内容を入力してください');

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

  const { data: member } = await supabase
    .from('group_members')
    .select('id')
    .eq('group_id', groupId)
    .eq('profile_id', profile.id)
    .single();

  if (!member) throw new Error('このグループのメンバーではありません');

  const { error } = await supabase.from('posts').insert({
    author_id: profile.id,
    group_id: groupId,
    content: trimmed,
  });

  if (error) {
    console.error('Group post error:', error);
    throw new Error('投稿に失敗しました');
  }

  revalidatePath(`/groups/${groupId}`);
  return { success: true };
}
