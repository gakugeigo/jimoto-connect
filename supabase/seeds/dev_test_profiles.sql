-- ============================================
-- 開発用テストプロフィール（検索機能の確認用）
-- ============================================
-- 使い方: Supabase ダッシュボード > SQL Editor でこのファイルの内容を実行
-- 注意: clerk_user_id が 'dev_seed_*' のためログインはできませんが、
--       同窓生検索の結果には表示されます。動作確認用です。
-- ============================================

-- 既存のテストプロフィールを削除（再実行時用）
DELETE FROM public.profile_schools WHERE profile_id IN (SELECT id FROM public.profiles WHERE clerk_user_id LIKE 'dev_seed_%');
DELETE FROM public.profiles WHERE clerk_user_id LIKE 'dev_seed_%';

-- テストプロフィールを3件追加
INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city)
VALUES
  ('dev_seed_1', '', '山田 花子', '', '', '東京都', ''),
  ('dev_seed_2', '', '佐藤 太郎', '', '', '東京都', ''),
  ('dev_seed_3', '', '鈴木 次郎', '', '', '神奈川県', '横浜市')
ON CONFLICT (clerk_user_id) DO NOTHING;

-- 各プロフィールに学校情報を紐付け
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '3組'
FROM public.profiles p
CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'dev_seed_1' AND s.name = '那覇高等学校' AND s.type = 'high'
LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '1組'
FROM public.profiles p
CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'dev_seed_2' AND s.name = '那覇高等学校' AND s.type = 'high'
LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1990, ARRAY['サッカー部'], '2組'
FROM public.profiles p
CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'dev_seed_3' AND s.name = '横浜翠嵐高等学校' AND s.type = 'high'
LIMIT 1;
