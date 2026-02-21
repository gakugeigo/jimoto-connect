# サイト現状把握

Jimoto-Connect の現在の実装状況を一覧で把握するためのドキュメントです。

---

## 1. ルート一覧（URL と役割）

| URL | 役割 | 認証 |
|-----|------|------|
| `/` | LP（デザイン1） | 不要（ログイン済みなら /dashboard へリダイレクト） |
| `/v2` | LP（デザイン2・レトロ×モダン） | 不要（ログイン済みなら /v2/dashboard へ） |
| `/sign-in` | ログイン | 不要 |
| `/sign-up` | サインアップ | 不要 |
| `/onboarding` | 初回登録（氏名・居住地・学校・部活・卒業年） | 要 |
| `/dashboard` | メインダッシュボード（学校掲示板・帰省中・部室） | 要 |
| `/v2/dashboard` | ダッシュボード（デザイン2） | 要 |
| `/profile` | 自分のプロフィール編集 | 要 |
| `/search` | 同窓生検索 | 要 |
| `/map` | 居住地マップ（都道府県タイル） | 要 |
| `/groups` | マイグループ一覧 | 要 |
| `/groups/[id]` | グループ詳細・投稿 | 要 |
| `/groups/join/[token]` | 招待リンクで参加 | 要 |
| `/events` | イベント一覧 | 要 |
| `/events/new` | イベント作成 | 要 |
| `/events/[id]` | イベント詳細・参加 | 要 |
| `/users/[id]` | 他ユーザープロフィール | 要 |

---

## 2. 機能の実装状況

| 機能 | 状態 | 備考 |
|------|------|------|
| LP（2種類） | ✅ | `/` と `/v2` |
| 認証（Clerk） | ✅ | サインイン・サインアップ |
| オンボーディング | ✅ | 中学・高校、部活、卒業年、居住地 |
| 学校掲示板 | ✅ | 全体/同級生/部活OB タブ、投稿・いいね・コメント |
| 同窓生検索 | ✅ | 学校・卒業年・部活・居住地・帰省中でフィルタ |
| 居住地マップ | ✅ | 都道府県タイル、タップで一覧 |
| プロフィール | ✅ | 業界・職種・旧姓・帰省中・アバター |
| グループ | ✅ | 作成・参加・招待リンク、投稿 |
| イベント | ✅ | 作成・参加・キャンセル・削除 |
| 帰省中チェックイン | ✅ | ダッシュボード・プロフィールでトグル |

---

## 3. ローカルで確認する手順

```bash
# 開発サーバー起動
npm run dev
```

| 確認したいこと | アクセス先 |
|----------------|------------|
| LP（デザイン1） | http://localhost:3000 |
| LP（デザイン2） | http://localhost:3000/v2 |
| ログイン | http://localhost:3000/sign-in |
| サインアップ | http://localhost:3000/sign-up |
| ダッシュボード | ログイン後 http://localhost:3000/dashboard |
| v2 ダッシュボード | ログイン後 http://localhost:3000/v2/dashboard |
| 検索 | http://localhost:3000/search |
| マップ | http://localhost:3000/map |
| プロフィール | http://localhost:3000/profile |
| グループ | http://localhost:3000/groups |
| イベント | http://localhost:3000/events |

---

## 4. 技術スタック

| 項目 | 使用技術 |
|------|----------|
| フレームワーク | Next.js (App Router) |
| 認証 | Clerk |
| DB | Supabase (PostgreSQL) |
| スタイル | Tailwind CSS |
| デプロイ | Vercel（過去にデプロイ済み） |

---

## 5. データベース主要テーブル

| テーブル | 役割 |
|----------|------|
| profiles | ユーザー情報（氏名・居住地・業界・職種・帰省中など） |
| profile_schools | 出身校・卒業年・部活 |
| schools | 学校マスタ |
| posts | 掲示板投稿（board_type: all/classmates/club） |
| likes | 投稿へのいいね |
| comments | 投稿へのコメント |
| groups | グループ |
| group_members | グループメンバー |
| events | イベント |
| event_attendances | イベント参加 |

---

## 6. 未実施・後回し

| 項目 | 備考 |
|------|------|
| Clerk 本番URL登録 | デプロイ後に実施予定 |
| 同じ学校×同じ職種で検索 | 今後検討 |
| v2 の profile/search/map 等 | 現状はメインのパスへリンク |

---

## 7. ドキュメント一覧

| ファイル | 内容 |
|----------|------|
| `SUPABASE_SETUP.md` | Supabase セットアップ・シード投入手順 |
| `DEV_TEST_GUIDE.md` | 開発用テストデータ投入・動作確認 |
| `REMAINING_TASKS_デモデイまで.md` | 残タスク・優先度 |
| `FUTURE_FEATURES.md` | 今後実装する機能 |
| `DEMO_DAY_PRESENTATION.md` | プレゼン資料 |
| `DEMO_DAY_準備ガイド.md` | デモデイ準備 |
| `SITE_STATUS_現状把握.md` | 本ドキュメント |
