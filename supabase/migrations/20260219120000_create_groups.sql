-- ============================================
-- Migration: マイグループ（部活外の任意グループ）
-- Purpose: 帰宅部など部活がない人向けのLINE風グループ機能
-- ============================================

-- 1. groups テーブル
create table public.groups (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  created_by uuid references public.profiles(id) on delete cascade not null,
  invite_token text unique not null,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);
comment on table public.groups is 'マイグループ（部活外の任意グループ）';

-- 2. group_members テーブル
create table public.group_members (
  id uuid primary key default gen_random_uuid(),
  group_id uuid references public.groups(id) on delete cascade not null,
  profile_id uuid references public.profiles(id) on delete cascade not null,
  role text not null default 'member' check (role in ('admin', 'member')),
  joined_at timestamptz default now() not null,
  unique(group_id, profile_id)
);
comment on table public.group_members is 'グループメンバー';

-- 3. posts に group_id を追加
alter table public.posts add column if not exists group_id uuid references public.groups(id) on delete cascade;

-- RLS
alter table public.groups enable row level security;
alter table public.group_members enable row level security;

create policy "groups_select" on public.groups for select to authenticated, anon using (true);
create policy "groups_insert" on public.groups for insert to authenticated
  with check (created_by in (select id from public.profiles where clerk_user_id = auth.jwt() ->> 'sub'));
create policy "groups_update" on public.groups for update to authenticated
  using (created_by in (select id from public.profiles where clerk_user_id = auth.jwt() ->> 'sub'));

create policy "group_members_select" on public.group_members for select to authenticated, anon using (true);
create policy "group_members_insert" on public.group_members for insert to authenticated
  with check (profile_id in (select id from public.profiles where clerk_user_id = auth.jwt() ->> 'sub'));

-- Indexes
create index idx_groups_invite_token on public.groups(invite_token);
create index idx_groups_created_by on public.groups(created_by);
create index idx_group_members_group_id on public.group_members(group_id);
create index idx_group_members_profile_id on public.group_members(profile_id);
create index idx_posts_group_id on public.posts(group_id);
