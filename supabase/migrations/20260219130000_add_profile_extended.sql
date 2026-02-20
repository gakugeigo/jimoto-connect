-- ============================================
-- Migration: プロフィール拡張（帰省中・業界・職種）
-- Purpose: チェックイン、居住地一覧、業界・職種表示のためのカラム追加
-- ============================================

-- 1. 帰省中チェックイン用
alter table public.profiles add column if not exists is_hometown_visit boolean default false;
alter table public.profiles add column if not exists hometown_visit_until date;
comment on column public.profiles.is_hometown_visit is '今地元に帰省中フラグ';
comment on column public.profiles.hometown_visit_until is '帰省予定の終了日（任意）';

-- 2. 業界・職種（会社名は保存しない）
alter table public.profiles add column if not exists industry text;
alter table public.profiles add column if not exists occupation text;
comment on column public.profiles.industry is '業界（例: IT・通信、製造業）';
comment on column public.profiles.occupation is '職種（例: エンジニア、営業）';

-- Index（居住地一覧の検索用）
create index if not exists idx_profiles_is_hometown_visit on public.profiles(is_hometown_visit) where is_hometown_visit = true;
