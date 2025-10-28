# GEMINI.md

## 概要

このドキュメントは、LaTeX テンプレートリポジトリで Gemini CLI を活用するためのガイドです。  
WebSearch を活用して、LaTeX のパッケージ、ドキュメント作成のベストプラクティス、CI/CD の改善点を調べる際の手順をまとめています。

---

## 事前チェック

1. `utility/start.sh` または `utility/start.py` を実行し、必須ディレクトリと環境を整備する  
2. `utility/check_env.py` で `latexmk` と `lualatex` が利用可能か確認する  
3. Gemini API キーを `export GEMINI_API_KEY=...` などの環境変数で設定する  
4. `.gitignore` により API キーや一時ファイルがコミットされないことを確認する

---

## 典型的な検索パターン

```bash
# LuaLaTeX の設定例
gemini --prompt "WebSearch: LuaLaTeX japanese typesetting best practices 2024"

# BibLaTeX を使った参考文献管理
gemini --prompt "WebSearch: biblatex bibliography styles overview"

# latexmkrc のチューニング
gemini --prompt "WebSearch: latexmk rc file examples for continuous integration"

# GitHub Actions での LaTeX 自動ビルド
gemini --prompt "WebSearch: github actions latexmk workflow example"
```

### 検索結果の扱い

- 新しいパッケージや設定は `tex/preamble.tex` や `latexmkrc` に反映する前に `workbench/` で検証する  
- 有益な記事は `plan/current-sprint.md` などにメモし、再現手順を共有する  
- コード片を採用する場合はフォーマットとコメントスタイルを既存ファイルに合わせる

---

## よくあるトピック

| トピック | 推奨クエリ | 備考 |
| --- | --- | --- |
| LuaLaTeX のフォント設定 | `WebSearch: LuaLaTeX fontspec examples` | 日本語フォント利用時はフォント名まで指定する |
| TikZ 図のテンプレート | `WebSearch: TikZ diagram gallery` | 取得したコードは `figures/` の素材と合わせて整理する |
| TeX Live の最小構成 | `WebSearch: minimal texlive install luaLaTeX` | CI/CD でのパッケージ不足回避に役立つ |
| latexmk のエラー解決 | `WebSearch: latexmk error explanation` | エラー文と一緒にクエリすると精度が上がる |

---

## トラブルシューティング

- **API キーエラー**: `GEMINI_API_KEY` が設定されているか、レート制限に達していないか確認する  
- **結果が古い**: クエリに年号や「latest」を付ける  
- **期待と違う結果**: 目的・出力形式（例: *「LaTeX longtable example」*）を明記する  
- **ネットワーク失敗**: プロキシ設定や VPN の状態を確認する

---

## 次のアクション

1. 取得した情報を `workbench/scripts/` でスクリプト化して再現性を確保  
2. `utility/check_env.py` を再度実行し、設定変更が整合しているか確認  
3. 問題が解決したらドキュメント（README やセクションファイル）に反映し、チームと共有する  
4. 共有ルールを更新する場合は `python sharing/ai-driven-coding.py` を実行し、`sharing/ai-driven-coding.md` を再生成する

Gemini CLI を活用して最新情報を収集し、LaTeX ドキュメント作成の品質と速度を向上させましょう。
