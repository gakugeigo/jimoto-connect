-- ============================================
-- Migration: 個別メッセージ（DM）テーブル
-- Purpose: ユーザー間の1:1メッセージ
-- ============================================

create table public.direct_messages (
  id uuid primary key default gen_random_uuid(),
  sender_id uuid references public.profiles(id) on delete cascade not null,
  receiver_id uuid references public.profiles(id) on delete cascade not null,
  content text not null,
  created_at timestamptz default now() not null
);

comment on table public.direct_messages is 'ユーザー間の個別メッセージ';

create index idx_direct_messages_sender on public.direct_messages(sender_id);
create index idx_direct_messages_receiver on public.direct_messages(receiver_id);
create index idx_direct_messages_created_at on public.direct_messages(created_at);

-- RLS
alter table public.direct_messages enable row level security;

-- 自分が送信者または受信者のメッセージのみ閲覧可
create policy "direct_messages_select" on public.direct_messages
  for select to authenticated
  using (
    exists (
      select 1 from public.profiles p
      where p.clerk_user_id = auth.jwt() ->> 'sub'
      and (p.id = sender_id or p.id = receiver_id)
    )
  );

-- 自分が送信者の場合のみ挿入可
create policy "direct_messages_insert" on public.direct_messages
  for insert to authenticated
  with check (
    exists (
      select 1 from public.profiles p
      where p.clerk_user_id = auth.jwt() ->> 'sub'
      and p.id = sender_id
    )
  );
