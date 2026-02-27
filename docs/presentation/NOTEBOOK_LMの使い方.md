# Notebook LM でプレゼン資料を作る手順

## 1. 準備するもの

- `NOTEBOOK_LM_発表用ソース.md` … 発表内容のテキスト
- `screenshots/` 内の画像 … LP, onboarding, dashboard, search, events, map

## 2. Notebook LM での操作

### 方法A: テキストのみで生成

1. [Notebook LM](https://notebooklm.google.com) を開く
2. 新しいノートブックを作成
3. **Add source** で `NOTEBOOK_LM_発表用ソース.md` をアップロード（または内容をコピペ）
4. **Generate** → **Presentation** を選択
5. 生成されたスライドに、後から画像を手動で挿入

### 方法B: テキスト＋画像をまとめてアップロード

1. `NOTEBOOK_LM_発表用ソース.md` と `screenshots/` 内の画像を、1つのフォルダにまとめる
2. または、Markdown に画像を埋め込んだ PDF / Google ドキュメントを作成
3. Notebook LM にその PDF やドキュメントをアップロード
4. **Generate** → **Presentation** でスライドを生成

### 方法C: Google ドキュメントで下準備

1. Google ドキュメントを新規作成
2. `NOTEBOOK_LM_発表用ソース.md` の内容を貼り付け
3. 各スライドの該当箇所に画像を挿入
4. その Google ドキュメントを Notebook LM のソースとして追加
5. プレゼン生成

## 3. 画像のファイル名

ソース内で参照しているファイル名と合わせてください。

- lp.png
- onboarding.png
- dashboard.png
- search.png
- events.png
- map.png

保存した画像の名前が違う場合は、`NOTEBOOK_LM_発表用ソース.md` の【画像: ○○】の部分を実際のファイル名に合わせて修正してください。

## 4. 生成後の確認

- スライドの順番が想定どおりか
- 画像が正しいスライドに入っているか
- テキストの誤字・脱字
- 本番URL・リポジトリURLが正しいか

## 5. エクスポート

Notebook LM で生成したプレゼンは、Google スライドにエクスポートできます。
必要に応じてデザインやレイアウトを調整してください。
