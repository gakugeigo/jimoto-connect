#!/usr/bin/env python3
"""
奈良中学校240人(1989年卒・共学) + 中央大学附属高校500人(1992年卒・男子校) のシードSQLを生成
"""
import random

# 中学240人分布（横浜市立・1989年卒）
JHS_DIST = [
    ("神奈川県", 72), ("東京都", 48), ("埼玉県", 19), ("千葉県", 17), ("愛知県", 12),
    ("大阪府", 10), ("北海道", 8), ("福岡県", 8), ("兵庫県", 6), ("静岡県", 6),
    ("茨城県", 5), ("栃木県", 4), ("群馬県", 4), ("宮城県", 4), ("広島県", 3),
    ("京都府", 3), ("新潟県", 3), ("長野県", 2), ("岐阜県", 2), ("三重県", 2),
    ("岡山県", 2),
]
JHS_OTHER = 240 - sum(c for _, c in JHS_DIST)

# 高校500人分布（中央大附属・1992年卒・男子校・海外1.6%）
HS_DIST = [
    ("東京都", 175), ("神奈川県", 65), ("埼玉県", 48), ("千葉県", 42), ("大阪府", 32),
    ("愛知県", 28), ("福岡県", 18), ("兵庫県", 14), ("北海道", 12), ("静岡県", 10),
    ("京都府", 8), ("宮城県", 8), ("茨城県", 7), ("広島県", 6), ("栃木県", 5),
    ("新潟県", 5), ("群馬県", 4), ("沖縄県", 4), ("海外", 8),
]
HS_OTHER = 500 - sum(c for _, c in HS_DIST)

INDUSTRIES = ["IT・通信", "製造業", "金融・保険", "小売・卸売", "サービス", "建設・不動産", "医療・福祉", "教育", "公務", "メディア・広告"]
OCCUPATIONS = ["エンジニア", "営業", "マーケティング", "デザイナー", "企画", "経理・財務", "人事", "事務", "医療従事者", "教員", "公務員"]

JHS_SURNAMES = ["山田", "佐藤", "鈴木", "高橋", "伊藤", "渡辺", "中村", "小林", "加藤", "吉田", "田中", "松本", "井上", "木村", "林", "斎藤", "山口", "森", "阿部", "石井", "西村", "岡田", "前田", "後藤", "長谷川", "村上", "石川", "藤田", "岡本", "坂本"]
JHS_MALE_NAMES = ["太郎", "健一", "大輔", "誠", "翔太", "隆", "浩二", "直樹", "雄一", "誠一", "和也", "聡一", "大輝", "裕介", "健", "裕也", "慎一", "達也", "拓海", "竜也"]
JHS_FEMALE_NAMES = ["陽子", "美咲", "真由美", "香織", "恵", "彩", "美穂", "優花", "麻衣"]

HS_SURNAMES = ["山田", "佐藤", "鈴木", "高橋", "伊藤", "渡辺", "中村", "小林", "加藤", "吉田", "田中", "松本", "井上", "木村", "林", "斎藤", "山口", "森", "阿部", "石井", "清水", "松浦", "三浦", "大野", "小島", "新井", "内田", "原", "松田", "池田", "山本", "斉藤", "遠藤", "青木", "坂井", "武田", "上田", "金子", "近藤", "福田"]
HS_MALE_NAMES = ["一郎", "聡", "拓也", "剛", "健太", "裕也", "慎一", "達也", "誠", "博之", "拓海", "竜也", "翔平", "剛志", "雄太", "直人", "健一", "大輔", "誠", "翔太", "隆", "浩二", "直樹", "雄一", "誠一", "和也", "聡一", "大輝", "裕介", "健"]

CLUBS = ["帰宅部", "野球部", "サッカー部", "バスケットボール部", "バレーボール部", "テニス部", "陸上部", "吹奏楽部", "合唱部", "美術部", "書道部", "剣道部", "柔道部"]

PREFECTURES_47 = ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"]

