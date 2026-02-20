-- ============================================
-- Migration: 旧姓カラムの追加
-- ============================================

-- profiles テーブルに maiden_name カラムを追加
alter table public.profiles 
add column maiden_name text;

comment on column public.profiles.maiden_name is '旧姓 (任意)';
