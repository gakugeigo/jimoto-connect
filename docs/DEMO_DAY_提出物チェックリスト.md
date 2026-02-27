# デモデイ提出物チェックリスト

デモデイ前日までに提出する項目の確認用です。

---

## 1. GitHub リポジトリ URL

- [ ] 提出フォームに URL を記載
- **URL**: https://github.com/gakugeigo/jimoto-connect
- **README**: セットアップ手順を記載済み（`README.md`）

---

## 2. デプロイしたアプリの URL

- [ ] 提出フォームに URL を記載
- **URL**: https://jimoto-connect.vercel.app/
- **備考**: Vercel 本番環境

---

## 3. プレゼン資料

- [ ] 提出フォームにリンクまたはファイルを記載

**選択肢（いずれか）**:

| 形式 | 内容 |
|------|------|
| **Notebook LM** | Notebook LM で作成したプレゼンの共有リンク |
| **Markdown** | `docs/presentation/NOTEBOOK_LM_発表用ソース.md` |
| **PowerPoint** | `Jimoto-Connect_Overview.pptx`（Downloads に保存済み）を提出先にアップロード |
| **独自 LP** | 本番URLの LP（https://jimoto-connect.vercel.app/）をそのまま使う |

**推奨**: 提出先の形式に合わせて、Notebook LM の共有リンク or pptx ファイルを提出。

---

## 提出前の最終確認

- [ ] `npm run build` が通る
- [ ] 本番URLでログイン・主要機能が動作する
- [ ] Clerk 本番URLが Vercel ドメインで登録済み
- [ ] README のセットアップ手順が最新
