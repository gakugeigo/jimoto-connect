-- ============================================
-- Migration: クラス情報の追加
-- ============================================

-- profile_schools テーブルに class_room カラムを追加
alter table public.profile_schools 
add column class_room text;

comment on column public.profile_schools.class_room is '3年時のクラス (例: 3年2組)';
