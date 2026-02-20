'use server';

import { createClient } from '@/lib/supabase/server';
import { createServiceRoleClient } from '@/lib/supabase/service-role';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';

/** イベント作成 */
export async function createEvent(data: {
  title: string;
  description?: string;
  eventDate: string;
  eventTime?: string;
  location?: string;
  schoolId?: string;
  maxParticipants?: number;
}) {
  const { userId } = await auth();
  if (!userId) throw new Error('Unauthorized');

  const trimmedTitle = data.title?.trim();
  if (!trimmedTitle) throw new Error('タイトルを入力してください');
  if (!data.eventDate) throw new Error('日付を入力してください');

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

  const { data: event, error } = await supabase
    .from('events')
    .insert({
      title: trimmedTitle,
      description: data.description?.trim() || null,
      event_date: data.eventDate,
      event_time: data.eventTime?.trim() || null,
      location: data.location?.trim() || null,
      school_id: data.schoolId || null,
      organizer_id: profile.id,
      max_participants: data.maxParticipants || null,
    })
    .select()
    .single();

  if (error) {
    console.error('Event create error:', error);
    throw new Error('イベントの作成に失敗しました');
  }

  // 作成者を参加者に追加
  await supabase.from('event_attendances').insert({
    event_id: event.id,
    profile_id: profile.id,
  });

  revalidatePath('/events');
  revalidatePath('/dashboard');
  return { success: true, eventId: event.id };
}

/** イベント参加 */
export async function joinEvent(eventId: string) {
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

  const { data: event } = await supabase
    .from('events')
    .select('id, max_participants')
    .eq('id', eventId)
    .single();

  if (!event) throw new Error('イベントが見つかりません');

  const { count } = await supabase
    .from('event_attendances')
    .select('*', { count: 'exact', head: true })
    .eq('event_id', eventId);

  if (event.max_participants != null && (count ?? 0) >= event.max_participants) {
    throw new Error('定員に達しています');
  }

  const { data: existing } = await supabase
    .from('event_attendances')
    .select('id')
    .eq('event_id', eventId)
    .eq('profile_id', profile.id)
    .single();

  if (existing) throw new Error('すでに参加しています');

  const { error } = await supabase.from('event_attendances').insert({
    event_id: eventId,
    profile_id: profile.id,
  });

  if (error) {
    console.error('Join event error:', error);
    throw new Error('参加に失敗しました');
  }

  revalidatePath('/events');
  revalidatePath(`/events/${eventId}`);
  return { success: true };
}

/** イベント参加キャンセル */
export async function leaveEvent(eventId: string) {
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

  const { data: event } = await supabase
    .from('events')
    .select('organizer_id')
    .eq('id', eventId)
    .single();

  if (!event) throw new Error('イベントが見つかりません');
  if (event.organizer_id === profile.id) {
    throw new Error('主催者は参加をキャンセルできません。イベントを削除してください。');
  }

  const { error } = await supabase
    .from('event_attendances')
    .delete()
    .eq('event_id', eventId)
    .eq('profile_id', profile.id);

  if (error) {
    console.error('Leave event error:', error);
    throw new Error('キャンセルに失敗しました');
  }

  revalidatePath('/events');
  revalidatePath(`/events/${eventId}`);
  return { success: true };
}

/** イベント削除（主催者のみ） */
export async function deleteEvent(eventId: string) {
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

  const { data: event } = await supabase
    .from('events')
    .select('organizer_id')
    .eq('id', eventId)
    .single();

  if (!event) throw new Error('イベントが見つかりません');
  if (event.organizer_id !== profile.id) {
    throw new Error('主催者のみイベントを削除できます');
  }

  const { error } = await supabase.from('events').delete().eq('id', eventId);

  if (error) {
    console.error('Delete event error:', error);
    throw new Error('削除に失敗しました');
  }

  revalidatePath('/events');
  revalidatePath('/dashboard');
  return { success: true };
}
