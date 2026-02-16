# システム要件定義書：Jimoto-Connect（仮）

## 1. システム概要
### 1.1 目的
地方出身者が、現在の居住地周辺に住む「同郷の仲間」や「共通のバックグラウンド（学校・部活・年代）」を持つ人を見つけ、交流できるプラットフォームを提供する。

### 1.2 技術スタック
- **Frontend**: Next.js (App Router), TypeScript, Tailwind CSS
- **Backend**: Next.js Server Actions / API Routes
- **Database**: Supabase (PostgreSQL)
- **Auth**: Clerk (Supabaseと連携)
- **Infrastructure**: Vercel

## 2. 機能要件

### 2.1 認証機能
- **サインアップ/ログイン**:
  - Clerkを利用したソーシャルログイン（Google推奨）。
  - メールアドレス認証。
- **オンボーディング**:
  - 初回ログイン時にプロフィール登録（出身地、出身校、部活、生まれ年、現在地）を強制するフロー。

### 2.2 プロフィール管理機能
- **基本情報**:
  - ニックネーム、自己紹介、アバター画像。
  - **生まれ年**（検索用、公開/非公開設定可）。
- **ロケーション情報**:
  - **出身地**: 都道府県、市区町村。
  - **現在地**: 都道府県、市区町村、最寄り駅（任意）。
- **バックグラウンド情報**:
  - **出身校**: 中学校、高校（学校マスタから検索・選択）。
  - **部活動**: 学校ごとに所属していた部活を登録（例：高校＝野球部、中学＝サッカー部）。

### 2.3 検索・マッチング機能
- **クロス検索**:
  - 以下の条件を組み合わせてユーザーを検索できる。
    - 出身地（県・市）
    - 現在地（県・市・最寄り駅）
    - 出身校
    - **部活動**（同じ部活だった人）
    - **年代**（同い年、±3歳など）
  - **ユースケース例**: 「現在：東京都世田谷区 × 出身：沖縄県 × 高校部活：野球部 × 年代：1995年生まれ」で検索。
- **近くの同郷人マップ**:
  - 現在地周辺に住む同郷ユーザーを地図上にピン表示（プライバシー保護のため詳細位置はぼかす）。

### 2.4 コミュニティ機能（デジタル居酒屋ノート）
- **学校別掲示板**:
  - 各学校のページに、卒業生が書き込めるスレッド。
- **地域別掲示板**:
  - 「東京在住の沖縄県民」のような、出身地×現在地の組み合わせごとのスレッド。
- **足跡/いいね**:
  - プロフィールや投稿への「懐かしい！（いいね）」アクション。

## 3. データモデル概要 (ER図のベース)

### 3.1 Users / Profiles
Clerkのユーザー情報をSupabaseの`profiles`テーブルに同期・拡張する。

- **profiles**
  - `id` (UUID, PK): Clerk IDと紐付け
  - `email` (Text)
  - `display_name` (Text)
  - `avatar_url` (Text)
  - `bio` (Text)
  - `birth_year` (Integer): 生まれ年（年代検索用）
  - `home_prefecture` (Text): 出身都道府県
  - `home_city` (Text): 出身市区町村
  - `current_prefecture` (Text): 現在の都道府県
  - `current_city` (Text): 現在の市区町村
  - `created_at` (Timestamp)

### 3.2 Schools & Activities
学校と部活の情報を管理。

- **schools** (マスターデータ)
  - `id` (UUID, PK)
  - `name` (Text): 学校名
  - `type` (Text): 'junior_high' | 'high'
  - `prefecture` (Text)
  - `city` (Text)

- **profile_schools** (中間テーブル)
  - `id` (UUID, PK)
  - `profile_id` (UUID, FK -> profiles.id)
  - `school_id` (UUID, FK -> schools.id)
  - `graduation_year` (Integer): 卒業年（任意）
  - `club_activities` (Text[]): 部活動の配列（例: ['baseball', 'band']）
    - ※検索効率化のため、マスタ化またはEnum化を検討するが、MVPではText配列で実装。

### 3.3 Community
- **posts**
  - `id` (UUID, PK)
  - `author_id` (UUID, FK -> profiles.id)
  - `school_id` (UUID, FK -> schools.id, Nullable): 学校掲示板用
  - `region_id` (Text, Nullable): 地域掲示板用（例: 'okinawa-tokyo'）
  - `content` (Text)
  - `image_url` (Text)
  - `created_at` (Timestamp)

## 4. 非機能要件
### 4.1 パフォーマンス
- 検索クエリ（特にJSONや配列を含むクロス検索）の速度を確保するため、適切なインデックスを貼る。
- 地図表示時のピン数が多い場合、クラスタリング（まとめて表示）を行う。

### 4.2 セキュリティ
- **RLS (Row Level Security)**:
  - 自分のプロフィールのみ編集可能。
  - 投稿は誰でも閲覧可能だが、編集・削除は本人のみ。
- **プライバシー**:
  - 現在地の詳細（番地など）は保存しない。市区町村レベルまでとする。

### 4.3 拡張性
- 将来的には「イベント機能（県人会オフ会）」や「ダイレクトメッセージ」を追加可能な設計にする。
