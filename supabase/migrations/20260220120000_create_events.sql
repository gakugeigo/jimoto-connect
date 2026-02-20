-- ============================================
-- Migration: 同窓会イベント機能
-- Purpose: イベント作成・参加申し込み・一覧表示
-- ============================================

-- 1. events テーブル
create table public.events (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  event_date date not null,
  event_time text,
  location text,
  school_id uuid references public.schools(id) on delete set null,
  organizer_id uuid references public.profiles(id) on delete cascade not null,
  max_participants integer,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);
comment on table public.events is '同窓会・県人会イベント';

-- 2. event_attendances テーブル（参加申し込み）
create table public.event_attendances (
  id uuid primary key default gen_random_uuid(),
  event_id uuid references public.events(id) on delete cascade not null,
  profile_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now() not null,
  unique(event_id, profile_id)
);
comment on table public.event_attendances is 'イベント参加者';

-- RLS
alter table public.events enable row level security;
alter table public.event_attendances enable row level security;

create policy "events_select" on public.events for select to authenticated, anon using (true);
create policy "events_insert" on public.events for insert to authenticated
  with check (organizer_id in (select id from public.profiles where clerk_user_id = auth.jwt() ->> 'sub'));
create policy "events_update" on public.events for update to authenticated
  using (organizer_id in (select id from public.profiles where clerk_user_id = auth.jwt() ->> 'sub'));
create policy "events_delete" on public.events for delete to authenticated
  using (organizer_id in (select id from public.profiles where clerk_user_id = auth.jwt() ->> 'sub'));

create policy "event_attendances_select" on public.event_attendances for select to authenticated, anon using (true);
create policy "event_attendances_insert" on public.event_attendances for insert to authenticated
  with check (profile_id in (select id from public.profiles where clerk_user_id = auth.jwt() ->> 'sub'));
create policy "event_attendances_delete" on public.event_attendances for delete to authenticated
  using (profile_id in (select id from public.profiles where clerk_user_id = auth.jwt() ->> 'sub'));

-- Indexes
create index idx_events_school_id on public.events(school_id);
create index idx_events_organizer_id on public.events(organizer_id);
create index idx_events_event_date on public.events(event_date);
create index idx_event_attendances_event_id on public.event_attendances(event_id);
create index idx_event_attendances_profile_id on public.event_attendances(profile_id);
