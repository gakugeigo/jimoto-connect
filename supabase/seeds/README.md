# Supabase シードファイル

## 実行方法

Supabase ダッシュボード > SQL Editor で各ファイルの内容をコピー＆実行してください。

## ファイル一覧

| ファイル | 内容 | 実行順 |
|----------|------|--------|
| `schools.sql` | 全国約500校を投入（既存 schools は削除） | 初回のみ |
| `supabase_demo_seed.sql` | 奈良中1989年卒10人 + 中大附属1992年卒10人（安全に再実行可能） | デモ用 |
| `demo_10_profiles.sql` | 上記と同じ20人（schools に該当2校が必要） | supabase_demo_seed の代替 |
| `dev_test_profiles.sql` | 那覇高・横浜翠嵐の3人（検索テスト用） | 任意 |

## 推奨

- **同級生マップのデモ**: `supabase_demo_seed.sql` のみ実行（学校も自動作成）
- **検索のテスト**: `dev_test_profiles.sql` を実行（那覇高・横浜翠嵐を登録している場合）

詳細は `docs/SUPABASE_SETUP.md` を参照してください。
