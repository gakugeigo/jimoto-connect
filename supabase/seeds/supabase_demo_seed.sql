-- ============================================
-- Supabase デモシード（1ファイルで完結・安全に再実行可能）
-- ============================================
-- 使い方: Supabase ダッシュボード > SQL Editor でこのファイルの内容を実行
--
-- 実行内容:
-- 1. 奈良中学校・中央大学附属高校 を追加（存在しない場合のみ）
-- 2. デモプロフィール40人を削除して再投入
--    - 10人: 奈良中学校 1989年卒
--    - 10人: 中央大学附属高校 1992年卒
--    - 10人: 奈良中学校 1990〜1999年卒（同じ業種・職種 or 別業種・職種で同じ都道府県）
--    - 10人: 中央大学附属高校 1995〜2004年卒（同上）
--
-- ※ 既存の schools は削除しません。既存ユーザーの profile_schools もそのままです。
-- ============================================

-- 1. 奈良中学校・中央大学附属高校 を追加（存在しない場合のみ）
INSERT INTO public.schools (name, type, prefecture, city)
SELECT '奈良中学校', 'junior_high', '神奈川県', '横浜市'
WHERE NOT EXISTS (SELECT 1 FROM public.schools WHERE name = '奈良中学校' AND type = 'junior_high');

INSERT INTO public.schools (name, type, prefecture, city)
SELECT '中央大学附属高校', 'high', '東京都', '小金井市'
WHERE NOT EXISTS (SELECT 1 FROM public.schools WHERE name = '中央大学附属高校' AND type = 'high');

-- 2. 既存のデモシードを削除（再実行時用）
DELETE FROM public.profile_schools WHERE profile_id IN (SELECT id FROM public.profiles WHERE clerk_user_id LIKE 'demo_seed_%');
DELETE FROM public.profiles WHERE clerk_user_id LIKE 'demo_seed_%';

