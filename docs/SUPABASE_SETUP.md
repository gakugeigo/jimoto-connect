# Supabase セットアップ・デプロイ手順

ローカルで準備した内容を Supabase に登録するまでの手順です。

---

## 1. 前提条件

- Supabase プロジェクトが作成済み
- マイグレーションが適用済み（`supabase db push` またはダッシュボードで手動適用）
- 環境変数 `NEXT_PUBLIC_SUPABASE_URL` と `NEXT_PUBLIC_SUPABASE_ANON_KEY` が設定済み

---

## 2. マイグレーションの適用

Supabase ダッシュボードでマイグレーションを適用する場合：

1. **SQL Editor** を開く
2. `supabase/migrations/` 内のファイルを **日付順** に実行
   - `20260216120000_create_initial_schema.sql`
   - `20260216130000_add_class_room.sql`
   - `20260216140000_add_maiden_name.sql`
   - `20260219120000_create_groups.sql`
   - `20260219130000_add_profile_extended.sql`
   - `20260220120000_create_events.sql`
   - `20260220130000_add_board_type_to_posts.sql`
   - （他に migrations があれば同様に）

または Supabase CLI を使用する場合：

```bash
supabase link --project-ref <プロジェクトID>
supabase db push
```

---

## 3. 学校マスタの投入（初回のみ）

全国の学校データ（約500校）を投入する場合：

1. **SQL Editor** を開く
2. `supabase/seeds/schools.sql` の内容をコピーして実行

⚠️ **注意**: このファイルは `DELETE FROM public.schools` を実行します。既存の schools と、それに紐づく profile_schools が削除されます。既にユーザーが学校を登録している場合は実行しないでください。

---

## 4. デモデータの投入（同級生マップ用）

**奈良中学校 1989年卒 10人** と **中央大学附属高校 1992年卒 10人** を投入する場合：

1. **SQL Editor** を開く
2. `supabase/seeds/supabase_demo_seed.sql` の内容をコピーして実行

このファイルは以下を行います：

- 奈良中学校・中央大学附属高校 を schools に追加（存在しない場合のみ）
- デモプロフィール20人を削除して再投入
- 既存の schools や他ユーザーのデータは変更しません

**再実行可能**: 何度実行しても安全です（demo_seed_* のみ削除・再投入）。

---

## 5. 実行後の確認

| 確認項目 | 手順 |
|----------|------|
| 同級生マップ | ログイン後 `/map` で「奈良中学校」「1989年」または「中央大学附属高校」「1992年」を選択 |
| 検索 | `/search` で学校・卒業年を指定して20人がヒットするか |
| 居住地表示 | 都道府県タイルに人数が表示されるか（東京・千葉・神奈川・埼玉など） |

---

## 6. シードファイル一覧

| ファイル | 用途 | 実行タイミング |
|----------|------|----------------|
| `schools.sql` | 全国約500校を投入 | 初回セットアップ時（空のDB向け） |
| `supabase_demo_seed.sql` | 奈良中・中大附属の同級生20人 | デモ用・同級生マップ確認用 |
| `demo_10_profiles.sql` | 上記と同じ20人（分割版） | supabase_demo_seed.sql の代替 |
| `dev_test_profiles.sql` | 那覇高・横浜翠嵐の3人 | 検索機能の動作確認用 |

---

## 7. トラブルシューティング

### シード実行時にエラーが出る

- **RLS エラー**: SQL Editor は postgres 権限で実行されるため、通常は RLS をバイパスします。エラーが出る場合は、Supabase ダッシュボードの「Database」→「Roles」で権限を確認してください。
- **学校が見つからない**: `supabase_demo_seed.sql` は奈良中学校・中央大学附属高校を自動作成します。`demo_10_profiles.sql` 単体で実行する場合は、先に `schools.sql` を実行するか、該当2校が schools に存在する必要があります。

### 同級生マップに誰も表示されない

- ログインしているユーザーが 奈良中学校 または 中央大学附属高校 を登録しているか確認
- `supabase_demo_seed.sql` が実行済みか確認
- 学校・卒業年のドロップダウンで正しく選択しているか確認
