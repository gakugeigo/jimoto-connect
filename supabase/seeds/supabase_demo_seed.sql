-- ============================================
-- Supabase デモシード（740人版）
-- ============================================
-- 奈良中学校 1989年卒 240人（共学）
-- 中央大学附属高校 1992年卒 500人（男子校）
-- 使い方: Supabase ダッシュボード > SQL Editor で実行
-- ============================================

INSERT INTO public.schools (name, type, prefecture, city)
SELECT '奈良中学校', 'junior_high', '神奈川県', '横浜市'
WHERE NOT EXISTS (SELECT 1 FROM public.schools WHERE name = '奈良中学校' AND type = 'junior_high');

INSERT INTO public.schools (name, type, prefecture, city)
SELECT '中央大学附属高校', 'high', '東京都', '小金井市'
WHERE NOT EXISTS (SELECT 1 FROM public.schools WHERE name = '中央大学附属高校' AND type = 'high');

DELETE FROM public.profile_schools WHERE profile_id IN (SELECT id FROM public.profiles WHERE clerk_user_id LIKE 'demo_seed_%');
DELETE FROM public.profiles WHERE clerk_user_id LIKE 'demo_seed_%';

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_1', 'demo1@example.com', '山田 太郎', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', 'エンジニア', true),
  ('demo_seed_2', 'demo2@example.com', '佐藤 陽子', '神奈川県', '横浜市', '東京都', '', '製造業', '営業', false),
  ('demo_seed_3', 'demo3@example.com', '鈴木 健一', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', 'マーケティング', false),
  ('demo_seed_4', 'demo4@example.com', '高橋 美咲', '神奈川県', '横浜市', '東京都', '', '小売・卸売', 'デザイナー', false),
  ('demo_seed_5', 'demo5@example.com', '伊藤 大輔', '神奈川県', '横浜市', '東京都', '', 'サービス', '企画', false),
  ('demo_seed_6', 'demo6@example.com', '渡辺 真由美', '神奈川県', '横浜市', '兵庫県', '', '建設・不動産', '経理・財務', true),
  ('demo_seed_7', 'demo7@example.com', '中村 誠', '神奈川県', '横浜市', '茨城県', '', '医療・福祉', '人事', false),
  ('demo_seed_8', 'demo8@example.com', '小林 香織', '神奈川県', '横浜市', '埼玉県', '', '教育', '事務', false),
  ('demo_seed_9', 'demo9@example.com', '加藤 翔太', '神奈川県', '横浜市', '新潟県', '', '公務', '医療従事者', false),
  ('demo_seed_10', 'demo10@example.com', '吉田 恵', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', '教員', false),
  ('demo_seed_11', 'demo11@example.com', '田中 隆', '神奈川県', '横浜市', '埼玉県', '', 'IT・通信', '公務員', true),
  ('demo_seed_12', 'demo12@example.com', '松本 彩', '神奈川県', '横浜市', '福岡県', '', '製造業', 'エンジニア', false),
  ('demo_seed_13', 'demo13@example.com', '井上 浩二', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', '営業', false),
  ('demo_seed_14', 'demo14@example.com', '木村 美穂', '神奈川県', '横浜市', '東京都', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_15', 'demo15@example.com', '林 直樹', '神奈川県', '横浜市', '東京都', '', 'サービス', 'デザイナー', false),
  ('demo_seed_16', 'demo16@example.com', '斎藤 優花', '神奈川県', '横浜市', '千葉県', '', '建設・不動産', '企画', true),
  ('demo_seed_17', 'demo17@example.com', '山口 雄一', '神奈川県', '横浜市', '神奈川県', '', '医療・福祉', '経理・財務', false),
  ('demo_seed_18', 'demo18@example.com', '森 麻衣', '神奈川県', '横浜市', '埼玉県', '', '教育', '人事', false),
  ('demo_seed_19', 'demo19@example.com', '阿部 誠一', '神奈川県', '横浜市', '福岡県', '', '公務', '事務', false),
  ('demo_seed_20', 'demo20@example.com', '石井 陽子', '神奈川県', '横浜市', '茨城県', '', 'メディア・広告', '医療従事者', false),
  ('demo_seed_21', 'demo21@example.com', '西村 和也', '神奈川県', '横浜市', '千葉県', '', 'IT・通信', '教員', true),
  ('demo_seed_22', 'demo22@example.com', '岡田 美咲', '神奈川県', '横浜市', '大阪府', '', '製造業', '公務員', false),
  ('demo_seed_23', 'demo23@example.com', '前田 聡一', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', 'エンジニア', false),
  ('demo_seed_24', 'demo24@example.com', '後藤 真由美', '神奈川県', '横浜市', '埼玉県', '', '小売・卸売', '営業', false),
  ('demo_seed_25', 'demo25@example.com', '長谷川 大輝', '神奈川県', '横浜市', '千葉県', '', 'サービス', 'マーケティング', false),
  ('demo_seed_26', 'demo26@example.com', '村上 香織', '神奈川県', '横浜市', '宮城県', '', '建設・不動産', 'デザイナー', true),
  ('demo_seed_27', 'demo27@example.com', '石川 裕介', '神奈川県', '横浜市', '東京都', '', '医療・福祉', '企画', false),
  ('demo_seed_28', 'demo28@example.com', '藤田 恵', '神奈川県', '横浜市', '京都府', '', '教育', '経理・財務', false),
  ('demo_seed_29', 'demo29@example.com', '岡本 健', '神奈川県', '横浜市', '静岡県', '', '公務', '人事', false),
  ('demo_seed_30', 'demo30@example.com', '坂本 彩', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '事務', false),
  ('demo_seed_31', 'demo31@example.com', '山田 裕也', '神奈川県', '横浜市', '愛知県', '', 'IT・通信', '医療従事者', true),
  ('demo_seed_32', 'demo32@example.com', '佐藤 美穂', '神奈川県', '横浜市', '神奈川県', '', '製造業', '教員', false),
  ('demo_seed_33', 'demo33@example.com', '鈴木 慎一', '神奈川県', '横浜市', '東京都', '', '金融・保険', '公務員', false),
  ('demo_seed_34', 'demo34@example.com', '高橋 優花', '神奈川県', '横浜市', '長野県', '', '小売・卸売', 'エンジニア', false),
  ('demo_seed_35', 'demo35@example.com', '伊藤 達也', '神奈川県', '横浜市', '神奈川県', '', 'サービス', '営業', false),
  ('demo_seed_36', 'demo36@example.com', '渡辺 麻衣', '神奈川県', '横浜市', '岡山県', '', '建設・不動産', 'マーケティング', true),
  ('demo_seed_37', 'demo37@example.com', '中村 拓海', '神奈川県', '横浜市', '東京都', '', '医療・福祉', 'デザイナー', false),
  ('demo_seed_38', 'demo38@example.com', '小林 陽子', '神奈川県', '横浜市', '神奈川県', '', '教育', '企画', false),
  ('demo_seed_39', 'demo39@example.com', '加藤 竜也', '神奈川県', '横浜市', '静岡県', '', '公務', '経理・財務', false),
  ('demo_seed_40', 'demo40@example.com', '吉田 美咲', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '人事', false),
  ('demo_seed_41', 'demo41@example.com', '田中 太郎', '神奈川県', '横浜市', '埼玉県', '', 'IT・通信', '事務', true),
  ('demo_seed_42', 'demo42@example.com', '松本 真由美', '神奈川県', '横浜市', '神奈川県', '', '製造業', '医療従事者', false),
  ('demo_seed_43', 'demo43@example.com', '井上 健一', '神奈川県', '横浜市', '群馬県', '', '金融・保険', '教員', false),
  ('demo_seed_44', 'demo44@example.com', '木村 香織', '神奈川県', '横浜市', '神奈川県', '', '小売・卸売', '公務員', false),
  ('demo_seed_45', 'demo45@example.com', '林 大輔', '神奈川県', '横浜市', '神奈川県', '', 'サービス', 'エンジニア', false),
  ('demo_seed_46', 'demo46@example.com', '斎藤 恵', '神奈川県', '横浜市', '栃木県', '', '建設・不動産', '営業', true),
  ('demo_seed_47', 'demo47@example.com', '山口 誠', '神奈川県', '横浜市', '東京都', '', '医療・福祉', 'マーケティング', false),
  ('demo_seed_48', 'demo48@example.com', '森 彩', '神奈川県', '横浜市', '東京都', '', '教育', 'デザイナー', false),
  ('demo_seed_49', 'demo49@example.com', '阿部 翔太', '神奈川県', '横浜市', '神奈川県', '', '公務', '企画', false),
  ('demo_seed_50', 'demo50@example.com', '石井 美穂', '神奈川県', '横浜市', '北海道', '', 'メディア・広告', '経理・財務', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_51', 'demo51@example.com', '西村 隆', '神奈川県', '横浜市', '埼玉県', '', 'IT・通信', '人事', true),
  ('demo_seed_52', 'demo52@example.com', '岡田 優花', '神奈川県', '横浜市', '神奈川県', '', '製造業', '事務', false),
  ('demo_seed_53', 'demo53@example.com', '前田 浩二', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', '医療従事者', false),
  ('demo_seed_54', 'demo54@example.com', '後藤 麻衣', '神奈川県', '横浜市', '埼玉県', '', '小売・卸売', '教員', false),
  ('demo_seed_55', 'demo55@example.com', '長谷川 直樹', '神奈川県', '横浜市', '神奈川県', '', 'サービス', '公務員', false),
  ('demo_seed_56', 'demo56@example.com', '村上 陽子', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', 'エンジニア', true),
  ('demo_seed_57', 'demo57@example.com', '石川 雄一', '神奈川県', '横浜市', '神奈川県', '', '医療・福祉', '営業', false),
  ('demo_seed_58', 'demo58@example.com', '藤田 美咲', '神奈川県', '横浜市', '東京都', '', '教育', 'マーケティング', false),
  ('demo_seed_59', 'demo59@example.com', '岡本 誠一', '神奈川県', '横浜市', '埼玉県', '', '公務', 'デザイナー', false),
  ('demo_seed_60', 'demo60@example.com', '坂本 真由美', '神奈川県', '横浜市', '愛知県', '', 'メディア・広告', '企画', false),
  ('demo_seed_61', 'demo61@example.com', '山田 和也', '神奈川県', '横浜市', '千葉県', '', 'IT・通信', '経理・財務', true),
  ('demo_seed_62', 'demo62@example.com', '佐藤 香織', '神奈川県', '横浜市', '福岡県', '', '製造業', '人事', false),
  ('demo_seed_63', 'demo63@example.com', '鈴木 聡一', '神奈川県', '横浜市', '東京都', '', '金融・保険', '事務', false),
  ('demo_seed_64', 'demo64@example.com', '高橋 恵', '神奈川県', '横浜市', '静岡県', '', '小売・卸売', '医療従事者', false),
  ('demo_seed_65', 'demo65@example.com', '伊藤 大輝', '神奈川県', '横浜市', '神奈川県', '', 'サービス', '教員', false),
  ('demo_seed_66', 'demo66@example.com', '渡辺 彩', '神奈川県', '横浜市', '千葉県', '', '建設・不動産', '公務員', true),
  ('demo_seed_67', 'demo67@example.com', '中村 裕介', '神奈川県', '横浜市', '広島県', '', '医療・福祉', 'エンジニア', false),
  ('demo_seed_68', 'demo68@example.com', '小林 美穂', '神奈川県', '横浜市', '東京都', '', '教育', '営業', false),
  ('demo_seed_69', 'demo69@example.com', '加藤 健', '神奈川県', '横浜市', '東京都', '', '公務', 'マーケティング', false),
  ('demo_seed_70', 'demo70@example.com', '吉田 優花', '神奈川県', '横浜市', '千葉県', '', 'メディア・広告', 'デザイナー', false),
  ('demo_seed_71', 'demo71@example.com', '田中 裕也', '神奈川県', '横浜市', '千葉県', '', 'IT・通信', '企画', true),
  ('demo_seed_72', 'demo72@example.com', '松本 麻衣', '神奈川県', '横浜市', '神奈川県', '', '製造業', '経理・財務', false),
  ('demo_seed_73', 'demo73@example.com', '井上 慎一', '神奈川県', '横浜市', '東京都', '', '金融・保険', '人事', false),
  ('demo_seed_74', 'demo74@example.com', '木村 陽子', '神奈川県', '横浜市', '愛知県', '', '小売・卸売', '事務', false),
  ('demo_seed_75', 'demo75@example.com', '林 達也', '神奈川県', '横浜市', '東京都', '', 'サービス', '医療従事者', false),
  ('demo_seed_76', 'demo76@example.com', '斎藤 美咲', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '教員', true),
  ('demo_seed_77', 'demo77@example.com', '山口 拓海', '神奈川県', '横浜市', '神奈川県', '', '医療・福祉', '公務員', false),
  ('demo_seed_78', 'demo78@example.com', '森 真由美', '神奈川県', '横浜市', '東京都', '', '教育', 'エンジニア', false),
  ('demo_seed_79', 'demo79@example.com', '阿部 竜也', '神奈川県', '横浜市', '京都府', '', '公務', '営業', false),
  ('demo_seed_80', 'demo80@example.com', '石井 香織', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', 'マーケティング', false),
  ('demo_seed_81', 'demo81@example.com', '西村 太郎', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', 'デザイナー', true),
  ('demo_seed_82', 'demo82@example.com', '岡田 恵', '神奈川県', '横浜市', '神奈川県', '', '製造業', '企画', false),
  ('demo_seed_83', 'demo83@example.com', '前田 健一', '神奈川県', '横浜市', '群馬県', '', '金融・保険', '経理・財務', false),
  ('demo_seed_84', 'demo84@example.com', '後藤 彩', '神奈川県', '横浜市', '静岡県', '', '小売・卸売', '人事', false),
  ('demo_seed_85', 'demo85@example.com', '長谷川 大輔', '神奈川県', '横浜市', '兵庫県', '', 'サービス', '事務', false),
  ('demo_seed_86', 'demo86@example.com', '村上 美穂', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '医療従事者', true),
  ('demo_seed_87', 'demo87@example.com', '石川 誠', '神奈川県', '横浜市', '愛知県', '', '医療・福祉', '教員', false),
  ('demo_seed_88', 'demo88@example.com', '藤田 優花', '神奈川県', '横浜市', '福岡県', '', '教育', '公務員', false),
  ('demo_seed_89', 'demo89@example.com', '岡本 翔太', '神奈川県', '横浜市', '東京都', '', '公務', 'エンジニア', false),
  ('demo_seed_90', 'demo90@example.com', '坂本 麻衣', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', '営業', false),
  ('demo_seed_91', 'demo91@example.com', '山田 隆', '神奈川県', '横浜市', '茨城県', '', 'IT・通信', 'マーケティング', true),
  ('demo_seed_92', 'demo92@example.com', '佐藤 陽子', '神奈川県', '横浜市', '愛知県', '', '製造業', 'デザイナー', false),
  ('demo_seed_93', 'demo93@example.com', '鈴木 浩二', '神奈川県', '横浜市', '東京都', '', '金融・保険', '企画', false),
  ('demo_seed_94', 'demo94@example.com', '高橋 美咲', '神奈川県', '横浜市', '大阪府', '', '小売・卸売', '経理・財務', false),
  ('demo_seed_95', 'demo95@example.com', '伊藤 直樹', '神奈川県', '横浜市', '東京都', '', 'サービス', '人事', false),
  ('demo_seed_96', 'demo96@example.com', '渡辺 真由美', '神奈川県', '横浜市', '静岡県', '', '建設・不動産', '事務', true),
  ('demo_seed_97', 'demo97@example.com', '中村 雄一', '神奈川県', '横浜市', '岐阜県', '', '医療・福祉', '医療従事者', false),
  ('demo_seed_98', 'demo98@example.com', '小林 香織', '神奈川県', '横浜市', '神奈川県', '', '教育', '教員', false),
  ('demo_seed_99', 'demo99@example.com', '加藤 誠一', '神奈川県', '横浜市', '埼玉県', '', '公務', '公務員', false),
  ('demo_seed_100', 'demo100@example.com', '吉田 恵', '神奈川県', '横浜市', '栃木県', '', 'メディア・広告', 'エンジニア', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_101', 'demo101@example.com', '田中 和也', '神奈川県', '横浜市', '東京都', '', 'IT・通信', '営業', true),
  ('demo_seed_102', 'demo102@example.com', '松本 彩', '神奈川県', '横浜市', '神奈川県', '', '製造業', 'マーケティング', false),
  ('demo_seed_103', 'demo103@example.com', '井上 聡一', '神奈川県', '横浜市', '新潟県', '', '金融・保険', 'デザイナー', false),
  ('demo_seed_104', 'demo104@example.com', '木村 美穂', '神奈川県', '横浜市', '大阪府', '', '小売・卸売', '企画', false),
  ('demo_seed_105', 'demo105@example.com', '林 大輝', '神奈川県', '横浜市', '東京都', '', 'サービス', '経理・財務', false),
  ('demo_seed_106', 'demo106@example.com', '斎藤 優花', '神奈川県', '横浜市', '埼玉県', '', '建設・不動産', '人事', true),
  ('demo_seed_107', 'demo107@example.com', '山口 裕介', '神奈川県', '横浜市', '兵庫県', '', '医療・福祉', '事務', false),
  ('demo_seed_108', 'demo108@example.com', '森 麻衣', '神奈川県', '横浜市', '埼玉県', '', '教育', '医療従事者', false),
  ('demo_seed_109', 'demo109@example.com', '阿部 健', '神奈川県', '横浜市', '愛知県', '', '公務', '教員', false),
  ('demo_seed_110', 'demo110@example.com', '石井 陽子', '神奈川県', '横浜市', '千葉県', '', 'メディア・広告', '公務員', false),
  ('demo_seed_111', 'demo111@example.com', '西村 裕也', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', 'エンジニア', true),
  ('demo_seed_112', 'demo112@example.com', '岡田 美咲', '神奈川県', '横浜市', '千葉県', '', '製造業', '営業', false),
  ('demo_seed_113', 'demo113@example.com', '前田 慎一', '神奈川県', '横浜市', '東京都', '', '金融・保険', 'マーケティング', false),
  ('demo_seed_114', 'demo114@example.com', '後藤 真由美', '神奈川県', '横浜市', '群馬県', '', '小売・卸売', 'デザイナー', false),
  ('demo_seed_115', 'demo115@example.com', '長谷川 達也', '神奈川県', '横浜市', '北海道', '', 'サービス', '企画', false),
  ('demo_seed_116', 'demo116@example.com', '村上 香織', '神奈川県', '横浜市', '大阪府', '', '建設・不動産', '経理・財務', true),
  ('demo_seed_117', 'demo117@example.com', '石川 拓海', '神奈川県', '横浜市', '埼玉県', '', '医療・福祉', '人事', false),
  ('demo_seed_118', 'demo118@example.com', '藤田 恵', '神奈川県', '横浜市', '神奈川県', '', '教育', '事務', false),
  ('demo_seed_119', 'demo119@example.com', '岡本 竜也', '神奈川県', '横浜市', '大阪府', '', '公務', '医療従事者', false),
  ('demo_seed_120', 'demo120@example.com', '坂本 彩', '神奈川県', '横浜市', '岡山県', '', 'メディア・広告', '教員', false),
  ('demo_seed_121', 'demo121@example.com', '山田 太郎', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', '公務員', true),
  ('demo_seed_122', 'demo122@example.com', '佐藤 美穂', '神奈川県', '横浜市', '神奈川県', '', '製造業', 'エンジニア', false),
  ('demo_seed_123', 'demo123@example.com', '鈴木 健一', '神奈川県', '横浜市', '埼玉県', '', '金融・保険', '営業', false),
  ('demo_seed_124', 'demo124@example.com', '高橋 優花', '神奈川県', '横浜市', '茨城県', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_125', 'demo125@example.com', '伊藤 大輔', '神奈川県', '横浜市', '埼玉県', '', 'サービス', 'デザイナー', false),
  ('demo_seed_126', 'demo126@example.com', '渡辺 麻衣', '神奈川県', '横浜市', '大阪府', '', '建設・不動産', '企画', true),
  ('demo_seed_127', 'demo127@example.com', '中村 誠', '神奈川県', '横浜市', '東京都', '', '医療・福祉', '経理・財務', false),
  ('demo_seed_128', 'demo128@example.com', '小林 陽子', '神奈川県', '横浜市', '埼玉県', '', '教育', '人事', false),
  ('demo_seed_129', 'demo129@example.com', '加藤 翔太', '神奈川県', '横浜市', '神奈川県', '', '公務', '事務', false),
  ('demo_seed_130', 'demo130@example.com', '吉田 美咲', '神奈川県', '横浜市', '長野県', '', 'メディア・広告', '医療従事者', false),
  ('demo_seed_131', 'demo131@example.com', '田中 隆', '神奈川県', '横浜市', '福岡県', '', 'IT・通信', '教員', true),
  ('demo_seed_132', 'demo132@example.com', '松本 真由美', '神奈川県', '横浜市', '神奈川県', '', '製造業', '公務員', false),
  ('demo_seed_133', 'demo133@example.com', '井上 浩二', '神奈川県', '横浜市', '北海道', '', '金融・保険', 'エンジニア', false),
  ('demo_seed_134', 'demo134@example.com', '木村 香織', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '営業', false),
  ('demo_seed_135', 'demo135@example.com', '林 直樹', '神奈川県', '横浜市', '埼玉県', '', 'サービス', 'マーケティング', false),
  ('demo_seed_136', 'demo136@example.com', '斎藤 恵', '神奈川県', '横浜市', '栃木県', '', '建設・不動産', 'デザイナー', true),
  ('demo_seed_137', 'demo137@example.com', '山口 雄一', '神奈川県', '横浜市', '栃木県', '', '医療・福祉', '企画', false),
  ('demo_seed_138', 'demo138@example.com', '森 彩', '神奈川県', '横浜市', '神奈川県', '', '教育', '経理・財務', false),
  ('demo_seed_139', 'demo139@example.com', '阿部 誠一', '神奈川県', '横浜市', '神奈川県', '', '公務', '人事', false),
  ('demo_seed_140', 'demo140@example.com', '石井 美穂', '神奈川県', '横浜市', '愛知県', '', 'メディア・広告', '事務', false),
  ('demo_seed_141', 'demo141@example.com', '西村 和也', '神奈川県', '横浜市', '東京都', '', 'IT・通信', '医療従事者', true),
  ('demo_seed_142', 'demo142@example.com', '岡田 優花', '神奈川県', '横浜市', '東京都', '', '製造業', '教員', false),
  ('demo_seed_143', 'demo143@example.com', '前田 聡一', '神奈川県', '横浜市', '広島県', '', '金融・保険', '公務員', false),
  ('demo_seed_144', 'demo144@example.com', '後藤 麻衣', '神奈川県', '横浜市', '大阪府', '', '小売・卸売', 'エンジニア', false),
  ('demo_seed_145', 'demo145@example.com', '長谷川 大輝', '神奈川県', '横浜市', '神奈川県', '', 'サービス', '営業', false),
  ('demo_seed_146', 'demo146@example.com', '村上 陽子', '神奈川県', '横浜市', '東京都', '', '建設・不動産', 'マーケティング', true),
  ('demo_seed_147', 'demo147@example.com', '石川 裕介', '神奈川県', '横浜市', '茨城県', '', '医療・福祉', 'デザイナー', false),
  ('demo_seed_148', 'demo148@example.com', '藤田 美咲', '神奈川県', '横浜市', '千葉県', '', '教育', '企画', false),
  ('demo_seed_149', 'demo149@example.com', '岡本 健', '神奈川県', '横浜市', '神奈川県', '', '公務', '経理・財務', false),
  ('demo_seed_150', 'demo150@example.com', '坂本 真由美', '神奈川県', '横浜市', '愛知県', '', 'メディア・広告', '人事', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_151', 'demo151@example.com', '山田 裕也', '神奈川県', '横浜市', '東京都', '', 'IT・通信', '事務', true),
  ('demo_seed_152', 'demo152@example.com', '佐藤 香織', '神奈川県', '横浜市', '大阪府', '', '製造業', '医療従事者', false),
  ('demo_seed_153', 'demo153@example.com', '鈴木 慎一', '神奈川県', '横浜市', '岐阜県', '', '金融・保険', '教員', false),
  ('demo_seed_154', 'demo154@example.com', '高橋 恵', '神奈川県', '横浜市', '埼玉県', '', '小売・卸売', '公務員', false),
  ('demo_seed_155', 'demo155@example.com', '伊藤 達也', '神奈川県', '横浜市', '神奈川県', '', 'サービス', 'エンジニア', false),
  ('demo_seed_156', 'demo156@example.com', '渡辺 彩', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '営業', true),
  ('demo_seed_157', 'demo157@example.com', '中村 拓海', '神奈川県', '横浜市', '神奈川県', '', '医療・福祉', 'マーケティング', false),
  ('demo_seed_158', 'demo158@example.com', '小林 美穂', '神奈川県', '横浜市', '神奈川県', '', '教育', 'デザイナー', false),
  ('demo_seed_159', 'demo159@example.com', '加藤 竜也', '神奈川県', '横浜市', '東京都', '', '公務', '企画', false),
  ('demo_seed_160', 'demo160@example.com', '吉田 優花', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '経理・財務', false),
  ('demo_seed_161', 'demo161@example.com', '田中 太郎', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', '人事', true),
  ('demo_seed_162', 'demo162@example.com', '松本 麻衣', '神奈川県', '横浜市', '東京都', '', '製造業', '事務', false),
  ('demo_seed_163', 'demo163@example.com', '井上 健一', '神奈川県', '横浜市', '東京都', '', '金融・保険', '医療従事者', false),
  ('demo_seed_164', 'demo164@example.com', '木村 陽子', '神奈川県', '横浜市', '兵庫県', '', '小売・卸売', '教員', false),
  ('demo_seed_165', 'demo165@example.com', '林 大輔', '神奈川県', '横浜市', '福岡県', '', 'サービス', '公務員', false),
  ('demo_seed_166', 'demo166@example.com', '斎藤 美咲', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', 'エンジニア', true),
  ('demo_seed_167', 'demo167@example.com', '山口 誠', '神奈川県', '横浜市', '宮城県', '', '医療・福祉', '営業', false),
  ('demo_seed_168', 'demo168@example.com', '森 真由美', '神奈川県', '横浜市', '北海道', '', '教育', 'マーケティング', false),
  ('demo_seed_169', 'demo169@example.com', '阿部 翔太', '神奈川県', '横浜市', '東京都', '', '公務', 'デザイナー', false),
  ('demo_seed_170', 'demo170@example.com', '石井 香織', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', '企画', false),
  ('demo_seed_171', 'demo171@example.com', '西村 隆', '神奈川県', '横浜市', '大阪府', '', 'IT・通信', '経理・財務', true),
  ('demo_seed_172', 'demo172@example.com', '岡田 恵', '神奈川県', '横浜市', '北海道', '', '製造業', '人事', false),
  ('demo_seed_173', 'demo173@example.com', '前田 浩二', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', '事務', false),
  ('demo_seed_174', 'demo174@example.com', '後藤 彩', '神奈川県', '横浜市', '神奈川県', '', '小売・卸売', '医療従事者', false),
  ('demo_seed_175', 'demo175@example.com', '長谷川 直樹', '神奈川県', '横浜市', '千葉県', '', 'サービス', '教員', false),
  ('demo_seed_176', 'demo176@example.com', '村上 美穂', '神奈川県', '横浜市', '東京都', '', '建設・不動産', '公務員', true),
  ('demo_seed_177', 'demo177@example.com', '石川 雄一', '神奈川県', '横浜市', '愛知県', '', '医療・福祉', 'エンジニア', false),
  ('demo_seed_178', 'demo178@example.com', '藤田 優花', '神奈川県', '横浜市', '愛知県', '', '教育', '営業', false),
  ('demo_seed_179', 'demo179@example.com', '岡本 誠一', '神奈川県', '横浜市', '東京都', '', '公務', 'マーケティング', false),
  ('demo_seed_180', 'demo180@example.com', '坂本 麻衣', '神奈川県', '横浜市', '千葉県', '', 'メディア・広告', 'デザイナー', false),
  ('demo_seed_181', 'demo181@example.com', '山田 和也', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', '企画', true),
  ('demo_seed_182', 'demo182@example.com', '佐藤 陽子', '神奈川県', '横浜市', '東京都', '', '製造業', '経理・財務', false),
  ('demo_seed_183', 'demo183@example.com', '鈴木 聡一', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', '人事', false),
  ('demo_seed_184', 'demo184@example.com', '高橋 美咲', '神奈川県', '横浜市', '埼玉県', '', '小売・卸売', '事務', false),
  ('demo_seed_185', 'demo185@example.com', '伊藤 大輝', '神奈川県', '横浜市', '東京都', '', 'サービス', '医療従事者', false),
  ('demo_seed_186', 'demo186@example.com', '渡辺 真由美', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '教員', true),
  ('demo_seed_187', 'demo187@example.com', '中村 裕介', '神奈川県', '横浜市', '神奈川県', '', '医療・福祉', '公務員', false),
  ('demo_seed_188', 'demo188@example.com', '小林 香織', '神奈川県', '横浜市', '群馬県', '', '教育', 'エンジニア', false),
  ('demo_seed_189', 'demo189@example.com', '加藤 健', '神奈川県', '横浜市', '東京都', '', '公務', '営業', false),
  ('demo_seed_190', 'demo190@example.com', '吉田 恵', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', 'マーケティング', false),
  ('demo_seed_191', 'demo191@example.com', '田中 裕也', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', 'デザイナー', true),
  ('demo_seed_192', 'demo192@example.com', '松本 彩', '神奈川県', '横浜市', '東京都', '', '製造業', '企画', false),
  ('demo_seed_193', 'demo193@example.com', '井上 慎一', '神奈川県', '横浜市', '宮城県', '', '金融・保険', '経理・財務', false),
  ('demo_seed_194', 'demo194@example.com', '木村 美穂', '神奈川県', '横浜市', '新潟県', '', '小売・卸売', '人事', false),
  ('demo_seed_195', 'demo195@example.com', '林 達也', '神奈川県', '横浜市', '東京都', '', 'サービス', '事務', false),
  ('demo_seed_196', 'demo196@example.com', '斎藤 優花', '神奈川県', '横浜市', '兵庫県', '', '建設・不動産', '医療従事者', true),
  ('demo_seed_197', 'demo197@example.com', '山口 拓海', '神奈川県', '横浜市', '宮城県', '', '医療・福祉', '教員', false),
  ('demo_seed_198', 'demo198@example.com', '森 麻衣', '神奈川県', '横浜市', '神奈川県', '', '教育', '公務員', false),
  ('demo_seed_199', 'demo199@example.com', '阿部 竜也', '神奈川県', '横浜市', '静岡県', '', '公務', 'エンジニア', false),
  ('demo_seed_200', 'demo200@example.com', '石井 陽子', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '営業', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_201', 'demo201@example.com', '西村 太郎', '神奈川県', '横浜市', '広島県', '', 'IT・通信', 'マーケティング', true),
  ('demo_seed_202', 'demo202@example.com', '岡田 美咲', '神奈川県', '横浜市', '北海道', '', '製造業', 'デザイナー', false),
  ('demo_seed_203', 'demo203@example.com', '前田 健一', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', '企画', false),
  ('demo_seed_204', 'demo204@example.com', '後藤 真由美', '神奈川県', '横浜市', '兵庫県', '', '小売・卸売', '経理・財務', false),
  ('demo_seed_205', 'demo205@example.com', '長谷川 大輔', '神奈川県', '横浜市', '神奈川県', '', 'サービス', '人事', false),
  ('demo_seed_206', 'demo206@example.com', '村上 香織', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '事務', true),
  ('demo_seed_207', 'demo207@example.com', '石川 誠', '神奈川県', '横浜市', '千葉県', '', '医療・福祉', '医療従事者', false),
  ('demo_seed_208', 'demo208@example.com', '藤田 恵', '神奈川県', '横浜市', '東京都', '', '教育', '教員', false),
  ('demo_seed_209', 'demo209@example.com', '岡本 翔太', '神奈川県', '横浜市', '神奈川県', '', '公務', '公務員', false),
  ('demo_seed_210', 'demo210@example.com', '坂本 彩', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', 'エンジニア', false),
  ('demo_seed_211', 'demo211@example.com', '山田 隆', '神奈川県', '横浜市', '京都府', '', 'IT・通信', '営業', true),
  ('demo_seed_212', 'demo212@example.com', '佐藤 美穂', '神奈川県', '横浜市', '北海道', '', '製造業', 'マーケティング', false),
  ('demo_seed_213', 'demo213@example.com', '鈴木 浩二', '神奈川県', '横浜市', '愛知県', '', '金融・保険', 'デザイナー', false),
  ('demo_seed_214', 'demo214@example.com', '高橋 優花', '神奈川県', '横浜市', '北海道', '', '小売・卸売', '企画', false),
  ('demo_seed_215', 'demo215@example.com', '伊藤 直樹', '神奈川県', '横浜市', '神奈川県', '', 'サービス', '経理・財務', false),
  ('demo_seed_216', 'demo216@example.com', '渡辺 麻衣', '神奈川県', '横浜市', '千葉県', '', '建設・不動産', '人事', true),
  ('demo_seed_217', 'demo217@example.com', '中村 雄一', '神奈川県', '横浜市', '三重県', '', '医療・福祉', '事務', false),
  ('demo_seed_218', 'demo218@example.com', '小林 陽子', '神奈川県', '横浜市', '千葉県', '', '教育', '医療従事者', false),
  ('demo_seed_219', 'demo219@example.com', '加藤 誠一', '神奈川県', '横浜市', '埼玉県', '', '公務', '教員', false),
  ('demo_seed_220', 'demo220@example.com', '吉田 美咲', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', '公務員', false),
  ('demo_seed_221', 'demo221@example.com', '田中 和也', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', 'エンジニア', true),
  ('demo_seed_222', 'demo222@example.com', '松本 真由美', '神奈川県', '横浜市', '神奈川県', '', '製造業', '営業', false),
  ('demo_seed_223', 'demo223@example.com', '井上 聡一', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', 'マーケティング', false),
  ('demo_seed_224', 'demo224@example.com', '木村 香織', '神奈川県', '横浜市', '神奈川県', '', '小売・卸売', 'デザイナー', false),
  ('demo_seed_225', 'demo225@example.com', '林 大輝', '神奈川県', '横浜市', '東京都', '', 'サービス', '企画', false),
  ('demo_seed_226', 'demo226@example.com', '斎藤 恵', '神奈川県', '横浜市', '千葉県', '', '建設・不動産', '経理・財務', true),
  ('demo_seed_227', 'demo227@example.com', '山口 裕介', '神奈川県', '横浜市', '神奈川県', '', '医療・福祉', '人事', false),
  ('demo_seed_228', 'demo228@example.com', '森 彩', '神奈川県', '横浜市', '千葉県', '', '教育', '事務', false),
  ('demo_seed_229', 'demo229@example.com', '阿部 健', '神奈川県', '横浜市', '三重県', '', '公務', '医療従事者', false),
  ('demo_seed_230', 'demo230@example.com', '石井 美穂', '神奈川県', '横浜市', '大阪府', '', 'メディア・広告', '教員', false),
  ('demo_seed_231', 'demo231@example.com', '西村 裕也', '神奈川県', '横浜市', '神奈川県', '', 'IT・通信', '公務員', true),
  ('demo_seed_232', 'demo232@example.com', '岡田 優花', '神奈川県', '横浜市', '福岡県', '', '製造業', 'エンジニア', false),
  ('demo_seed_233', 'demo233@example.com', '前田 慎一', '神奈川県', '横浜市', '神奈川県', '', '金融・保険', '営業', false),
  ('demo_seed_234', 'demo234@example.com', '後藤 麻衣', '神奈川県', '横浜市', '神奈川県', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_235', 'demo235@example.com', '長谷川 達也', '神奈川県', '横浜市', '神奈川県', '', 'サービス', 'デザイナー', false),
  ('demo_seed_236', 'demo236@example.com', '村上 陽子', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '企画', true),
  ('demo_seed_237', 'demo237@example.com', '石川 拓海', '神奈川県', '横浜市', '福岡県', '', '医療・福祉', '経理・財務', false),
  ('demo_seed_238', 'demo238@example.com', '藤田 美咲', '神奈川県', '横浜市', '神奈川県', '', '教育', '人事', false),
  ('demo_seed_239', 'demo239@example.com', '岡本 竜也', '神奈川県', '横浜市', '神奈川県', '', '公務', '事務', false),
  ('demo_seed_240', 'demo240@example.com', '坂本 真由美', '神奈川県', '横浜市', '愛知県', '', 'メディア・広告', '医療従事者', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_241', 'demo241@example.com', '山田 一郎', '東京都', '小金井市', '静岡県', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_242', 'demo242@example.com', '佐藤 聡', '神奈川県', '横浜市', '東京都', '', '製造業', '営業', true),
  ('demo_seed_243', 'demo243@example.com', '鈴木 拓也', '埼玉県', 'さいたま市', '埼玉県', '', '金融・保険', 'マーケティング', false),
  ('demo_seed_244', 'demo244@example.com', '高橋 剛', '千葉県', '船橋市', '神奈川県', '', '小売・卸売', 'デザイナー', false),
  ('demo_seed_245', 'demo245@example.com', '伊藤 健太', '東京都', '小金井市', '神奈川県', '', 'サービス', '企画', false),
  ('demo_seed_246', 'demo246@example.com', '渡辺 裕也', '神奈川県', '横浜市', '大阪府', '', '建設・不動産', '経理・財務', false),
  ('demo_seed_247', 'demo247@example.com', '中村 慎一', '埼玉県', 'さいたま市', '群馬県', '', '医療・福祉', '人事', true),
  ('demo_seed_248', 'demo248@example.com', '小林 達也', '千葉県', '船橋市', '東京都', '', '教育', '事務', false),
  ('demo_seed_249', 'demo249@example.com', '加藤 誠', '東京都', '小金井市', '宮城県', '', '公務', '医療従事者', false),
  ('demo_seed_250', 'demo250@example.com', '吉田 博之', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '教員', false),
  ('demo_seed_251', 'demo251@example.com', '田中 拓海', '埼玉県', 'さいたま市', '東京都', '', 'IT・通信', '公務員', false),
  ('demo_seed_252', 'demo252@example.com', '松本 竜也', '千葉県', '船橋市', '東京都', '', '製造業', 'エンジニア', true),
  ('demo_seed_253', 'demo253@example.com', '井上 翔平', '東京都', '小金井市', '愛知県', '', '金融・保険', '営業', false),
  ('demo_seed_254', 'demo254@example.com', '木村 剛志', '神奈川県', '横浜市', '東京都', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_255', 'demo255@example.com', '林 雄太', '埼玉県', 'さいたま市', '神奈川県', '', 'サービス', 'デザイナー', false),
  ('demo_seed_256', 'demo256@example.com', '斎藤 直人', '千葉県', '船橋市', '東京都', '', '建設・不動産', '企画', false),
  ('demo_seed_257', 'demo257@example.com', '山口 健一', '東京都', '小金井市', '東京都', '', '医療・福祉', '経理・財務', true),
  ('demo_seed_258', 'demo258@example.com', '森 大輔', '神奈川県', '横浜市', '東京都', '', '教育', '人事', false),
  ('demo_seed_259', 'demo259@example.com', '阿部 誠', '埼玉県', 'さいたま市', '神奈川県', '', '公務', '事務', false),
  ('demo_seed_260', 'demo260@example.com', '石井 翔太', '千葉県', '船橋市', '東京都', '', 'メディア・広告', '医療従事者', false),
  ('demo_seed_261', 'demo261@example.com', '清水 隆', '東京都', '小金井市', '神奈川県', '', 'IT・通信', '教員', false),
  ('demo_seed_262', 'demo262@example.com', '松浦 浩二', '神奈川県', '横浜市', '神奈川県', '', '製造業', '公務員', true),
  ('demo_seed_263', 'demo263@example.com', '三浦 直樹', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', 'エンジニア', false),
  ('demo_seed_264', 'demo264@example.com', '大野 雄一', '千葉県', '船橋市', '千葉県', '', '小売・卸売', '営業', false),
  ('demo_seed_265', 'demo265@example.com', '小島 誠一', '東京都', '小金井市', '埼玉県', '', 'サービス', 'マーケティング', false),
  ('demo_seed_266', 'demo266@example.com', '新井 和也', '神奈川県', '横浜市', '埼玉県', '', '建設・不動産', 'デザイナー', false),
  ('demo_seed_267', 'demo267@example.com', '内田 聡一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', '企画', true),
  ('demo_seed_268', 'demo268@example.com', '原 大輝', '千葉県', '船橋市', '千葉県', '', '教育', '経理・財務', false),
  ('demo_seed_269', 'demo269@example.com', '松田 裕介', '東京都', '小金井市', '福岡県', '', '公務', '人事', false),
  ('demo_seed_270', 'demo270@example.com', '池田 健', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '事務', false),
  ('demo_seed_271', 'demo271@example.com', '山本 一郎', '埼玉県', 'さいたま市', '北海道', '', 'IT・通信', '医療従事者', false),
  ('demo_seed_272', 'demo272@example.com', '斉藤 聡', '千葉県', '船橋市', '兵庫県', '', '製造業', '教員', true),
  ('demo_seed_273', 'demo273@example.com', '遠藤 拓也', '東京都', '小金井市', '兵庫県', '', '金融・保険', '公務員', false),
  ('demo_seed_274', 'demo274@example.com', '青木 剛', '神奈川県', '横浜市', '大阪府', '', '小売・卸売', 'エンジニア', false),
  ('demo_seed_275', 'demo275@example.com', '坂井 健太', '埼玉県', 'さいたま市', '東京都', '', 'サービス', '営業', false),
  ('demo_seed_276', 'demo276@example.com', '武田 裕也', '千葉県', '船橋市', '東京都', '', '建設・不動産', 'マーケティング', false),
  ('demo_seed_277', 'demo277@example.com', '上田 慎一', '東京都', '小金井市', '神奈川県', '', '医療・福祉', 'デザイナー', true),
  ('demo_seed_278', 'demo278@example.com', '金子 達也', '神奈川県', '横浜市', '東京都', '', '教育', '企画', false),
  ('demo_seed_279', 'demo279@example.com', '近藤 誠', '埼玉県', 'さいたま市', '神奈川県', '', '公務', '経理・財務', false),
  ('demo_seed_280', 'demo280@example.com', '福田 博之', '千葉県', '船橋市', '愛知県', '', 'メディア・広告', '人事', false),
  ('demo_seed_281', 'demo281@example.com', '山田 拓海', '東京都', '小金井市', '東京都', '', 'IT・通信', '事務', false),
  ('demo_seed_282', 'demo282@example.com', '佐藤 竜也', '神奈川県', '横浜市', '東京都', '', '製造業', '医療従事者', true),
  ('demo_seed_283', 'demo283@example.com', '鈴木 翔平', '埼玉県', 'さいたま市', '千葉県', '', '金融・保険', '教員', false),
  ('demo_seed_284', 'demo284@example.com', '高橋 剛志', '千葉県', '船橋市', '埼玉県', '', '小売・卸売', '公務員', false),
  ('demo_seed_285', 'demo285@example.com', '伊藤 雄太', '東京都', '小金井市', '東京都', '', 'サービス', 'エンジニア', false),
  ('demo_seed_286', 'demo286@example.com', '渡辺 直人', '神奈川県', '横浜市', '東京都', '', '建設・不動産', '営業', false),
  ('demo_seed_287', 'demo287@example.com', '中村 健一', '埼玉県', 'さいたま市', '大阪府', '', '医療・福祉', 'マーケティング', true),
  ('demo_seed_288', 'demo288@example.com', '小林 大輔', '千葉県', '船橋市', '東京都', '', '教育', 'デザイナー', false),
  ('demo_seed_289', 'demo289@example.com', '加藤 誠', '東京都', '小金井市', '千葉県', '', '公務', '企画', false),
  ('demo_seed_290', 'demo290@example.com', '吉田 翔太', '神奈川県', '横浜市', '埼玉県', '', 'メディア・広告', '経理・財務', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_291', 'demo291@example.com', '田中 隆', '埼玉県', 'さいたま市', '埼玉県', '', 'IT・通信', '人事', false),
  ('demo_seed_292', 'demo292@example.com', '松本 浩二', '千葉県', '船橋市', '愛知県', '', '製造業', '事務', true),
  ('demo_seed_293', 'demo293@example.com', '井上 直樹', '東京都', '小金井市', '大阪府', '', '金融・保険', '医療従事者', false),
  ('demo_seed_294', 'demo294@example.com', '木村 雄一', '神奈川県', '横浜市', '新潟県', '', '小売・卸売', '教員', false),
  ('demo_seed_295', 'demo295@example.com', '林 誠一', '埼玉県', 'さいたま市', '千葉県', '', 'サービス', '公務員', false),
  ('demo_seed_296', 'demo296@example.com', '斎藤 和也', '千葉県', '船橋市', '東京都', '', '建設・不動産', 'エンジニア', false),
  ('demo_seed_297', 'demo297@example.com', '山口 聡一', '東京都', '小金井市', '兵庫県', '', '医療・福祉', '営業', true),
  ('demo_seed_298', 'demo298@example.com', '森 大輝', '神奈川県', '横浜市', '神奈川県', '', '教育', 'マーケティング', false),
  ('demo_seed_299', 'demo299@example.com', '阿部 裕介', '埼玉県', 'さいたま市', '東京都', '', '公務', 'デザイナー', false),
  ('demo_seed_300', 'demo300@example.com', '石井 健', '千葉県', '船橋市', '東京都', '', 'メディア・広告', '企画', false),
  ('demo_seed_301', 'demo301@example.com', '清水 一郎', '東京都', '小金井市', '福岡県', '', 'IT・通信', '経理・財務', false),
  ('demo_seed_302', 'demo302@example.com', '松浦 聡', '神奈川県', '横浜市', '東京都', '', '製造業', '人事', true),
  ('demo_seed_303', 'demo303@example.com', '三浦 拓也', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', '事務', false),
  ('demo_seed_304', 'demo304@example.com', '大野 剛', '千葉県', '船橋市', '宮城県', '', '小売・卸売', '医療従事者', false),
  ('demo_seed_305', 'demo305@example.com', '小島 健太', '東京都', '小金井市', '千葉県', '', 'サービス', '教員', false),
  ('demo_seed_306', 'demo306@example.com', '新井 裕也', '神奈川県', '横浜市', '茨城県', '', '建設・不動産', '公務員', false),
  ('demo_seed_307', 'demo307@example.com', '内田 慎一', '埼玉県', 'さいたま市', '千葉県', '', '医療・福祉', 'エンジニア', true),
  ('demo_seed_308', 'demo308@example.com', '原 達也', '千葉県', '船橋市', '京都府', '', '教育', '営業', false),
  ('demo_seed_309', 'demo309@example.com', '松田 誠', '東京都', '小金井市', '東京都', '', '公務', 'マーケティング', false),
  ('demo_seed_310', 'demo310@example.com', '池田 博之', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', 'デザイナー', false),
  ('demo_seed_311', 'demo311@example.com', '山本 拓海', '埼玉県', 'さいたま市', '神奈川県', '', 'IT・通信', '企画', false),
  ('demo_seed_312', 'demo312@example.com', '斉藤 竜也', '千葉県', '船橋市', '東京都', '', '製造業', '経理・財務', true),
  ('demo_seed_313', 'demo313@example.com', '遠藤 翔平', '東京都', '小金井市', '埼玉県', '', '金融・保険', '人事', false),
  ('demo_seed_314', 'demo314@example.com', '青木 剛志', '神奈川県', '横浜市', '千葉県', '', '小売・卸売', '事務', false),
  ('demo_seed_315', 'demo315@example.com', '坂井 雄太', '埼玉県', 'さいたま市', '埼玉県', '', 'サービス', '医療従事者', false),
  ('demo_seed_316', 'demo316@example.com', '武田 直人', '千葉県', '船橋市', '東京都', '', '建設・不動産', '教員', false),
  ('demo_seed_317', 'demo317@example.com', '上田 健一', '東京都', '小金井市', '東京都', '', '医療・福祉', '公務員', true),
  ('demo_seed_318', 'demo318@example.com', '金子 大輔', '神奈川県', '横浜市', '東京都', '', '教育', 'エンジニア', false),
  ('demo_seed_319', 'demo319@example.com', '近藤 誠', '埼玉県', 'さいたま市', '神奈川県', '', '公務', '営業', false),
  ('demo_seed_320', 'demo320@example.com', '福田 翔太', '千葉県', '船橋市', '東京都', '', 'メディア・広告', 'マーケティング', false),
  ('demo_seed_321', 'demo321@example.com', '山田 隆', '東京都', '小金井市', '愛知県', '', 'IT・通信', 'デザイナー', false),
  ('demo_seed_322', 'demo322@example.com', '佐藤 浩二', '神奈川県', '横浜市', '東京都', '', '製造業', '企画', true),
  ('demo_seed_323', 'demo323@example.com', '鈴木 直樹', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', '経理・財務', false),
  ('demo_seed_324', 'demo324@example.com', '高橋 雄一', '千葉県', '船橋市', '茨城県', '', '小売・卸売', '人事', false),
  ('demo_seed_325', 'demo325@example.com', '伊藤 誠一', '東京都', '小金井市', '大阪府', '', 'サービス', '事務', false),
  ('demo_seed_326', 'demo326@example.com', '渡辺 和也', '神奈川県', '横浜市', '大阪府', '', '建設・不動産', '医療従事者', false),
  ('demo_seed_327', 'demo327@example.com', '中村 聡一', '埼玉県', 'さいたま市', '北海道', '', '医療・福祉', '教員', true),
  ('demo_seed_328', 'demo328@example.com', '小林 大輝', '千葉県', '船橋市', '北海道', '', '教育', '公務員', false),
  ('demo_seed_329', 'demo329@example.com', '加藤 裕介', '東京都', '小金井市', '東京都', '', '公務', 'エンジニア', false),
  ('demo_seed_330', 'demo330@example.com', '吉田 健', '神奈川県', '横浜市', '海外', 'ロンドン', 'メディア・広告', '営業', false),
  ('demo_seed_331', 'demo331@example.com', '田中 一郎', '埼玉県', 'さいたま市', '栃木県', '', 'IT・通信', 'マーケティング', false),
  ('demo_seed_332', 'demo332@example.com', '松本 聡', '千葉県', '船橋市', '海外', '香港', '製造業', 'デザイナー', true),
  ('demo_seed_333', 'demo333@example.com', '井上 拓也', '東京都', '小金井市', '東京都', '', '金融・保険', '企画', false),
  ('demo_seed_334', 'demo334@example.com', '木村 剛', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '経理・財務', false),
  ('demo_seed_335', 'demo335@example.com', '林 健太', '埼玉県', 'さいたま市', '愛知県', '', 'サービス', '人事', false),
  ('demo_seed_336', 'demo336@example.com', '斎藤 裕也', '千葉県', '船橋市', '東京都', '', '建設・不動産', '事務', false),
  ('demo_seed_337', 'demo337@example.com', '山口 慎一', '東京都', '小金井市', '福岡県', '', '医療・福祉', '医療従事者', true),
  ('demo_seed_338', 'demo338@example.com', '森 達也', '神奈川県', '横浜市', '埼玉県', '', '教育', '教員', false),
  ('demo_seed_339', 'demo339@example.com', '阿部 誠', '埼玉県', 'さいたま市', '北海道', '', '公務', '公務員', false),
  ('demo_seed_340', 'demo340@example.com', '石井 博之', '千葉県', '船橋市', '東京都', '', 'メディア・広告', 'エンジニア', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_341', 'demo341@example.com', '清水 拓海', '東京都', '小金井市', '海外', 'シンガポール', 'IT・通信', '営業', false),
  ('demo_seed_342', 'demo342@example.com', '松浦 竜也', '神奈川県', '横浜市', '東京都', '', '製造業', 'マーケティング', true),
  ('demo_seed_343', 'demo343@example.com', '三浦 翔平', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', 'デザイナー', false),
  ('demo_seed_344', 'demo344@example.com', '大野 剛志', '千葉県', '船橋市', '東京都', '', '小売・卸売', '企画', false),
  ('demo_seed_345', 'demo345@example.com', '小島 雄太', '東京都', '小金井市', '埼玉県', '', 'サービス', '経理・財務', false),
  ('demo_seed_346', 'demo346@example.com', '新井 直人', '神奈川県', '横浜市', '東京都', '', '建設・不動産', '人事', false),
  ('demo_seed_347', 'demo347@example.com', '内田 健一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', '事務', true),
  ('demo_seed_348', 'demo348@example.com', '原 大輔', '千葉県', '船橋市', '神奈川県', '', '教育', '医療従事者', false),
  ('demo_seed_349', 'demo349@example.com', '松田 誠', '東京都', '小金井市', '兵庫県', '', '公務', '教員', false),
  ('demo_seed_350', 'demo350@example.com', '池田 翔太', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', '公務員', false),
  ('demo_seed_351', 'demo351@example.com', '山本 隆', '埼玉県', 'さいたま市', '東京都', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_352', 'demo352@example.com', '斉藤 浩二', '千葉県', '船橋市', '神奈川県', '', '製造業', '営業', true),
  ('demo_seed_353', 'demo353@example.com', '遠藤 直樹', '東京都', '小金井市', '愛知県', '', '金融・保険', 'マーケティング', false),
  ('demo_seed_354', 'demo354@example.com', '青木 雄一', '神奈川県', '横浜市', '神奈川県', '', '小売・卸売', 'デザイナー', false),
  ('demo_seed_355', 'demo355@example.com', '坂井 誠一', '埼玉県', 'さいたま市', '東京都', '', 'サービス', '企画', false),
  ('demo_seed_356', 'demo356@example.com', '武田 和也', '千葉県', '船橋市', '東京都', '', '建設・不動産', '経理・財務', false),
  ('demo_seed_357', 'demo357@example.com', '上田 聡一', '東京都', '小金井市', '千葉県', '', '医療・福祉', '人事', true),
  ('demo_seed_358', 'demo358@example.com', '金子 大輝', '神奈川県', '横浜市', '東京都', '', '教育', '事務', false),
  ('demo_seed_359', 'demo359@example.com', '近藤 裕介', '埼玉県', 'さいたま市', '神奈川県', '', '公務', '医療従事者', false),
  ('demo_seed_360', 'demo360@example.com', '福田 健', '千葉県', '船橋市', '埼玉県', '', 'メディア・広告', '教員', false),
  ('demo_seed_361', 'demo361@example.com', '山田 一郎', '東京都', '小金井市', '東京都', '', 'IT・通信', '公務員', false),
  ('demo_seed_362', 'demo362@example.com', '佐藤 聡', '神奈川県', '横浜市', '千葉県', '', '製造業', 'エンジニア', true),
  ('demo_seed_363', 'demo363@example.com', '鈴木 拓也', '埼玉県', 'さいたま市', '神奈川県', '', '金融・保険', '営業', false),
  ('demo_seed_364', 'demo364@example.com', '高橋 剛', '千葉県', '船橋市', '福岡県', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_365', 'demo365@example.com', '伊藤 健太', '東京都', '小金井市', '愛知県', '', 'サービス', 'デザイナー', false),
  ('demo_seed_366', 'demo366@example.com', '渡辺 裕也', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '企画', false),
  ('demo_seed_367', 'demo367@example.com', '中村 慎一', '埼玉県', 'さいたま市', '千葉県', '', '医療・福祉', '経理・財務', true),
  ('demo_seed_368', 'demo368@example.com', '小林 達也', '千葉県', '船橋市', '東京都', '', '教育', '人事', false),
  ('demo_seed_369', 'demo369@example.com', '加藤 誠', '東京都', '小金井市', '東京都', '', '公務', '事務', false),
  ('demo_seed_370', 'demo370@example.com', '吉田 博之', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', '医療従事者', false),
  ('demo_seed_371', 'demo371@example.com', '田中 拓海', '埼玉県', 'さいたま市', '千葉県', '', 'IT・通信', '教員', false),
  ('demo_seed_372', 'demo372@example.com', '松本 竜也', '千葉県', '船橋市', '千葉県', '', '製造業', '公務員', true),
  ('demo_seed_373', 'demo373@example.com', '井上 翔平', '東京都', '小金井市', '神奈川県', '', '金融・保険', 'エンジニア', false),
  ('demo_seed_374', 'demo374@example.com', '木村 剛志', '神奈川県', '横浜市', '埼玉県', '', '小売・卸売', '営業', false),
  ('demo_seed_375', 'demo375@example.com', '林 雄太', '埼玉県', 'さいたま市', '愛知県', '', 'サービス', 'マーケティング', false),
  ('demo_seed_376', 'demo376@example.com', '斎藤 直人', '千葉県', '船橋市', '神奈川県', '', '建設・不動産', 'デザイナー', false),
  ('demo_seed_377', 'demo377@example.com', '山口 健一', '東京都', '小金井市', '大阪府', '', '医療・福祉', '企画', true),
  ('demo_seed_378', 'demo378@example.com', '森 大輔', '神奈川県', '横浜市', '東京都', '', '教育', '経理・財務', false),
  ('demo_seed_379', 'demo379@example.com', '阿部 誠', '埼玉県', 'さいたま市', '福岡県', '', '公務', '人事', false),
  ('demo_seed_380', 'demo380@example.com', '石井 翔太', '千葉県', '船橋市', '千葉県', '', 'メディア・広告', '事務', false),
  ('demo_seed_381', 'demo381@example.com', '清水 隆', '東京都', '小金井市', '東京都', '', 'IT・通信', '医療従事者', false),
  ('demo_seed_382', 'demo382@example.com', '松浦 浩二', '神奈川県', '横浜市', '東京都', '', '製造業', '教員', true),
  ('demo_seed_383', 'demo383@example.com', '三浦 直樹', '埼玉県', 'さいたま市', '神奈川県', '', '金融・保険', '公務員', false),
  ('demo_seed_384', 'demo384@example.com', '大野 雄一', '千葉県', '船橋市', '東京都', '', '小売・卸売', 'エンジニア', false),
  ('demo_seed_385', 'demo385@example.com', '小島 誠一', '東京都', '小金井市', '大阪府', '', 'サービス', '営業', false),
  ('demo_seed_386', 'demo386@example.com', '新井 和也', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', 'マーケティング', false),
  ('demo_seed_387', 'demo387@example.com', '内田 聡一', '埼玉県', 'さいたま市', '愛知県', '', '医療・福祉', 'デザイナー', true),
  ('demo_seed_388', 'demo388@example.com', '原 大輝', '千葉県', '船橋市', '神奈川県', '', '教育', '企画', false),
  ('demo_seed_389', 'demo389@example.com', '松田 裕介', '東京都', '小金井市', '東京都', '', '公務', '経理・財務', false),
  ('demo_seed_390', 'demo390@example.com', '池田 健', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '人事', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_391', 'demo391@example.com', '山本 一郎', '埼玉県', 'さいたま市', '静岡県', '', 'IT・通信', '事務', false),
  ('demo_seed_392', 'demo392@example.com', '斉藤 聡', '千葉県', '船橋市', '東京都', '', '製造業', '医療従事者', true),
  ('demo_seed_393', 'demo393@example.com', '遠藤 拓也', '東京都', '小金井市', '東京都', '', '金融・保険', '教員', false),
  ('demo_seed_394', 'demo394@example.com', '青木 剛', '神奈川県', '横浜市', '大阪府', '', '小売・卸売', '公務員', false),
  ('demo_seed_395', 'demo395@example.com', '坂井 健太', '埼玉県', 'さいたま市', '東京都', '', 'サービス', 'エンジニア', false),
  ('demo_seed_396', 'demo396@example.com', '武田 裕也', '千葉県', '船橋市', '福岡県', '', '建設・不動産', '営業', false),
  ('demo_seed_397', 'demo397@example.com', '上田 慎一', '東京都', '小金井市', '神奈川県', '', '医療・福祉', 'マーケティング', true),
  ('demo_seed_398', 'demo398@example.com', '金子 達也', '神奈川県', '横浜市', '千葉県', '', '教育', 'デザイナー', false),
  ('demo_seed_399', 'demo399@example.com', '近藤 誠', '埼玉県', 'さいたま市', '埼玉県', '', '公務', '企画', false),
  ('demo_seed_400', 'demo400@example.com', '福田 博之', '千葉県', '船橋市', '埼玉県', '', 'メディア・広告', '経理・財務', false),
  ('demo_seed_401', 'demo401@example.com', '山田 拓海', '東京都', '小金井市', '東京都', '', 'IT・通信', '人事', false),
  ('demo_seed_402', 'demo402@example.com', '佐藤 竜也', '神奈川県', '横浜市', '愛知県', '', '製造業', '事務', true),
  ('demo_seed_403', 'demo403@example.com', '鈴木 翔平', '埼玉県', 'さいたま市', '千葉県', '', '金融・保険', '医療従事者', false),
  ('demo_seed_404', 'demo404@example.com', '高橋 剛志', '千葉県', '船橋市', '神奈川県', '', '小売・卸売', '教員', false),
  ('demo_seed_405', 'demo405@example.com', '伊藤 雄太', '東京都', '小金井市', '北海道', '', 'サービス', '公務員', false),
  ('demo_seed_406', 'demo406@example.com', '渡辺 直人', '神奈川県', '横浜市', '大阪府', '', '建設・不動産', 'エンジニア', false),
  ('demo_seed_407', 'demo407@example.com', '中村 健一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', '営業', true),
  ('demo_seed_408', 'demo408@example.com', '小林 大輔', '千葉県', '船橋市', '愛知県', '', '教育', 'マーケティング', false),
  ('demo_seed_409', 'demo409@example.com', '加藤 誠', '東京都', '小金井市', '大阪府', '', '公務', 'デザイナー', false),
  ('demo_seed_410', 'demo410@example.com', '吉田 翔太', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '企画', false),
  ('demo_seed_411', 'demo411@example.com', '田中 隆', '埼玉県', 'さいたま市', '神奈川県', '', 'IT・通信', '経理・財務', false),
  ('demo_seed_412', 'demo412@example.com', '松本 浩二', '千葉県', '船橋市', '東京都', '', '製造業', '人事', true),
  ('demo_seed_413', 'demo413@example.com', '井上 直樹', '東京都', '小金井市', '大阪府', '', '金融・保険', '事務', false),
  ('demo_seed_414', 'demo414@example.com', '木村 雄一', '神奈川県', '横浜市', '千葉県', '', '小売・卸売', '医療従事者', false),
  ('demo_seed_415', 'demo415@example.com', '林 誠一', '埼玉県', 'さいたま市', '東京都', '', 'サービス', '教員', false),
  ('demo_seed_416', 'demo416@example.com', '斎藤 和也', '千葉県', '船橋市', '埼玉県', '', '建設・不動産', '公務員', false),
  ('demo_seed_417', 'demo417@example.com', '山口 聡一', '東京都', '小金井市', '兵庫県', '', '医療・福祉', 'エンジニア', true),
  ('demo_seed_418', 'demo418@example.com', '森 大輝', '神奈川県', '横浜市', '神奈川県', '', '教育', '営業', false),
  ('demo_seed_419', 'demo419@example.com', '阿部 裕介', '埼玉県', 'さいたま市', '千葉県', '', '公務', 'マーケティング', false),
  ('demo_seed_420', 'demo420@example.com', '石井 健', '千葉県', '船橋市', '埼玉県', '', 'メディア・広告', 'デザイナー', false),
  ('demo_seed_421', 'demo421@example.com', '清水 一郎', '東京都', '小金井市', '東京都', '', 'IT・通信', '企画', false),
  ('demo_seed_422', 'demo422@example.com', '松浦 聡', '神奈川県', '横浜市', '千葉県', '', '製造業', '経理・財務', true),
  ('demo_seed_423', 'demo423@example.com', '三浦 拓也', '埼玉県', 'さいたま市', '愛知県', '', '金融・保険', '人事', false),
  ('demo_seed_424', 'demo424@example.com', '大野 剛', '千葉県', '船橋市', '愛知県', '', '小売・卸売', '事務', false),
  ('demo_seed_425', 'demo425@example.com', '小島 健太', '東京都', '小金井市', '東京都', '', 'サービス', '医療従事者', false),
  ('demo_seed_426', 'demo426@example.com', '新井 裕也', '神奈川県', '横浜市', '京都府', '', '建設・不動産', '教員', false),
  ('demo_seed_427', 'demo427@example.com', '内田 慎一', '埼玉県', 'さいたま市', '大阪府', '', '医療・福祉', '公務員', true),
  ('demo_seed_428', 'demo428@example.com', '原 達也', '千葉県', '船橋市', '静岡県', '', '教育', 'エンジニア', false),
  ('demo_seed_429', 'demo429@example.com', '松田 誠', '東京都', '小金井市', '兵庫県', '', '公務', '営業', false),
  ('demo_seed_430', 'demo430@example.com', '池田 博之', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', 'マーケティング', false),
  ('demo_seed_431', 'demo431@example.com', '山本 拓海', '埼玉県', 'さいたま市', '福岡県', '', 'IT・通信', 'デザイナー', false),
  ('demo_seed_432', 'demo432@example.com', '斉藤 竜也', '千葉県', '船橋市', '北海道', '', '製造業', '企画', true),
  ('demo_seed_433', 'demo433@example.com', '遠藤 翔平', '東京都', '小金井市', '福岡県', '', '金融・保険', '経理・財務', false),
  ('demo_seed_434', 'demo434@example.com', '青木 剛志', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '人事', false),
  ('demo_seed_435', 'demo435@example.com', '坂井 雄太', '埼玉県', 'さいたま市', '神奈川県', '', 'サービス', '事務', false),
  ('demo_seed_436', 'demo436@example.com', '武田 直人', '千葉県', '船橋市', '東京都', '', '建設・不動産', '医療従事者', false),
  ('demo_seed_437', 'demo437@example.com', '上田 健一', '東京都', '小金井市', '神奈川県', '', '医療・福祉', '教員', true),
  ('demo_seed_438', 'demo438@example.com', '金子 大輔', '神奈川県', '横浜市', '福岡県', '', '教育', '公務員', false),
  ('demo_seed_439', 'demo439@example.com', '近藤 誠', '埼玉県', 'さいたま市', '静岡県', '', '公務', 'エンジニア', false),
  ('demo_seed_440', 'demo440@example.com', '福田 翔太', '千葉県', '船橋市', '東京都', '', 'メディア・広告', '営業', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_441', 'demo441@example.com', '山田 隆', '東京都', '小金井市', '宮城県', '', 'IT・通信', 'マーケティング', false),
  ('demo_seed_442', 'demo442@example.com', '佐藤 浩二', '神奈川県', '横浜市', '宮城県', '', '製造業', 'デザイナー', true),
  ('demo_seed_443', 'demo443@example.com', '鈴木 直樹', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', '企画', false),
  ('demo_seed_444', 'demo444@example.com', '高橋 雄一', '千葉県', '船橋市', '神奈川県', '', '小売・卸売', '経理・財務', false),
  ('demo_seed_445', 'demo445@example.com', '伊藤 誠一', '東京都', '小金井市', '千葉県', '', 'サービス', '人事', false),
  ('demo_seed_446', 'demo446@example.com', '渡辺 和也', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '事務', false),
  ('demo_seed_447', 'demo447@example.com', '中村 聡一', '埼玉県', 'さいたま市', '千葉県', '', '医療・福祉', '医療従事者', true),
  ('demo_seed_448', 'demo448@example.com', '小林 大輝', '千葉県', '船橋市', '神奈川県', '', '教育', '教員', false),
  ('demo_seed_449', 'demo449@example.com', '加藤 裕介', '東京都', '小金井市', '愛知県', '', '公務', '公務員', false),
  ('demo_seed_450', 'demo450@example.com', '吉田 健', '神奈川県', '横浜市', '愛知県', '', 'メディア・広告', 'エンジニア', false),
  ('demo_seed_451', 'demo451@example.com', '田中 一郎', '埼玉県', 'さいたま市', '東京都', '', 'IT・通信', '営業', false),
  ('demo_seed_452', 'demo452@example.com', '松本 聡', '千葉県', '船橋市', '兵庫県', '', '製造業', 'マーケティング', true),
  ('demo_seed_453', 'demo453@example.com', '井上 拓也', '東京都', '小金井市', '埼玉県', '', '金融・保険', 'デザイナー', false),
  ('demo_seed_454', 'demo454@example.com', '木村 剛', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '企画', false),
  ('demo_seed_455', 'demo455@example.com', '林 健太', '埼玉県', 'さいたま市', '兵庫県', '', 'サービス', '経理・財務', false),
  ('demo_seed_456', 'demo456@example.com', '斎藤 裕也', '千葉県', '船橋市', '沖縄県', '', '建設・不動産', '人事', false),
  ('demo_seed_457', 'demo457@example.com', '山口 慎一', '東京都', '小金井市', '東京都', '', '医療・福祉', '事務', true),
  ('demo_seed_458', 'demo458@example.com', '森 達也', '神奈川県', '横浜市', '茨城県', '', '教育', '医療従事者', false),
  ('demo_seed_459', 'demo459@example.com', '阿部 誠', '埼玉県', 'さいたま市', '福岡県', '', '公務', '教員', false),
  ('demo_seed_460', 'demo460@example.com', '石井 博之', '千葉県', '船橋市', '海外', '香港', 'メディア・広告', '公務員', false),
  ('demo_seed_461', 'demo461@example.com', '清水 拓海', '東京都', '小金井市', '東京都', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_462', 'demo462@example.com', '松浦 竜也', '神奈川県', '横浜市', '千葉県', '', '製造業', '営業', true),
  ('demo_seed_463', 'demo463@example.com', '三浦 翔平', '埼玉県', 'さいたま市', '大阪府', '', '金融・保険', 'マーケティング', false),
  ('demo_seed_464', 'demo464@example.com', '大野 剛志', '千葉県', '船橋市', '神奈川県', '', '小売・卸売', 'デザイナー', false),
  ('demo_seed_465', 'demo465@example.com', '小島 雄太', '東京都', '小金井市', '埼玉県', '', 'サービス', '企画', false),
  ('demo_seed_466', 'demo466@example.com', '新井 直人', '神奈川県', '横浜市', '東京都', '', '建設・不動産', '経理・財務', false),
  ('demo_seed_467', 'demo467@example.com', '内田 健一', '埼玉県', 'さいたま市', '兵庫県', '', '医療・福祉', '人事', true),
  ('demo_seed_468', 'demo468@example.com', '原 大輔', '千葉県', '船橋市', '東京都', '', '教育', '事務', false),
  ('demo_seed_469', 'demo469@example.com', '松田 誠', '東京都', '小金井市', '栃木県', '', '公務', '医療従事者', false),
  ('demo_seed_470', 'demo470@example.com', '池田 翔太', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '教員', false),
  ('demo_seed_471', 'demo471@example.com', '山本 隆', '埼玉県', 'さいたま市', '大阪府', '', 'IT・通信', '公務員', false),
  ('demo_seed_472', 'demo472@example.com', '斉藤 浩二', '千葉県', '船橋市', '東京都', '', '製造業', 'エンジニア', true),
  ('demo_seed_473', 'demo473@example.com', '遠藤 直樹', '東京都', '小金井市', '東京都', '', '金融・保険', '営業', false),
  ('demo_seed_474', 'demo474@example.com', '青木 雄一', '神奈川県', '横浜市', '千葉県', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_475', 'demo475@example.com', '坂井 誠一', '埼玉県', 'さいたま市', '大阪府', '', 'サービス', 'デザイナー', false),
  ('demo_seed_476', 'demo476@example.com', '武田 和也', '千葉県', '船橋市', '福岡県', '', '建設・不動産', '企画', false),
  ('demo_seed_477', 'demo477@example.com', '上田 聡一', '東京都', '小金井市', '新潟県', '', '医療・福祉', '経理・財務', true),
  ('demo_seed_478', 'demo478@example.com', '金子 大輝', '神奈川県', '横浜市', '埼玉県', '', '教育', '人事', false),
  ('demo_seed_479', 'demo479@example.com', '近藤 裕介', '埼玉県', 'さいたま市', '東京都', '', '公務', '事務', false),
  ('demo_seed_480', 'demo480@example.com', '福田 健', '千葉県', '船橋市', '神奈川県', '', 'メディア・広告', '医療従事者', false),
  ('demo_seed_481', 'demo481@example.com', '山田 一郎', '東京都', '小金井市', '広島県', '', 'IT・通信', '教員', false),
  ('demo_seed_482', 'demo482@example.com', '佐藤 聡', '神奈川県', '横浜市', '埼玉県', '', '製造業', '公務員', true),
  ('demo_seed_483', 'demo483@example.com', '鈴木 拓也', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', 'エンジニア', false),
  ('demo_seed_484', 'demo484@example.com', '高橋 剛', '千葉県', '船橋市', '東京都', '', '小売・卸売', '営業', false),
  ('demo_seed_485', 'demo485@example.com', '伊藤 健太', '東京都', '小金井市', '東京都', '', 'サービス', 'マーケティング', false),
  ('demo_seed_486', 'demo486@example.com', '渡辺 裕也', '神奈川県', '横浜市', '千葉県', '', '建設・不動産', 'デザイナー', false),
  ('demo_seed_487', 'demo487@example.com', '中村 慎一', '埼玉県', 'さいたま市', '神奈川県', '', '医療・福祉', '企画', true),
  ('demo_seed_488', 'demo488@example.com', '小林 達也', '千葉県', '船橋市', '埼玉県', '', '教育', '経理・財務', false),
  ('demo_seed_489', 'demo489@example.com', '加藤 誠', '東京都', '小金井市', '東京都', '', '公務', '人事', false),
  ('demo_seed_490', 'demo490@example.com', '吉田 博之', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', '事務', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_491', 'demo491@example.com', '田中 拓海', '埼玉県', 'さいたま市', '茨城県', '', 'IT・通信', '医療従事者', false),
  ('demo_seed_492', 'demo492@example.com', '松本 竜也', '千葉県', '船橋市', '北海道', '', '製造業', '教員', true),
  ('demo_seed_493', 'demo493@example.com', '井上 翔平', '東京都', '小金井市', '埼玉県', '', '金融・保険', '公務員', false),
  ('demo_seed_494', 'demo494@example.com', '木村 剛志', '神奈川県', '横浜市', '群馬県', '', '小売・卸売', 'エンジニア', false),
  ('demo_seed_495', 'demo495@example.com', '林 雄太', '埼玉県', 'さいたま市', '東京都', '', 'サービス', '営業', false),
  ('demo_seed_496', 'demo496@example.com', '斎藤 直人', '千葉県', '船橋市', '埼玉県', '', '建設・不動産', 'マーケティング', false),
  ('demo_seed_497', 'demo497@example.com', '山口 健一', '東京都', '小金井市', '東京都', '', '医療・福祉', 'デザイナー', true),
  ('demo_seed_498', 'demo498@example.com', '森 大輔', '神奈川県', '横浜市', '東京都', '', '教育', '企画', false),
  ('demo_seed_499', 'demo499@example.com', '阿部 誠', '埼玉県', 'さいたま市', '東京都', '', '公務', '経理・財務', false),
  ('demo_seed_500', 'demo500@example.com', '石井 翔太', '千葉県', '船橋市', '神奈川県', '', 'メディア・広告', '人事', false),
  ('demo_seed_501', 'demo501@example.com', '清水 隆', '東京都', '小金井市', '神奈川県', '', 'IT・通信', '事務', false),
  ('demo_seed_502', 'demo502@example.com', '松浦 浩二', '神奈川県', '横浜市', '東京都', '', '製造業', '医療従事者', true),
  ('demo_seed_503', 'demo503@example.com', '三浦 直樹', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', '教員', false),
  ('demo_seed_504', 'demo504@example.com', '大野 雄一', '千葉県', '船橋市', '埼玉県', '', '小売・卸売', '公務員', false),
  ('demo_seed_505', 'demo505@example.com', '小島 誠一', '東京都', '小金井市', '東京都', '', 'サービス', 'エンジニア', false),
  ('demo_seed_506', 'demo506@example.com', '新井 和也', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '営業', false),
  ('demo_seed_507', 'demo507@example.com', '内田 聡一', '埼玉県', 'さいたま市', '茨城県', '', '医療・福祉', 'マーケティング', true),
  ('demo_seed_508', 'demo508@example.com', '原 大輝', '千葉県', '船橋市', '東京都', '', '教育', 'デザイナー', false),
  ('demo_seed_509', 'demo509@example.com', '松田 裕介', '東京都', '小金井市', '東京都', '', '公務', '企画', false),
  ('demo_seed_510', 'demo510@example.com', '池田 健', '神奈川県', '横浜市', '海外', 'ロンドン', 'メディア・広告', '経理・財務', false),
  ('demo_seed_511', 'demo511@example.com', '山本 一郎', '埼玉県', 'さいたま市', '新潟県', '', 'IT・通信', '人事', false),
  ('demo_seed_512', 'demo512@example.com', '斉藤 聡', '千葉県', '船橋市', '千葉県', '', '製造業', '事務', true),
  ('demo_seed_513', 'demo513@example.com', '遠藤 拓也', '東京都', '小金井市', '東京都', '', '金融・保険', '医療従事者', false),
  ('demo_seed_514', 'demo514@example.com', '青木 剛', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '教員', false),
  ('demo_seed_515', 'demo515@example.com', '坂井 健太', '埼玉県', 'さいたま市', '神奈川県', '', 'サービス', '公務員', false),
  ('demo_seed_516', 'demo516@example.com', '武田 裕也', '千葉県', '船橋市', '東京都', '', '建設・不動産', 'エンジニア', false),
  ('demo_seed_517', 'demo517@example.com', '上田 慎一', '東京都', '小金井市', '東京都', '', '医療・福祉', '営業', true),
  ('demo_seed_518', 'demo518@example.com', '金子 達也', '神奈川県', '横浜市', '京都府', '', '教育', 'マーケティング', false),
  ('demo_seed_519', 'demo519@example.com', '近藤 誠', '埼玉県', 'さいたま市', '千葉県', '', '公務', 'デザイナー', false),
  ('demo_seed_520', 'demo520@example.com', '福田 博之', '千葉県', '船橋市', '静岡県', '', 'メディア・広告', '企画', false),
  ('demo_seed_521', 'demo521@example.com', '山田 拓海', '東京都', '小金井市', '群馬県', '', 'IT・通信', '経理・財務', false),
  ('demo_seed_522', 'demo522@example.com', '佐藤 竜也', '神奈川県', '横浜市', '東京都', '', '製造業', '人事', true),
  ('demo_seed_523', 'demo523@example.com', '鈴木 翔平', '埼玉県', 'さいたま市', '宮城県', '', '金融・保険', '事務', false),
  ('demo_seed_524', 'demo524@example.com', '高橋 剛志', '千葉県', '船橋市', '千葉県', '', '小売・卸売', '医療従事者', false),
  ('demo_seed_525', 'demo525@example.com', '伊藤 雄太', '東京都', '小金井市', '神奈川県', '', 'サービス', '教員', false),
  ('demo_seed_526', 'demo526@example.com', '渡辺 直人', '神奈川県', '横浜市', '愛知県', '', '建設・不動産', '公務員', false),
  ('demo_seed_527', 'demo527@example.com', '中村 健一', '埼玉県', 'さいたま市', '神奈川県', '', '医療・福祉', 'エンジニア', true),
  ('demo_seed_528', 'demo528@example.com', '小林 大輔', '千葉県', '船橋市', '東京都', '', '教育', '営業', false),
  ('demo_seed_529', 'demo529@example.com', '加藤 誠', '東京都', '小金井市', '東京都', '', '公務', 'マーケティング', false),
  ('demo_seed_530', 'demo530@example.com', '吉田 翔太', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', 'デザイナー', false),
  ('demo_seed_531', 'demo531@example.com', '田中 隆', '埼玉県', 'さいたま市', '群馬県', '', 'IT・通信', '企画', false),
  ('demo_seed_532', 'demo532@example.com', '松本 浩二', '千葉県', '船橋市', '東京都', '', '製造業', '経理・財務', true),
  ('demo_seed_533', 'demo533@example.com', '井上 直樹', '東京都', '小金井市', '千葉県', '', '金融・保険', '人事', false),
  ('demo_seed_534', 'demo534@example.com', '木村 雄一', '神奈川県', '横浜市', '愛知県', '', '小売・卸売', '事務', false),
  ('demo_seed_535', 'demo535@example.com', '林 誠一', '埼玉県', 'さいたま市', '東京都', '', 'サービス', '医療従事者', false),
  ('demo_seed_536', 'demo536@example.com', '斎藤 和也', '千葉県', '船橋市', '埼玉県', '', '建設・不動産', '教員', false),
  ('demo_seed_537', 'demo537@example.com', '山口 聡一', '東京都', '小金井市', '東京都', '', '医療・福祉', '公務員', true),
  ('demo_seed_538', 'demo538@example.com', '森 大輝', '神奈川県', '横浜市', '宮城県', '', '教育', 'エンジニア', false),
  ('demo_seed_539', 'demo539@example.com', '阿部 裕介', '埼玉県', 'さいたま市', '東京都', '', '公務', '営業', false),
  ('demo_seed_540', 'demo540@example.com', '石井 健', '千葉県', '船橋市', '京都府', '', 'メディア・広告', 'マーケティング', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_541', 'demo541@example.com', '清水 一郎', '東京都', '小金井市', '埼玉県', '', 'IT・通信', 'デザイナー', false),
  ('demo_seed_542', 'demo542@example.com', '松浦 聡', '神奈川県', '横浜市', '神奈川県', '', '製造業', '企画', true),
  ('demo_seed_543', 'demo543@example.com', '三浦 拓也', '埼玉県', 'さいたま市', '埼玉県', '', '金融・保険', '経理・財務', false),
  ('demo_seed_544', 'demo544@example.com', '大野 剛', '千葉県', '船橋市', '宮城県', '', '小売・卸売', '人事', false),
  ('demo_seed_545', 'demo545@example.com', '小島 健太', '東京都', '小金井市', '東京都', '', 'サービス', '事務', false),
  ('demo_seed_546', 'demo546@example.com', '新井 裕也', '神奈川県', '横浜市', '東京都', '', '建設・不動産', '医療従事者', false),
  ('demo_seed_547', 'demo547@example.com', '内田 慎一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', '教員', true),
  ('demo_seed_548', 'demo548@example.com', '原 達也', '千葉県', '船橋市', '東京都', '', '教育', '公務員', false),
  ('demo_seed_549', 'demo549@example.com', '松田 誠', '東京都', '小金井市', '静岡県', '', '公務', 'エンジニア', false),
  ('demo_seed_550', 'demo550@example.com', '池田 博之', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '営業', false),
  ('demo_seed_551', 'demo551@example.com', '山本 拓海', '埼玉県', 'さいたま市', '東京都', '', 'IT・通信', 'マーケティング', false),
  ('demo_seed_552', 'demo552@example.com', '斉藤 竜也', '千葉県', '船橋市', '兵庫県', '', '製造業', 'デザイナー', true),
  ('demo_seed_553', 'demo553@example.com', '遠藤 翔平', '東京都', '小金井市', '京都府', '', '金融・保険', '企画', false),
  ('demo_seed_554', 'demo554@example.com', '青木 剛志', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '経理・財務', false),
  ('demo_seed_555', 'demo555@example.com', '坂井 雄太', '埼玉県', 'さいたま市', '東京都', '', 'サービス', '人事', false),
  ('demo_seed_556', 'demo556@example.com', '武田 直人', '千葉県', '船橋市', '埼玉県', '', '建設・不動産', '事務', false),
  ('demo_seed_557', 'demo557@example.com', '上田 健一', '東京都', '小金井市', '埼玉県', '', '医療・福祉', '医療従事者', true),
  ('demo_seed_558', 'demo558@example.com', '金子 大輔', '神奈川県', '横浜市', '千葉県', '', '教育', '教員', false),
  ('demo_seed_559', 'demo559@example.com', '近藤 誠', '埼玉県', 'さいたま市', '青森県', '', '公務', '公務員', false),
  ('demo_seed_560', 'demo560@example.com', '福田 翔太', '千葉県', '船橋市', '神奈川県', '', 'メディア・広告', 'エンジニア', false),
  ('demo_seed_561', 'demo561@example.com', '山田 隆', '東京都', '小金井市', '東京都', '', 'IT・通信', '営業', false),
  ('demo_seed_562', 'demo562@example.com', '佐藤 浩二', '神奈川県', '横浜市', '千葉県', '', '製造業', 'マーケティング', true),
  ('demo_seed_563', 'demo563@example.com', '鈴木 直樹', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', 'デザイナー', false),
  ('demo_seed_564', 'demo564@example.com', '高橋 雄一', '千葉県', '船橋市', '東京都', '', '小売・卸売', '企画', false),
  ('demo_seed_565', 'demo565@example.com', '伊藤 誠一', '東京都', '小金井市', '海外', 'シンガポール', 'サービス', '経理・財務', false),
  ('demo_seed_566', 'demo566@example.com', '渡辺 和也', '神奈川県', '横浜市', '大阪府', '', '建設・不動産', '人事', false),
  ('demo_seed_567', 'demo567@example.com', '中村 聡一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', '事務', true),
  ('demo_seed_568', 'demo568@example.com', '小林 大輝', '千葉県', '船橋市', '東京都', '', '教育', '医療従事者', false),
  ('demo_seed_569', 'demo569@example.com', '加藤 裕介', '東京都', '小金井市', '大阪府', '', '公務', '教員', false),
  ('demo_seed_570', 'demo570@example.com', '吉田 健', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '公務員', false),
  ('demo_seed_571', 'demo571@example.com', '田中 一郎', '埼玉県', 'さいたま市', '東京都', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_572', 'demo572@example.com', '松本 聡', '千葉県', '船橋市', '大阪府', '', '製造業', '営業', true),
  ('demo_seed_573', 'demo573@example.com', '井上 拓也', '東京都', '小金井市', '埼玉県', '', '金融・保険', 'マーケティング', false),
  ('demo_seed_574', 'demo574@example.com', '木村 剛', '神奈川県', '横浜市', '兵庫県', '', '小売・卸売', 'デザイナー', false),
  ('demo_seed_575', 'demo575@example.com', '林 健太', '埼玉県', 'さいたま市', '埼玉県', '', 'サービス', '企画', false),
  ('demo_seed_576', 'demo576@example.com', '斎藤 裕也', '千葉県', '船橋市', '栃木県', '', '建設・不動産', '経理・財務', false),
  ('demo_seed_577', 'demo577@example.com', '山口 慎一', '東京都', '小金井市', '千葉県', '', '医療・福祉', '人事', true),
  ('demo_seed_578', 'demo578@example.com', '森 達也', '神奈川県', '横浜市', '東京都', '', '教育', '事務', false),
  ('demo_seed_579', 'demo579@example.com', '阿部 誠', '埼玉県', 'さいたま市', '埼玉県', '', '公務', '医療従事者', false),
  ('demo_seed_580', 'demo580@example.com', '石井 博之', '千葉県', '船橋市', '神奈川県', '', 'メディア・広告', '教員', false),
  ('demo_seed_581', 'demo581@example.com', '清水 拓海', '東京都', '小金井市', '福岡県', '', 'IT・通信', '公務員', false),
  ('demo_seed_582', 'demo582@example.com', '松浦 竜也', '神奈川県', '横浜市', '東京都', '', '製造業', 'エンジニア', true),
  ('demo_seed_583', 'demo583@example.com', '三浦 翔平', '埼玉県', 'さいたま市', '神奈川県', '', '金融・保険', '営業', false),
  ('demo_seed_584', 'demo584@example.com', '大野 剛志', '千葉県', '船橋市', '東京都', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_585', 'demo585@example.com', '小島 雄太', '東京都', '小金井市', '福岡県', '', 'サービス', 'デザイナー', false),
  ('demo_seed_586', 'demo586@example.com', '新井 直人', '神奈川県', '横浜市', '神奈川県', '', '建設・不動産', '企画', false),
  ('demo_seed_587', 'demo587@example.com', '内田 健一', '埼玉県', 'さいたま市', '愛知県', '', '医療・福祉', '経理・財務', true),
  ('demo_seed_588', 'demo588@example.com', '原 大輔', '千葉県', '船橋市', '愛知県', '', '教育', '人事', false),
  ('demo_seed_589', 'demo589@example.com', '松田 誠', '東京都', '小金井市', '埼玉県', '', '公務', '事務', false),
  ('demo_seed_590', 'demo590@example.com', '池田 翔太', '神奈川県', '横浜市', '北海道', '', 'メディア・広告', '医療従事者', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_591', 'demo591@example.com', '山本 隆', '埼玉県', 'さいたま市', '埼玉県', '', 'IT・通信', '教員', false),
  ('demo_seed_592', 'demo592@example.com', '斉藤 浩二', '千葉県', '船橋市', '大阪府', '', '製造業', '公務員', true),
  ('demo_seed_593', 'demo593@example.com', '遠藤 直樹', '東京都', '小金井市', '東京都', '', '金融・保険', 'エンジニア', false),
  ('demo_seed_594', 'demo594@example.com', '青木 雄一', '神奈川県', '横浜市', '千葉県', '', '小売・卸売', '営業', false),
  ('demo_seed_595', 'demo595@example.com', '坂井 誠一', '埼玉県', 'さいたま市', '千葉県', '', 'サービス', 'マーケティング', false),
  ('demo_seed_596', 'demo596@example.com', '武田 和也', '千葉県', '船橋市', '大阪府', '', '建設・不動産', 'デザイナー', false),
  ('demo_seed_597', 'demo597@example.com', '上田 聡一', '東京都', '小金井市', '東京都', '', '医療・福祉', '企画', true),
  ('demo_seed_598', 'demo598@example.com', '金子 大輝', '神奈川県', '横浜市', '東京都', '', '教育', '経理・財務', false),
  ('demo_seed_599', 'demo599@example.com', '近藤 裕介', '埼玉県', 'さいたま市', '広島県', '', '公務', '人事', false),
  ('demo_seed_600', 'demo600@example.com', '福田 健', '千葉県', '船橋市', '神奈川県', '', 'メディア・広告', '事務', false),
  ('demo_seed_601', 'demo601@example.com', '山田 一郎', '東京都', '小金井市', '東京都', '', 'IT・通信', '医療従事者', false),
  ('demo_seed_602', 'demo602@example.com', '佐藤 聡', '神奈川県', '横浜市', '栃木県', '', '製造業', '教員', true),
  ('demo_seed_603', 'demo603@example.com', '鈴木 拓也', '埼玉県', 'さいたま市', '大阪府', '', '金融・保険', '公務員', false),
  ('demo_seed_604', 'demo604@example.com', '高橋 剛', '千葉県', '船橋市', '東京都', '', '小売・卸売', 'エンジニア', false),
  ('demo_seed_605', 'demo605@example.com', '伊藤 健太', '東京都', '小金井市', '神奈川県', '', 'サービス', '営業', false),
  ('demo_seed_606', 'demo606@example.com', '渡辺 裕也', '神奈川県', '横浜市', '北海道', '', '建設・不動産', 'マーケティング', false),
  ('demo_seed_607', 'demo607@example.com', '中村 慎一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', 'デザイナー', true),
  ('demo_seed_608', 'demo608@example.com', '小林 達也', '千葉県', '船橋市', '福岡県', '', '教育', '企画', false),
  ('demo_seed_609', 'demo609@example.com', '加藤 誠', '東京都', '小金井市', '愛知県', '', '公務', '経理・財務', false),
  ('demo_seed_610', 'demo610@example.com', '吉田 博之', '神奈川県', '横浜市', '大阪府', '', 'メディア・広告', '人事', false),
  ('demo_seed_611', 'demo611@example.com', '田中 拓海', '埼玉県', 'さいたま市', '東京都', '', 'IT・通信', '事務', false),
  ('demo_seed_612', 'demo612@example.com', '松本 竜也', '千葉県', '船橋市', '東京都', '', '製造業', '医療従事者', true),
  ('demo_seed_613', 'demo613@example.com', '井上 翔平', '東京都', '小金井市', '東京都', '', '金融・保険', '教員', false),
  ('demo_seed_614', 'demo614@example.com', '木村 剛志', '神奈川県', '横浜市', '埼玉県', '', '小売・卸売', '公務員', false),
  ('demo_seed_615', 'demo615@example.com', '林 雄太', '埼玉県', 'さいたま市', '千葉県', '', 'サービス', 'エンジニア', false),
  ('demo_seed_616', 'demo616@example.com', '斎藤 直人', '千葉県', '船橋市', '千葉県', '', '建設・不動産', '営業', false),
  ('demo_seed_617', 'demo617@example.com', '山口 健一', '東京都', '小金井市', '大阪府', '', '医療・福祉', 'マーケティング', true),
  ('demo_seed_618', 'demo618@example.com', '森 大輔', '神奈川県', '横浜市', '神奈川県', '', '教育', 'デザイナー', false),
  ('demo_seed_619', 'demo619@example.com', '阿部 誠', '埼玉県', 'さいたま市', '福岡県', '', '公務', '企画', false),
  ('demo_seed_620', 'demo620@example.com', '石井 翔太', '千葉県', '船橋市', '千葉県', '', 'メディア・広告', '経理・財務', false),
  ('demo_seed_621', 'demo621@example.com', '清水 隆', '東京都', '小金井市', '東京都', '', 'IT・通信', '人事', false),
  ('demo_seed_622', 'demo622@example.com', '松浦 浩二', '神奈川県', '横浜市', '福岡県', '', '製造業', '事務', true),
  ('demo_seed_623', 'demo623@example.com', '三浦 直樹', '埼玉県', 'さいたま市', '兵庫県', '', '金融・保険', '医療従事者', false),
  ('demo_seed_624', 'demo624@example.com', '大野 雄一', '千葉県', '船橋市', '東京都', '', '小売・卸売', '教員', false),
  ('demo_seed_625', 'demo625@example.com', '小島 誠一', '東京都', '小金井市', '千葉県', '', 'サービス', '公務員', false),
  ('demo_seed_626', 'demo626@example.com', '新井 和也', '神奈川県', '横浜市', '東京都', '', '建設・不動産', 'エンジニア', false),
  ('demo_seed_627', 'demo627@example.com', '内田 聡一', '埼玉県', 'さいたま市', '広島県', '', '医療・福祉', '営業', true),
  ('demo_seed_628', 'demo628@example.com', '原 大輝', '千葉県', '船橋市', '東京都', '', '教育', 'マーケティング', false),
  ('demo_seed_629', 'demo629@example.com', '松田 裕介', '東京都', '小金井市', '大阪府', '', '公務', 'デザイナー', false),
  ('demo_seed_630', 'demo630@example.com', '池田 健', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '企画', false),
  ('demo_seed_631', 'demo631@example.com', '山本 一郎', '埼玉県', 'さいたま市', '千葉県', '', 'IT・通信', '経理・財務', false),
  ('demo_seed_632', 'demo632@example.com', '斉藤 聡', '千葉県', '船橋市', '東京都', '', '製造業', '人事', true),
  ('demo_seed_633', 'demo633@example.com', '遠藤 拓也', '東京都', '小金井市', '東京都', '', '金融・保険', '事務', false),
  ('demo_seed_634', 'demo634@example.com', '青木 剛', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '医療従事者', false),
  ('demo_seed_635', 'demo635@example.com', '坂井 健太', '埼玉県', 'さいたま市', '埼玉県', '', 'サービス', '教員', false),
  ('demo_seed_636', 'demo636@example.com', '武田 裕也', '千葉県', '船橋市', '福岡県', '', '建設・不動産', '公務員', false),
  ('demo_seed_637', 'demo637@example.com', '上田 慎一', '東京都', '小金井市', '東京都', '', '医療・福祉', 'エンジニア', true),
  ('demo_seed_638', 'demo638@example.com', '金子 達也', '神奈川県', '横浜市', '埼玉県', '', '教育', '営業', false),
  ('demo_seed_639', 'demo639@example.com', '近藤 誠', '埼玉県', 'さいたま市', '埼玉県', '', '公務', 'マーケティング', false),
  ('demo_seed_640', 'demo640@example.com', '福田 博之', '千葉県', '船橋市', '埼玉県', '', 'メディア・広告', 'デザイナー', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_641', 'demo641@example.com', '山田 拓海', '東京都', '小金井市', '千葉県', '', 'IT・通信', '企画', false),
  ('demo_seed_642', 'demo642@example.com', '佐藤 竜也', '神奈川県', '横浜市', '京都府', '', '製造業', '経理・財務', true),
  ('demo_seed_643', 'demo643@example.com', '鈴木 翔平', '埼玉県', 'さいたま市', '広島県', '', '金融・保険', '人事', false),
  ('demo_seed_644', 'demo644@example.com', '高橋 剛志', '千葉県', '船橋市', '東京都', '', '小売・卸売', '事務', false),
  ('demo_seed_645', 'demo645@example.com', '伊藤 雄太', '東京都', '小金井市', '愛知県', '', 'サービス', '医療従事者', false),
  ('demo_seed_646', 'demo646@example.com', '渡辺 直人', '神奈川県', '横浜市', '広島県', '', '建設・不動産', '教員', false),
  ('demo_seed_647', 'demo647@example.com', '中村 健一', '埼玉県', 'さいたま市', '埼玉県', '', '医療・福祉', '公務員', true),
  ('demo_seed_648', 'demo648@example.com', '小林 大輔', '千葉県', '船橋市', '愛知県', '', '教育', 'エンジニア', false),
  ('demo_seed_649', 'demo649@example.com', '加藤 誠', '東京都', '小金井市', '千葉県', '', '公務', '営業', false),
  ('demo_seed_650', 'demo650@example.com', '吉田 翔太', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', 'マーケティング', false),
  ('demo_seed_651', 'demo651@example.com', '田中 隆', '埼玉県', 'さいたま市', '東京都', '', 'IT・通信', 'デザイナー', false),
  ('demo_seed_652', 'demo652@example.com', '松本 浩二', '千葉県', '船橋市', '東京都', '', '製造業', '企画', true),
  ('demo_seed_653', 'demo653@example.com', '井上 直樹', '東京都', '小金井市', '茨城県', '', '金融・保険', '経理・財務', false),
  ('demo_seed_654', 'demo654@example.com', '木村 雄一', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '人事', false),
  ('demo_seed_655', 'demo655@example.com', '林 誠一', '埼玉県', 'さいたま市', '埼玉県', '', 'サービス', '事務', false),
  ('demo_seed_656', 'demo656@example.com', '斎藤 和也', '千葉県', '船橋市', '愛知県', '', '建設・不動産', '医療従事者', false),
  ('demo_seed_657', 'demo657@example.com', '山口 聡一', '東京都', '小金井市', '大阪府', '', '医療・福祉', '教員', true),
  ('demo_seed_658', 'demo658@example.com', '森 大輝', '神奈川県', '横浜市', '埼玉県', '', '教育', '公務員', false),
  ('demo_seed_659', 'demo659@example.com', '阿部 裕介', '埼玉県', 'さいたま市', '北海道', '', '公務', 'エンジニア', false),
  ('demo_seed_660', 'demo660@example.com', '石井 健', '千葉県', '船橋市', '愛知県', '', 'メディア・広告', '営業', false),
  ('demo_seed_661', 'demo661@example.com', '清水 一郎', '東京都', '小金井市', '大阪府', '', 'IT・通信', 'マーケティング', false),
  ('demo_seed_662', 'demo662@example.com', '松浦 聡', '神奈川県', '横浜市', '宮城県', '', '製造業', 'デザイナー', true),
  ('demo_seed_663', 'demo663@example.com', '三浦 拓也', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', '企画', false),
  ('demo_seed_664', 'demo664@example.com', '大野 剛', '千葉県', '船橋市', '神奈川県', '', '小売・卸売', '経理・財務', false),
  ('demo_seed_665', 'demo665@example.com', '小島 健太', '東京都', '小金井市', '北海道', '', 'サービス', '人事', false),
  ('demo_seed_666', 'demo666@example.com', '新井 裕也', '神奈川県', '横浜市', '海外', 'ロンドン', '建設・不動産', '事務', false),
  ('demo_seed_667', 'demo667@example.com', '内田 慎一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', '医療従事者', true),
  ('demo_seed_668', 'demo668@example.com', '原 達也', '千葉県', '船橋市', '神奈川県', '', '教育', '教員', false),
  ('demo_seed_669', 'demo669@example.com', '松田 誠', '東京都', '小金井市', '東京都', '', '公務', '公務員', false),
  ('demo_seed_670', 'demo670@example.com', '池田 博之', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', 'エンジニア', false),
  ('demo_seed_671', 'demo671@example.com', '山本 拓海', '埼玉県', 'さいたま市', '東京都', '', 'IT・通信', '営業', false),
  ('demo_seed_672', 'demo672@example.com', '斉藤 竜也', '千葉県', '船橋市', '東京都', '', '製造業', 'マーケティング', true),
  ('demo_seed_673', 'demo673@example.com', '遠藤 翔平', '東京都', '小金井市', '神奈川県', '', '金融・保険', 'デザイナー', false),
  ('demo_seed_674', 'demo674@example.com', '青木 剛志', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '企画', false),
  ('demo_seed_675', 'demo675@example.com', '坂井 雄太', '埼玉県', 'さいたま市', '埼玉県', '', 'サービス', '経理・財務', false),
  ('demo_seed_676', 'demo676@example.com', '武田 直人', '千葉県', '船橋市', '埼玉県', '', '建設・不動産', '人事', false),
  ('demo_seed_677', 'demo677@example.com', '上田 健一', '東京都', '小金井市', '沖縄県', '', '医療・福祉', '事務', true),
  ('demo_seed_678', 'demo678@example.com', '金子 大輔', '神奈川県', '横浜市', '東京都', '', '教育', '医療従事者', false),
  ('demo_seed_679', 'demo679@example.com', '近藤 誠', '埼玉県', 'さいたま市', '東京都', '', '公務', '教員', false),
  ('demo_seed_680', 'demo680@example.com', '福田 翔太', '千葉県', '船橋市', '静岡県', '', 'メディア・広告', '公務員', false),
  ('demo_seed_681', 'demo681@example.com', '山田 隆', '東京都', '小金井市', '愛知県', '', 'IT・通信', 'エンジニア', false),
  ('demo_seed_682', 'demo682@example.com', '佐藤 浩二', '神奈川県', '横浜市', '東京都', '', '製造業', '営業', true),
  ('demo_seed_683', 'demo683@example.com', '鈴木 直樹', '埼玉県', 'さいたま市', '東京都', '', '金融・保険', 'マーケティング', false),
  ('demo_seed_684', 'demo684@example.com', '高橋 雄一', '千葉県', '船橋市', '北海道', '', '小売・卸売', 'デザイナー', false),
  ('demo_seed_685', 'demo685@example.com', '伊藤 誠一', '東京都', '小金井市', '埼玉県', '', 'サービス', '企画', false),
  ('demo_seed_686', 'demo686@example.com', '渡辺 和也', '神奈川県', '横浜市', '大阪府', '', '建設・不動産', '経理・財務', false),
  ('demo_seed_687', 'demo687@example.com', '中村 聡一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', '人事', true),
  ('demo_seed_688', 'demo688@example.com', '小林 大輝', '千葉県', '船橋市', '栃木県', '', '教育', '事務', false),
  ('demo_seed_689', 'demo689@example.com', '加藤 裕介', '東京都', '小金井市', '埼玉県', '', '公務', '医療従事者', false),
  ('demo_seed_690', 'demo690@example.com', '吉田 健', '神奈川県', '横浜市', '静岡県', '', 'メディア・広告', '教員', false)
ON CONFLICT (clerk_user_id) DO NOTHING;

INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)
VALUES
  ('demo_seed_691', 'demo691@example.com', '田中 一郎', '埼玉県', 'さいたま市', '広島県', '', 'IT・通信', '公務員', false),
  ('demo_seed_692', 'demo692@example.com', '松本 聡', '千葉県', '船橋市', '沖縄県', '', '製造業', 'エンジニア', true),
  ('demo_seed_693', 'demo693@example.com', '井上 拓也', '東京都', '小金井市', '神奈川県', '', '金融・保険', '営業', false),
  ('demo_seed_694', 'demo694@example.com', '木村 剛', '神奈川県', '横浜市', '東京都', '', '小売・卸売', 'マーケティング', false),
  ('demo_seed_695', 'demo695@example.com', '林 健太', '埼玉県', 'さいたま市', '京都府', '', 'サービス', 'デザイナー', false),
  ('demo_seed_696', 'demo696@example.com', '斎藤 裕也', '千葉県', '船橋市', '茨城県', '', '建設・不動産', '企画', false),
  ('demo_seed_697', 'demo697@example.com', '山口 慎一', '東京都', '小金井市', '神奈川県', '', '医療・福祉', '経理・財務', true),
  ('demo_seed_698', 'demo698@example.com', '森 達也', '神奈川県', '横浜市', '東京都', '', '教育', '人事', false),
  ('demo_seed_699', 'demo699@example.com', '阿部 誠', '埼玉県', 'さいたま市', '東京都', '', '公務', '事務', false),
  ('demo_seed_700', 'demo700@example.com', '石井 博之', '千葉県', '船橋市', '新潟県', '', 'メディア・広告', '医療従事者', false),
  ('demo_seed_701', 'demo701@example.com', '清水 拓海', '東京都', '小金井市', '東京都', '', 'IT・通信', '教員', false),
  ('demo_seed_702', 'demo702@example.com', '松浦 竜也', '神奈川県', '横浜市', '神奈川県', '', '製造業', '公務員', true),
  ('demo_seed_703', 'demo703@example.com', '三浦 翔平', '埼玉県', 'さいたま市', '埼玉県', '', '金融・保険', 'エンジニア', false),
  ('demo_seed_704', 'demo704@example.com', '大野 剛志', '千葉県', '船橋市', '沖縄県', '', '小売・卸売', '営業', false),
  ('demo_seed_705', 'demo705@example.com', '小島 雄太', '東京都', '小金井市', '東京都', '', 'サービス', 'マーケティング', false),
  ('demo_seed_706', 'demo706@example.com', '新井 直人', '神奈川県', '横浜市', '東京都', '', '建設・不動産', 'デザイナー', false),
  ('demo_seed_707', 'demo707@example.com', '内田 健一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', '企画', true),
  ('demo_seed_708', 'demo708@example.com', '原 大輔', '千葉県', '船橋市', '静岡県', '', '教育', '経理・財務', false),
  ('demo_seed_709', 'demo709@example.com', '松田 誠', '東京都', '小金井市', '兵庫県', '', '公務', '人事', false),
  ('demo_seed_710', 'demo710@example.com', '池田 翔太', '神奈川県', '横浜市', '東京都', '', 'メディア・広告', '事務', false),
  ('demo_seed_711', 'demo711@example.com', '山本 隆', '埼玉県', 'さいたま市', '愛知県', '', 'IT・通信', '医療従事者', false),
  ('demo_seed_712', 'demo712@example.com', '斉藤 浩二', '千葉県', '船橋市', '神奈川県', '', '製造業', '教員', true),
  ('demo_seed_713', 'demo713@example.com', '遠藤 直樹', '東京都', '小金井市', '東京都', '', '金融・保険', '公務員', false),
  ('demo_seed_714', 'demo714@example.com', '青木 雄一', '神奈川県', '横浜市', '東京都', '', '小売・卸売', 'エンジニア', false),
  ('demo_seed_715', 'demo715@example.com', '坂井 誠一', '埼玉県', 'さいたま市', '大阪府', '', 'サービス', '営業', false),
  ('demo_seed_716', 'demo716@example.com', '武田 和也', '千葉県', '船橋市', '大阪府', '', '建設・不動産', 'マーケティング', false),
  ('demo_seed_717', 'demo717@example.com', '上田 聡一', '東京都', '小金井市', '大阪府', '', '医療・福祉', 'デザイナー', true),
  ('demo_seed_718', 'demo718@example.com', '金子 大輝', '神奈川県', '横浜市', '東京都', '', '教育', '企画', false),
  ('demo_seed_719', 'demo719@example.com', '近藤 裕介', '埼玉県', 'さいたま市', '愛知県', '', '公務', '経理・財務', false),
  ('demo_seed_720', 'demo720@example.com', '福田 健', '千葉県', '船橋市', '静岡県', '', 'メディア・広告', '人事', false),
  ('demo_seed_721', 'demo721@example.com', '山田 一郎', '東京都', '小金井市', '神奈川県', '', 'IT・通信', '事務', false),
  ('demo_seed_722', 'demo722@example.com', '佐藤 聡', '神奈川県', '横浜市', '神奈川県', '', '製造業', '医療従事者', true),
  ('demo_seed_723', 'demo723@example.com', '鈴木 拓也', '埼玉県', 'さいたま市', '神奈川県', '', '金融・保険', '教員', false),
  ('demo_seed_724', 'demo724@example.com', '高橋 剛', '千葉県', '船橋市', '神奈川県', '', '小売・卸売', '公務員', false),
  ('demo_seed_725', 'demo725@example.com', '伊藤 健太', '東京都', '小金井市', '神奈川県', '', 'サービス', 'エンジニア', false),
  ('demo_seed_726', 'demo726@example.com', '渡辺 裕也', '神奈川県', '横浜市', '大阪府', '', '建設・不動産', '営業', false),
  ('demo_seed_727', 'demo727@example.com', '中村 慎一', '埼玉県', 'さいたま市', '東京都', '', '医療・福祉', 'マーケティング', true),
  ('demo_seed_728', 'demo728@example.com', '小林 達也', '千葉県', '船橋市', '東京都', '', '教育', 'デザイナー', false),
  ('demo_seed_729', 'demo729@example.com', '加藤 誠', '東京都', '小金井市', '東京都', '', '公務', '企画', false),
  ('demo_seed_730', 'demo730@example.com', '吉田 博之', '神奈川県', '横浜市', '神奈川県', '', 'メディア・広告', '経理・財務', false),
  ('demo_seed_731', 'demo731@example.com', '田中 拓海', '埼玉県', 'さいたま市', '兵庫県', '', 'IT・通信', '人事', false),
  ('demo_seed_732', 'demo732@example.com', '松本 竜也', '千葉県', '船橋市', '海外', '香港', '製造業', '事務', true),
  ('demo_seed_733', 'demo733@example.com', '井上 翔平', '東京都', '小金井市', '福岡県', '', '金融・保険', '医療従事者', false),
  ('demo_seed_734', 'demo734@example.com', '木村 剛志', '神奈川県', '横浜市', '東京都', '', '小売・卸売', '教員', false),
  ('demo_seed_735', 'demo735@example.com', '林 雄太', '埼玉県', 'さいたま市', '埼玉県', '', 'サービス', '公務員', false),
  ('demo_seed_736', 'demo736@example.com', '斎藤 直人', '千葉県', '船橋市', '千葉県', '', '建設・不動産', 'エンジニア', false),
  ('demo_seed_737', 'demo737@example.com', '山口 健一', '東京都', '小金井市', '千葉県', '', '医療・福祉', '営業', true),
  ('demo_seed_738', 'demo738@example.com', '森 大輔', '神奈川県', '横浜市', '京都府', '', '教育', 'マーケティング', false),
  ('demo_seed_739', 'demo739@example.com', '阿部 誠', '埼玉県', 'さいたま市', '新潟県', '', '公務', 'デザイナー', false),
  ('demo_seed_740', 'demo740@example.com', '石井 翔太', '千葉県', '船橋市', '愛知県', '', 'メディア・広告', '企画', false)
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
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_3' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_4' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_5' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_6' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_7' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_8' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_9' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_10' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_11' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_12' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_13' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_14' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_15' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_16' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_17' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_18' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_19' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_20' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_21' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_22' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_23' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_24' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_25' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_26' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_27' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_28' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_29' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_30' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_31' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_32' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_33' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_34' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_35' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_36' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_37' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_38' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_39' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_40' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_41' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_42' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_43' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_44' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_45' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_46' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_47' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_48' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_49' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_50' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_51' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_52' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_53' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_54' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_55' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_56' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_57' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_58' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_59' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_60' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_61' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_62' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_63' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_64' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_65' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_66' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_67' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_68' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_69' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_70' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_71' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_72' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_73' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_74' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_75' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_76' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_77' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_78' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_79' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_80' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_81' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_82' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_83' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_84' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_85' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_86' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_87' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_88' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_89' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_90' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_91' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_92' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_93' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_94' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_95' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_96' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_97' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_98' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_99' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_100' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_101' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_102' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_103' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_104' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_105' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_106' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_107' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_108' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_109' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_110' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_111' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_112' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_113' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_114' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_115' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_116' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_117' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_118' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_119' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_120' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_121' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_122' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_123' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_124' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_125' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_126' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_127' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_128' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_129' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_130' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_131' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_132' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_133' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_134' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_135' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_136' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_137' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_138' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_139' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_140' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_141' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_142' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_143' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_144' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_145' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_146' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_147' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_148' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_149' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_150' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_151' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_152' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_153' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_154' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_155' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_156' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_157' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_158' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_159' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_160' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_161' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_162' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_163' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_164' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_165' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_166' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_167' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_168' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_169' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_170' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_171' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_172' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_173' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_174' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_175' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_176' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_177' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_178' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_179' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_180' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_181' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_182' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_183' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_184' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_185' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_186' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_187' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_188' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_189' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_190' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_191' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_192' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_193' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_194' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_195' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_196' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_197' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_198' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_199' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_200' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_201' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_202' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_203' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_204' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_205' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_206' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_207' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_208' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_209' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_210' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_211' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_212' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_213' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_214' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_215' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_216' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_217' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_218' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_219' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_220' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_221' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_222' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_223' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_224' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_225' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_226' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_227' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['陸上部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_228' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['吹奏楽部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_229' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['合唱部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_230' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['美術部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_231' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['書道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_232' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['剣道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_233' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['柔道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_234' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_235' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['野球部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_236' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['サッカー部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_237' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バスケットボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_238' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['バレーボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_239' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1989, ARRAY['テニス部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_240' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_241' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_242' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_243' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_244' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_245' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_246' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_247' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_248' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_249' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_250' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_251' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_252' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_253' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_254' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_255' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_256' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_257' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_258' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_259' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_260' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_261' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_262' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_263' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_264' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_265' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_266' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_267' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_268' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_269' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_270' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_271' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_272' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_273' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_274' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_275' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_276' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_277' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_278' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_279' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_280' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_281' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_282' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_283' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_284' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_285' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_286' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_287' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_288' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_289' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_290' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_291' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_292' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_293' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_294' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_295' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_296' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_297' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_298' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_299' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_300' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_301' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_302' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_303' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_304' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_305' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_306' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_307' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_308' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_309' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_310' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_311' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_312' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_313' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_314' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_315' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_316' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_317' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_318' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_319' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_320' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_321' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_322' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_323' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_324' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_325' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_326' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_327' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_328' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_329' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_330' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_331' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_332' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_333' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_334' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_335' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_336' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_337' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_338' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_339' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_340' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_341' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_342' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_343' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_344' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_345' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_346' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_347' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_348' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_349' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_350' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_351' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_352' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_353' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_354' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_355' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_356' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_357' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_358' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_359' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_360' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_361' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_362' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_363' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_364' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_365' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_366' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_367' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_368' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_369' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_370' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_371' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_372' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_373' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_374' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_375' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_376' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_377' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_378' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_379' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_380' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_381' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_382' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_383' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_384' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_385' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_386' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_387' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_388' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_389' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_390' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_391' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_392' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_393' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_394' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_395' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_396' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_397' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_398' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_399' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_400' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_401' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_402' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_403' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_404' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_405' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_406' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_407' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_408' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_409' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_410' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_411' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_412' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_413' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_414' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_415' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_416' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_417' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_418' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_419' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_420' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_421' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_422' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_423' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_424' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_425' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_426' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_427' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_428' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_429' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_430' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_431' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_432' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_433' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_434' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_435' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_436' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_437' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_438' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_439' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_440' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_441' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_442' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_443' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_444' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_445' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_446' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_447' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_448' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_449' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_450' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_451' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_452' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_453' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_454' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_455' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_456' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_457' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_458' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_459' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_460' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_461' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_462' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_463' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_464' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_465' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_466' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_467' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_468' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_469' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_470' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_471' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_472' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_473' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_474' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_475' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_476' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_477' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_478' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_479' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_480' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_481' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_482' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_483' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_484' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_485' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_486' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_487' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_488' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_489' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_490' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_491' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_492' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_493' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_494' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_495' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_496' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_497' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_498' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_499' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_500' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_501' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_502' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_503' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_504' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_505' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_506' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_507' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_508' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_509' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_510' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_511' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_512' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_513' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_514' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_515' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_516' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_517' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_518' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_519' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_520' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_521' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_522' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_523' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_524' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_525' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_526' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_527' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_528' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_529' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_530' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_531' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_532' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_533' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_534' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_535' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_536' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_537' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_538' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_539' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_540' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_541' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_542' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_543' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_544' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_545' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_546' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_547' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_548' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_549' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_550' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_551' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_552' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_553' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_554' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_555' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_556' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_557' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_558' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_559' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_560' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_561' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_562' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_563' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_564' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_565' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_566' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_567' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_568' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_569' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_570' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_571' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_572' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_573' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_574' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_575' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_576' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_577' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_578' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_579' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_580' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_581' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_582' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_583' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_584' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_585' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_586' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_587' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_588' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_589' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_590' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_591' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_592' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_593' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_594' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_595' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_596' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_597' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_598' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_599' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_600' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_601' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_602' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_603' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_604' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_605' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_606' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_607' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_608' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_609' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_610' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_611' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_612' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_613' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_614' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_615' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_616' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_617' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_618' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_619' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_620' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_621' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_622' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_623' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_624' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_625' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_626' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_627' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_628' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_629' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_630' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_631' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_632' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_633' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_634' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_635' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_636' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_637' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_638' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_639' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_640' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_641' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_642' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_643' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_644' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_645' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_646' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_647' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_648' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_649' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_650' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_651' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_652' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_653' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_654' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_655' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_656' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_657' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_658' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_659' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_660' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_661' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_662' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_663' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_664' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_665' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_666' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_667' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_668' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_669' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_670' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_671' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_672' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_673' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_674' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_675' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_676' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_677' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_678' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_679' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_680' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_681' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_682' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_683' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_684' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_685' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_686' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_687' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_688' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_689' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_690' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_691' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_692' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_693' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_694' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_695' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_696' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_697' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_698' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_699' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_700' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_701' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_702' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_703' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_704' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_705' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_706' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_707' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_708' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_709' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_710' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_711' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_712' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_713' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_714' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_715' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_716' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_717' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_718' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_719' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_720' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_721' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_722' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_723' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_724' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_725' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_726' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_727' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['陸上部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_728' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['吹奏楽部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_729' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['合唱部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_730' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['美術部'], '1組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_731' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['書道部'], '2組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_732' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['剣道部'], '3組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_733' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['柔道部'], '4組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_734' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['帰宅部'], '5組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_735' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['野球部'], '6組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_736' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['サッカー部'], '7組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_737' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バスケットボール部'], '8組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_738' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['バレーボール部'], '9組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_739' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;
INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)
SELECT p.id, s.id, 1992, ARRAY['テニス部'], '10組'
FROM public.profiles p CROSS JOIN public.schools s
WHERE p.clerk_user_id = 'demo_seed_740' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;