-- ============================================
-- デモ用: 奈良中1989年卒10人 + 中大附属1992年卒10人（別々の20人）
-- ============================================
-- 使い方: Supabase ダッシュボード > SQL Editor でこのファイルの内容を実行
--
-- 前提: schools.sql が実行済みであること（奈良中学校・中央大学附属高校が存在）
--
-- 登録内容:
-- - 10人: 奈良中学校 1989年卒のみ（出身地は横浜市青葉区＝神奈川県横浜市）
-- - 10人: 中央大学附属高校 1992年卒のみ（東京・千葉・埼玉・神奈川から通学、男子校のため男子のみ）
-- - 合計20人、別々のプロフィール
-- - clerk_user_id が 'demo_seed_*' のためログインは不可
-- ============================================

-- 既存のデモシードを削除（再実行時用）
DELETE FROM public.profile_schools WHERE profile_id IN (SELECT id FROM public.profiles WHERE clerk_user_id LIKE 'demo_seed_%');
DELETE FROM public.profiles WHERE clerk_user_id LIKE 'demo_seed_%';

-- ===== 奈良中学校 1989年卒 10人 =====
-- 出身地: 全員地元（横浜市青葉区＝神奈川県横浜市）、公立中学
INSERT INTO public.profiles (
  clerk_user_id, email, display_name,
  home_prefecture, home_city, current_prefecture, current_city,
  industry, occupation, is_hometown_visit
) VALUES
  ('demo_seed_1', 'demo1@example.com', '山田 太郎', '神奈川県', '横浜市', '東京都', '渋谷区', 'IT・通信', 'エンジニア', false),
  ('demo_seed_2', 'demo2@example.com', '佐藤 健一', '神奈川県', '横浜市', '東京都', '新宿区', '製造業', '営業', false),
  ('demo_seed_3', 'demo3@example.com', '鈴木 大輔', '神奈川県', '横浜市', '千葉県', '千葉市', '金融・保険', '事務', false),
  ('demo_seed_4', 'demo4@example.com', '高橋 誠', '神奈川県', '横浜市', '東京都', '世田谷区', '建設・不動産', '設計', false),
  ('demo_seed_5', 'demo5@example.com', '伊藤 翔太', '神奈川県', '横浜市', '神奈川県', '横浜市', '小売・卸売', 'マーケティング', false),
  ('demo_seed_6', 'demo6@example.com', '渡辺 隆', '神奈川県', '横浜市', '神奈川県', '横浜市', '公務', '教員', true),
  ('demo_seed_7', 'demo7@example.com', '中村 浩二', '神奈川県', '横浜市', '埼玉県', 'さいたま市', '医療・福祉', '医師', false),
  ('demo_seed_8', 'demo8@example.com', '小林 直樹', '神奈川県', '横浜市', '東京都', '港区', 'IT・通信', 'コンサルタント', false),
  ('demo_seed_9', 'demo9@example.com', '加藤 雄一', '神奈川県', '横浜市', '埼玉県', '川口市', '教育', '塾講師', false),
  ('demo_seed_10', 'demo10@example.com', '吉田 誠一', '神奈川県', '横浜市', '千葉県', '船橋市', '運輸・物流', '営業', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

-- 奈良中1989年卒10人に 奈良中学校 のみ紐付け
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_1' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_2' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_3' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_4' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_5' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_6' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_7' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_8' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_9' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_10' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

-- ===== 中央大学附属高校 1992年卒 10人（別の10人） =====
-- 出身地: 東京・千葉・埼玉・神奈川から通学、男子校のため男子のみ、部活は男子校に存在するもののみ
INSERT INTO public.profiles (
  clerk_user_id, email, display_name,
  home_prefecture, home_city, current_prefecture, current_city,
  industry, occupation, is_hometown_visit
) VALUES
  ('demo_seed_11', 'demo11@example.com', '田中 一郎', '東京都', '小金井市', '東京都', '渋谷区', 'IT・通信', 'エンジニア', false),
  ('demo_seed_12', 'demo12@example.com', '松本 聡', '千葉県', '船橋市', '東京都', '新宿区', '製造業', '営業', false),
  ('demo_seed_13', 'demo13@example.com', '井上 拓也', '埼玉県', 'さいたま市', '千葉県', '千葉市', '金融・保険', 'アナリスト', false),
  ('demo_seed_14', 'demo14@example.com', '木村 剛', '神奈川県', '横浜市', '東京都', '世田谷区', '建設・不動産', '設計', false),
  ('demo_seed_15', 'demo15@example.com', '林 健太', '東京都', '国分寺市', '神奈川県', '横浜市', '小売・卸売', 'マーケティング', false),
  ('demo_seed_16', 'demo16@example.com', '斎藤 裕也', '千葉県', '松戸市', '神奈川県', '川崎市', '公務', '教員', false),
  ('demo_seed_17', 'demo17@example.com', '山口 慎一', '埼玉県', '川口市', '埼玉県', 'さいたま市', '医療・福祉', '医師', false),
  ('demo_seed_18', 'demo18@example.com', '森 達也', '神奈川県', '藤沢市', '東京都', '港区', 'IT・通信', 'コンサルタント', false),
  ('demo_seed_19', 'demo19@example.com', '阿部 誠', '東京都', '八王子市', '埼玉県', '川口市', '教育', '塾講師', false),
  ('demo_seed_20', 'demo20@example.com', '石井 博之', '千葉県', '柏市', '千葉県', '船橋市', '運輸・物流', '営業', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

-- 中大附属1992年卒10人に 中央大学附属高校 のみ紐付け（男子校の部活: 帰宅部、野球部、ラグビー部、サッカー部、陸上部、バレーボール部、テニス部、剣道部、柔道部）
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_11' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_12' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['ラグビー部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_13' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_14' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_15' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_16' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_17' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_18' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_19' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_20' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