def gen_jhs_names(n):
    names = []
    for i in range(n):
        s = JHS_SURNAMES[i % len(JHS_SURNAMES)]
        if i % 2 == 0:
            g = JHS_MALE_NAMES[(i // 2) % len(JHS_MALE_NAMES)]
        else:
            g = JHS_FEMALE_NAMES[(i // 2) % len(JHS_FEMALE_NAMES)]
        names.append(f"{s} {g}")
    return names

def gen_hs_names(n):
    names = []
    for i in range(n):
        s = HS_SURNAMES[i % len(HS_SURNAMES)]
        g = HS_MALE_NAMES[i % len(HS_MALE_NAMES)]
        names.append(f"{s} {g}")
    return names

def build_pref_list(dist, other_count):
    lst = []
    for pref, count in dist:
        lst.extend([pref] * count)
    used = {p for p, _ in dist}
    other_prefs = [p for p in PREFECTURES_47 if p not in used and p != "海外"]
    for i in range(other_count):
        lst.append(other_prefs[i % len(other_prefs)])
    random.shuffle(lst)
    return lst

def main():
    random.seed(42)

    jhs_prefs = build_pref_list(JHS_DIST, JHS_OTHER)
    jhs_names = gen_jhs_names(240)
    jhs_home = ("神奈川県", "横浜市")

    hs_home_prefs = ["東京都", "神奈川県", "埼玉県", "千葉県"]
    hs_home_cities = {"東京都": "小金井市", "神奈川県": "横浜市", "埼玉県": "さいたま市", "千葉県": "船橋市"}
    hs_prefs = build_pref_list(HS_DIST, HS_OTHER)
    hs_names = gen_hs_names(500)

    lines = []
    lines.append("-- ============================================")
    lines.append("-- Supabase デモシード（740人版）")
    lines.append("-- ============================================")
    lines.append("-- 奈良中学校 1989年卒 240人（共学）")
    lines.append("-- 中央大学附属高校 1992年卒 500人（男子校）")
    lines.append("-- 使い方: Supabase ダッシュボード > SQL Editor で実行")
    lines.append("-- ============================================")
    lines.append("")
    lines.append("INSERT INTO public.schools (name, type, prefecture, city)")
    lines.append("SELECT '奈良中学校', 'junior_high', '神奈川県', '横浜市'")
    lines.append("WHERE NOT EXISTS (SELECT 1 FROM public.schools WHERE name = '奈良中学校' AND type = 'junior_high');")
    lines.append("")
    lines.append("INSERT INTO public.schools (name, type, prefecture, city)")
    lines.append("SELECT '中央大学附属高校', 'high', '東京都', '小金井市'")
    lines.append("WHERE NOT EXISTS (SELECT 1 FROM public.schools WHERE name = '中央大学附属高校' AND type = 'high');")
    lines.append("")
    lines.append("DELETE FROM public.profile_schools WHERE profile_id IN (SELECT id FROM public.profiles WHERE clerk_user_id LIKE 'demo_seed_%');")
    lines.append("DELETE FROM public.profiles WHERE clerk_user_id LIKE 'demo_seed_%';")
    lines.append("")

    values = []
    for i in range(240):
        cid = f"demo_seed_{i+1}"
        email = f"demo{i+1}@example.com"
        name = jhs_names[i]
        curr_pref = jhs_prefs[i]
        curr_city = ""
        if curr_pref == "海外":
            curr_city = random.choice(["シンガポール", "ロンドン", "ニューヨーク", "香港"])
        ind = INDUSTRIES[i % len(INDUSTRIES)]
        occ = OCCUPATIONS[i % len(OCCUPATIONS)]
        visit = (i % 5 == 0)
        values.append(f"  ('{cid}', '{email}', '{name}', '{jhs_home[0]}', '{jhs_home[1]}', '{curr_pref}', '{curr_city}', '{ind}', '{occ}', {str(visit).lower()})")

    for batch_start in range(0, 240, 50):
        batch = values[batch_start:batch_start+50]
        lines.append("INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)")
        lines.append("VALUES")
        lines.append(",\n".join(batch))
        lines.append("ON CONFLICT (clerk_user_id) DO NOTHING;")
        lines.append("")

    values2 = []
    overseas_cities = ["シンガポール", "ロンドン", "ニューヨーク", "香港"]
    for i in range(500):
        cid = f"demo_seed_{241+i}"
        email = f"demo{241+i}@example.com"
        name = hs_names[i]
        home_pref = hs_home_prefs[i % 4]
        home_city = hs_home_cities[home_pref]
        curr_pref = hs_prefs[i]
        curr_city = overseas_cities[i % 4] if curr_pref == "海外" else ""
        ind = INDUSTRIES[i % len(INDUSTRIES)]
        occ = OCCUPATIONS[i % len(OCCUPATIONS)]
        visit = (i % 5 == 1)
        values2.append(f"  ('{cid}', '{email}', '{name}', '{home_pref}', '{home_city}', '{curr_pref}', '{curr_city}', '{ind}', '{occ}', {str(visit).lower()})")

    for batch_start in range(0, 500, 50):
        batch = values2[batch_start:batch_start+50]
        lines.append("INSERT INTO public.profiles (clerk_user_id, email, display_name, home_prefecture, home_city, current_prefecture, current_city, industry, occupation, is_hometown_visit)")
        lines.append("VALUES")
        lines.append(",\n".join(batch))
        lines.append("ON CONFLICT (clerk_user_id) DO NOTHING;")
        lines.append("")

    for i in range(240):
        cid = f"demo_seed_{i+1}"
        club = CLUBS[i % len(CLUBS)]
        room = f"{(i % 8) + 1}組"
        lines.append(f"INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)")
        lines.append(f"SELECT p.id, s.id, 1989, ARRAY['{club}'], '{room}'")
        lines.append(f"FROM public.profiles p CROSS JOIN public.schools s")
        lines.append(f"WHERE p.clerk_user_id = '{cid}' AND s.name = '奈良中学校' AND s.type = 'junior_high' LIMIT 1;")

    for i in range(500):
        cid = f"demo_seed_{241+i}"
        club = CLUBS[i % len(CLUBS)]
        room = f"{(i % 10) + 1}組"
        lines.append(f"INSERT INTO public.profile_schools (profile_id, school_id, graduation_year, club_activities, class_room)")
        lines.append(f"SELECT p.id, s.id, 1992, ARRAY['{club}'], '{room}'")
        lines.append(f"FROM public.profiles p CROSS JOIN public.schools s")
        lines.append(f"WHERE p.clerk_user_id = '{cid}' AND s.name = '中央大学附属高校' AND s.type = 'high' LIMIT 1;")

    return "\n".join(lines)

if __name__ == "__main__":
    import os
    sql = main()
    out_path = os.path.join(os.path.dirname(__file__), "supabase_demo_seed.sql")
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(sql)
    print(f"Generated {out_path}")