-- 3. 奈良中学校 1989年卒 10人
-- 居住地: 4人=神奈川県、2人=東京都、4人=地方都市（current_cityは空・都道府県のみ）
INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_1', 'demo1@example.com', '山田 太郎', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_2', 'demo2@example.com', '佐藤 健一', '神奈川県', '横浜市', '神奈川県', '', '製造業', '営業', false),
  ('demo_seed_3', 'demo3@example.com', '鈴木 大輔', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', '事務', false),
  ('demo_seed_4', 'demo4@example.com', '高橋 誠', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '設計', false),
  ('demo_seed_5', 'demo5@example.com', '伊藤 翔太', '神奈川県', '横浜市', '東京都', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_6', 'demo6@example.com', '渡辺 隆', '神奈川県', '横浜市', '東京都', '', '公務', '教員', false),
  ('demo_seed_7', 'demo7@example.com', '中村 浩二', '神奈川県', '横浜市', '宮城県', '', '医療・福祉', '医師', false),
  ('demo_seed_8', 'demo8@example.com', '小林 直樹', '神奈川県', '横浜市', '福岡県', '', 'IT・通信', 'コンサルタント', false),
  ('demo_seed_9', 'demo9@example.com', '加藤 雄一', '神奈川県', '横浜市', '北海道', '', '教育', '塾講師', false),
  ('demo_seed_10', 'demo10@example.com', '吉田 誠一', '神奈川県', '横浜市', '愛知県', '', '運輸・物流', '営業', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

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

-- 4. 中央大学附属高校 1992年卒 10人（別の10人）
-- 居住地: 3人=関東、2人=関西、2人=海外、3人=別の都道府県（current_cityは空・都道府県のみ。海外はcurrent_cityに国名）
INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_11', 'demo11@example.com', '田中 一郎', '東京都', '小金井市', '東京都', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_12', 'demo12@example.com', '松本 聡', '千葉県', '船橋市', '神奈川県', '', '製造業', '営業', false),
  ('demo_seed_13', 'demo13@example.com', '井上 拓也', '埼玉県', 'さいたま市', '千葉県', '', '金融・保険', 'アナリスト', false),
  ('demo_seed_14', 'demo14@example.com', '木村 剛', '神奈川県', '横浜市', '大阪府', '', '建設・不動産', '設計', false),
  ('demo_seed_15', 'demo15@example.com', '林 健太', '東京都', '国分寺市', '京都府', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_16', 'demo16@example.com', '斎藤 裕也', '千葉県', '松戸市', '海外', 'シンガポール', '公務', '教員', false),
  ('demo_seed_17', 'demo17@example.com', '山口 慎一', '埼玉県', '川口市', '海外', 'イギリス', '医療・福祉', '医師', false),
  ('demo_seed_18', 'demo18@example.com', '森 達也', '神奈川県', '藤沢市', '福岡県', '', 'IT・通信', 'コンサルタント', false),
  ('demo_seed_19', 'demo19@example.com', '阿部 誠', '東京都', '八王子市', '愛知県', '', '教育', '塾講師', false),
  ('demo_seed_20', 'demo20@example.com', '石井 博之', '千葉県', '柏市', '北海道', '', '運輸・物流', '営業', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

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

-- ============================================
-- 5. 奈良中学校 追加10人（別の卒業年・同じ業種/職種 or 別業種・職種で同じ都道府県）
-- ============================================
-- 同じ業種・職種（エンジニア）: 4人（1990, 1991, 1992, 1993年卒）
-- 別の業種・職種で同じ居住地（神奈川県）: 6人（1994〜1999年卒）
INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_21', 'demo21@example.com', '西村 和也', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_22', 'demo22@example.com', '岡田 聡一', '神奈川県', '横浜市', '東京都', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_23', 'demo23@example.com', '前田 大輝', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_24', 'demo24@example.com', '後藤 陽子', '神奈川県', '横浜市', '千葉県', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_25', 'demo25@example.com', '長谷川 美咲', '神奈川県', '横浜市', '神奈川県', '', '製造業', '営業', false),
  ('demo_seed_26', 'demo26@example.com', '村上 健', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', '事務', false),
  ('demo_seed_27', 'demo27@example.com', '石川 真由美', '神奈川県', '横浜市', '神奈川県', '', '医療・福祉', '医療従事者', false),
  ('demo_seed_28', 'demo28@example.com', '藤田 裕介', '神奈川県', '横浜市', '神奈川県', '', '教育', '教員', false),
  ('demo_seed_29', 'demo29@example.com', '岡本 香織', '神奈川県', '横浜市', '神奈川県', '', '公務', '公務員', false),
  ('demo_seed_30', 'demo30@example.com', '坂本 聡太', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', 'デザイナー', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1990, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_21' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1991, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_22' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_23' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1993, ARRAY['帰宅部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_24' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1994, ARRAY['バスケットボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_25' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1995, ARRAY['陸上部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_26' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1996, ARRAY['テニス部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_27' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1997, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_28' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1998, ARRAY['合唱部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_29' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1999, ARRAY['剣道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_30' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;

-- ============================================
-- 6. 中央大学附属高校 追加10人（別の卒業年・同じ業種/職種 or 別業種・職種で同じ都道府県）
-- ============================================
-- 同じ業種・職種（営業）: 4人（1995, 1996, 1997, 1998年卒）
-- 別の業種・職種で同じ居住地（東京都）: 6人（1999〜2004年卒）
INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_31', 'demo31@example.com', '清水 拓海', '東京都', '小金井市', '東京都', '', '製造業', '営業', false),
  ('demo_seed_32', 'demo32@example.com', '松浦 恵', '千葉県', '船橋市', '東京都', '', '製造業', '営業', false),
  ('demo_seed_33', 'demo33@example.com', '三浦 翔平', '埼玉県', 'さいたま市', '神奈川県', '', '製造業', '営業', false),
  ('demo_seed_34', 'demo34@example.com', '大野 彩', '神奈川県', '横浜市', '東京都', '', '製造業', '営業', false),
  ('demo_seed_35', 'demo35@example.com', '小島 竜也', '東京都', '国分寺市', '東京都', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_36', 'demo36@example.com', '新井 美穂', '千葉県', '松戸市', '東京都', '', '金融・保険', '企画', false),
  ('demo_seed_37', 'demo37@example.com', '内田 剛志', '埼玉県', '川口市', '東京都', '', '建設・不動産', '経理・財務', false),
  ('demo_seed_38', 'demo38@example.com', '原 優花', '神奈川県', '藤沢市', '東京都', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_39', 'demo39@example.com', '松田 慎一', '東京都', '八王子市', '東京都', '', 'サービス', '人事', false),
  ('demo_seed_40', 'demo40@example.com', '池田 麻衣', '千葉県', '柏市', '東京都', '', 'メディア・広告', 'デザイナー', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1995, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_31' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1996, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_32' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1997, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_33' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1998, ARRAY['バレーボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_34' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1999, ARRAY['吹奏楽部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_35' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 2000, ARRAY['陸上部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_36' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 2001, ARRAY['テニス部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_37' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 2002, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_38' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 2003, ARRAY['剣道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_39' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 2004, ARRAY['柔道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_40' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
