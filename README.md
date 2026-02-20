# Jimoto-Connect

同窓生・同郷の仲間を見つけてつながる SNS アプリ。出身校・部活・居住地で検索し、オフライン交流を促すイベント機能も備えています。

## 技術スタック

- **Frontend**: Next.js 16 (App Router) + TypeScript + Tailwind CSS
- **Backend**: Next.js Server Actions
- **Database**: Supabase (PostgreSQL)
- **Auth**: Clerk (Google / Email ログイン)
- **Deploy**: Vercel

## セットアップ手順

### 1. リポジトリのクローン

```bash
git clone https://github.com/gakugeigo/jimoto-connect.git
cd jimoto-connect
```

### 2. 依存関係のインストール

```bash
npm install
```

### 3. 環境変数の設定

プロジェクトルートに `.env.local` を作成し、以下の変数を設定してください。

```env
# Clerk（認証）
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_xxxxx
CLERK_SECRET_KEY=sk_xxxxx

# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJxxxxx
SUPABASE_SERVICE_ROLE_KEY=eyJxxxxx
```

- **Clerk**: [Clerk Dashboard](https://dashboard.clerk.com) でプロジェクト作成後、API Keys から取得
- **Supabase**: [Supabase Dashboard](https://supabase.com/dashboard) でプロジェクト作成後、Settings > API から取得

### 4. Supabase マイグレーションの実行

Supabase ダッシュボードの **SQL Editor** で、以下のマイグレーションファイルを**順番に**実行してください。

1. `supabase/migrations/20260216120000_create_initial_schema.sql`
2. `supabase/migrations/20260216140000_add_maiden_name.sql`
3. `supabase/migrations/20260216150000_create_storage_bucket.sql`
4. `supabase/migrations/20260219120000_create_groups.sql`
5. `supabase/migrations/20260219130000_add_profile_extended.sql`
6. `supabase/migrations/20260220120000_create_events.sql`

**手順**: 各ファイルを開く → 全文コピー → SQL Editor に貼り付け → Run

### 5. 開発サーバーの起動

```bash
npm run dev
```

ブラウザで [http://localhost:3000](http://localhost:3000) を開いてください。

### 6. （任意）テストデータの投入

検索・プロフィール機能の動作確認用に、`supabase/seeds/dev_test_profiles.sql` を SQL Editor で実行するとテストユーザーが追加されます。詳細は `docs/DEV_TEST_GUIDE.md` を参照してください。

## 主な機能

- **オンボーディング**: 初回ログイン時に出身地・出身校・部活・現在地を登録
- **ダッシュボード**: 学校掲示板の投稿一覧、いいね・コメント
- **同窓生検索**: 学校・卒業年・部活・居住地・帰省中で絞り込み
- **マイグループ**: 招待リンクで参加する LINE 風グループ
- **同窓会イベント**: イベント作成・参加申し込み
- **帰省中チェックイン**: 「今地元に帰省中」の登録・解除
- **業界・職種**: プロフィールに業界・職種を登録（その他で自由入力可）

## ドキュメント

- `docs/FUNCTION_ROADMAP.md` - 機能ロードマップ
- `docs/DEV_TEST_GUIDE.md` - 開発時の動作確認
- `docs/GROUPS_MIGRATION.md` - マイグループのマイグレーション手順
- `docs/EVENTS_MIGRATION.md` - イベント機能のマイグレーション手順

## ビルド

```bash
npm run build
```

## ライセンス

Private
