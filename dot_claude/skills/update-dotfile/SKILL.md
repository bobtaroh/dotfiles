---
name: update-dotfile
description: chezmoi で管理済みのdotfileを編集してリポジトリに反映する。更新したいファイルのパスを引数に指定する。例: /update-dotfile ~/.zshrc
disable-model-invocation: true
---

`$ARGUMENTS` を chezmoi で編集してリポジトリに反映する。

**重要**: 引数には必ず**展開先のパス**（`~/.zshrc` など）を指定する。ソースディレクトリ（`~/.local/share/chezmoi/...`）のパスを渡してはいけない。

## 現在の管理状況
- 管理ファイル一覧: !`chezmoi managed`

## 手順

1. 引数のファイルパスが chezmoi の管理対象かを `chezmoi managed` で確認する
   - 管理対象でない場合は `/add-dotfile` スキルを使うよう案内して終了する
2. `chezmoi edit --apply $ARGUMENTS` を実行する（VSCode が開く）
3. ユーザーが編集・保存・タブを閉じるのを待つ
4. `chezmoi diff` で変更内容を確認する
   - 差分がない場合は「変更はありませんでした」と伝えて終了する
5. 変更内容をユーザーに提示して、コミットメッセージの方向性を確認する
6. ソースディレクトリで git add・commit・push する
   - コミットメッセージ: `chore: update $ARGUMENTS`

## 注意事項

- テンプレートファイル（`.tmpl` 拡張子）の場合、編集はソースの `.tmpl` ファイルに対して行われる
- git push は SSH 経由で行う（`cd ~/.local/share/chezmoi && git push`）
