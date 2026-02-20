# Vercel デプロイ手順

## ステップ1: Vercel にログイン・GitHub 連携

1. ブラウザで **https://vercel.com** を開く
2. **「Log in」** または **「Sign Up」** をクリック
3. **「Continue with GitHub」** を選択して GitHub アカウントでログイン
4. 初回の場合、Vercel が GitHub のリポジトリにアクセスする許可を求められたら **「Authorize」** をクリック

---

## ステップ2: プロジェクトのインポート

1. Vercel ダッシュボードで **「Add New...」** → **「Project」** をクリック
2. **「Import Git Repository」** の一覧から **`gakugeigo/jimoto-connect`** を探して選択
   - 表示されない場合: **「Import Third-Party Git Repository」** で `https://github.com/gakugeigo/jimoto-connect` を入力
3. **「Import」** をクリック

---

## ステップ3: プロジェクト設定（そのまま進めてOK）

- **Framework Preset**: Next.js（自動検出）
- **Root Directory**: `./`（そのまま）
- **Build Command**: `next build`（そのまま）
- **Output Directory**: `.next`（そのまま）

**「Deploy」はまだ押さない。** 次で環境変数を設定する。

---

## ステップ4: 環境変数の設定

**「Environment Variables」** のセクションで、以下の6つを追加する。

| 名前 | 値 | 取得元 |
|------|-----|--------|
| `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY` | `pk_xxxxx` | Clerk Dashboard → API Keys |
| `CLERK_SECRET_KEY` | `sk_xxxxx` | Clerk Dashboard → API Keys |
| `NEXT_PUBLIC_SUPABASE_URL` | `https://xxxxx.supabase.co` | Supabase → Settings → API |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | `eyJxxxxx` | Supabase → Settings → API |
| `SUPABASE_SERVICE_ROLE_KEY` | `eyJxxxxx` | Supabase → Settings → API |

**重要**: ローカルの `.env.local` と同じ値を使う。本番用に別の Clerk / Supabase プロジェクトを作る場合は、そのプロジェクトのキーを入れる。

各変数は **Production / Preview / Development** の3つにチェックを入れて保存。

---

## ステップ5: デプロイ実行

1. **「Deploy」** をクリック
2. ビルドが始まる（1〜3分程度）
3. 完了すると **「Congratulations!」** と表示され、本番URLが発行される
   - 例: `https://jimoto-connect-xxxxx.vercel.app`

---

## ステップ6: Clerk に本番URLを登録（必須）

デプロイ後、Clerk がリダイレクトできるように本番URLを登録する。

1. **Clerk Dashboard** (https://dashboard.clerk.com) を開く
2. プロジェクトを選択 → **「Configure」** → **「Paths」** または **「Domains」**
3. **「Allowed redirect URLs」** に以下を追加:
   - `https://あなたのVercelのURL.vercel.app`
   - `https://あなたのVercelのURL.vercel.app/sign-in`
   - `https://あなたのVercelのURL.vercel.app/sign-up`
4. **「Save」** をクリック

※ カスタムドメインを使う場合は、そのドメインも追加する。

---

## ステップ7: 動作確認

1. 発行された Vercel のURLをブラウザで開く
2. トップページが表示されることを確認
3. **「はじめる」** からサインアップ → オンボーディング → ダッシュボードまで進める
4. エラーが出た場合は、Vercel の **Deployments** → 該当デプロイ → **「View Function Logs」** でエラーログを確認

---

## トラブルシューティング

| 現象 | 対処 |
|------|------|
| ビルド失敗 | Vercel のビルドログを確認。`npm run build` がローカルで通るか確認 |
| サインイン後に白画面 | Clerk の Allowed redirect URLs に本番URLが入っているか確認 |
| データが表示されない | Supabase の本番プロジェクトでマイグレーションが実行済みか確認 |
| RLS エラー | Supabase の RLS ポリシーが有効か、Clerk の JWT 連携が設定されているか確認 |

---

## デプロイの解除（プロジェクト削除）

1. Vercel ダッシュボードでプロジェクトを開く
2. **「Settings」** タブ
3. 一番下の **「Delete Project」** をクリック
4. プロジェクト名を入力して確認

※ GitHub のリポジトリは削除されない。
