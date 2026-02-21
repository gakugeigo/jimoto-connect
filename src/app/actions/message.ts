'use server';

import { createServiceRoleClient } from '@/lib/supabase/service-role';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';

/** メッセージを送信 */
export async function sendMessage(receiverId: string, content: string) {
  const { userId } = await auth();
  if (!userId) throw new Error('ログインしてください');

  const trimmed = content?.trim();
  if (!trimmed) throw new Error('メッセージを入力してください');

  if (receiverId === '') throw new Error('送信先を指定してください');

  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error('SUPABASE_SERVICE_ROLE_KEY が設定されていません。');
  }

  const supabase = createServiceRoleClient();

  const { data: me } = await supabase
    .from('profiles')
    .select('id')
    .eq('clerk_user_id', userId)
    .single();

  if (!me) throw new Error('プロフィールが見つかりません');

  if (me.id === receiverId) throw new Error('自分には送信できません');

  const { error } = await supabase.from('direct_messages').insert({
    sender_id: me.id,
    receiver_id: receiverId,
    content: trimmed,
  });

  if (error) {
    console.error('Message send error:', error);
    throw new Error('メッセージの送信に失敗しました');
  }

  revalidatePath('/messages');
  revalidatePath(`/messages/${receiverId}`);
  return { success: true };
}

/** 特定ユーザーとの会話を取得 */
export async function getConversationWithUser(otherUserId: string) {
  const { userId } = await auth();
  if (!userId) return { messages: [], otherUser: null };

  const supabase = createServiceRoleClient();

  const { data: me } = await supabase
    .from('profiles')
    .select('id')
    .eq('clerk_user_id', userId)
    .single();

  if (!me) return { messages: [], otherUser: null };

  const { data: otherUser } = await supabase
    .from('profiles')
    .select('id, display_name, avatar_url')
    .eq('id', otherUserId)
    .single();

  if (!otherUser) return { messages: [], otherUser: null };

  const { data: allMessages } = await supabase
    .from('direct_messages')
    .select('id, sender_id, receiver_id, content, created_at')
    .or(`sender_id.eq.${me.id},receiver_id.eq.${me.id}`)
    .order('created_at', { ascending: true });

  const messages = (allMessages ?? []).filter(
    (m) => m.sender_id === otherUserId || m.receiver_id === otherUserId
  );

  return { messages, otherUser };
}

/** 会話一覧（メッセージのやり取りがあった相手のリスト）を取得 */
export async function getConversations() {
  const { userId } = await auth();
  if (!userId) return [];

  const supabase = createServiceRoleClient();

  const { data: me } = await supabase
    .from('profiles')
    .select('id')
    .eq('clerk_user_id', userId)
    .single();

  if (!me) return [];

  const { data: sent } = await supabase
    .from('direct_messages')
    .select('receiver_id, content, created_at')
    .eq('sender_id', me.id)
    .order('created_at', { ascending: false });

  const { data: received } = await supabase
    .from('direct_messages')
    .select('sender_id, content, created_at')
    .eq('receiver_id', me.id)
    .order('created_at', { ascending: false });

  const partnerIds = new Set<string>();
  const lastMessageByPartner: Record<string, { content: string; created_at: string }> = {};

  for (const m of sent ?? []) {
    partnerIds.add(m.receiver_id);
    if (!lastMessageByPartner[m.receiver_id] || m.created_at > lastMessageByPartner[m.receiver_id].created_at) {
      lastMessageByPartner[m.receiver_id] = { content: m.content, created_at: m.created_at };
    }
  }
  for (const m of received ?? []) {
    partnerIds.add(m.sender_id);
    if (!lastMessageByPartner[m.sender_id] || m.created_at > lastMessageByPartner[m.sender_id].created_at) {
      lastMessageByPartner[m.sender_id] = { content: m.content, created_at: m.created_at };
    }
  }

  if (partnerIds.size === 0) return [];

  const { data: partners } = await supabase
    .from('profiles')
    .select('id, display_name, avatar_url')
    .in('id', Array.from(partnerIds));

  const list = (partners ?? []).map((p) => ({
    ...p,
    lastMessage: lastMessageByPartner[p.id],
  }));

  list.sort((a, b) =>
    (b.lastMessage?.created_at ?? '').localeCompare(a.lastMessage?.created_at ?? '')
  );

  return list;
}
