# 最終課題 残タスク一覧

本番稼働を見据えたオリジナルWebアプリ開発の提出物チェックリストです。

---

## 必須要件（5要素）の達成状況

| 要件 | 状態 | 備考 |
|------|------|------|
| フロントエンドUI | ✅ 完了 | Next.js + TypeScript、学校掲示板・検索・イベント等 |
| バックエンド/サーバー | ✅ 完了 | Next.js Server Actions |
| データベース永続化 | ✅ 完了 | Supabase (PostgreSQL) |
| 認証 | ✅ 完了 | Clerk（サインアップ/ログイン） |
| デプロイ | ✅ 完了 | Vercel（GitHub連携） |

---

## 提出物チェックリスト（デモデイ前日まで）

| 提出物 | 状態 | 備考 |
|--------|------|------|
| GitHubリポジトリURL | 要確認 | README にセットアップ手順あり ✅ |
| デプロイしたアプリのURL | 要確認 | Vercel 本番URL |
| プレゼン資料 | 要確認 | `docs/DEMO_DAY_PRESENTATION.md` あり。Genspark/Notebook LM でスライド化が必要 |

---

## 必須チェックポイント（デプロイ前に必ず確認）

| チェック | 状態 | 対応 |
|----------|------|------|
| `npm run build` がローカルで通る | 要確認 | 実行して確認 |
| `.env` の本番用キーが Vercel に設定済み | 要確認 | Clerk / Supabase のキーを Vercel に登録 |
| Supabase の RLS ポリシー設定済み | 要確認 | マイグレーションに含まれているか確認 |

---

## 今日やるべき残タスク（優先順）

### 🔴 高優先（本番動作に必須）

1. **Clerk 本番URL登録**
   - Clerk Dashboard → Domains に Vercel 本番URL（例: `https://xxx.vercel.app`）を追加
   - サインイン/サインアップのリダイレクトが本番で動作するために必須

2. **Vercel 環境変数の確認**
   - Vercel プロジェクト → Settings → Environment Variables
   - `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY`, `CLERK_SECRET_KEY`
   - `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`
   - 本番用の値を設定

3. **`npm run build` の成功確認**
   - ローカルで `npm run build` を実行
   - エラーがあれば修正

4. **本番動作確認**
   - 本番URLでサインアップ → オンボーディング → ダッシュボードの一連フローを確認

### 🟡 中優先（デモデイ発表用）

5. **プレゼン資料のスライド化**
   - `docs/DEMO_DAY_PRESENTATION.md` を Genspark / Notebook LM / Cursor でスライド形式に変換
   - PowerPoint/Keynote/Canva の手動作成は禁止

6. **デモの準備**
   - 実機操作: 本番URLを開き、テストアカウントでログイン済みに
   - 録画: 1〜2分のデモ動画を用意

7. **README の更新確認**
   - マイグレーション一覧が最新か確認（DM など追加分があれば記載）

### 🟢 低優先（時間があれば）

8. **Supabase RLS の再確認**
   - 各テーブルのポリシーが適切か確認

9. **デモ用シードデータ**
   - 本番DBにテストデータを投入するか検討

---

## 発表構成（10分程度）

1. プロダクト概要（課題・解決策・主要画面）
2. 技術構成（アーキテクチャ、使用サービス）
3. ビルド&デプロイで工夫した点
4. 今後のロードマップ
5. デモ（実機操作 or 録画）

---

## 参考ドキュメント

| ファイル | 内容 |
|----------|------|
| `REMAINING_TASKS_デモデイまで.md` | 残タスク・優先度（既存） |
| `DEMO_DAY_PRESENTATION.md` | プレゼン資料の元データ |
| `DEMO_DAY_準備ガイド.md` | スライド生成・デモ準備の手順 |
| `SITE_STATUS_現状把握.md` | サイト現状 |
