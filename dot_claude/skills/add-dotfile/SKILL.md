---
name: add-dotfile
description: 新しいdotfileをchezmoiリポジトリに追加して管理対象にする。追加したいファイルのパスを引数に指定する。例: /add-dotfile ~/.gitconfig
disable-model-invocation: true
---

`$ARGUMENTS` を chezmoi の管理対象に追加する。

## 現在の管理状況
- 管理ファイル一覧: !`chezmoi managed`

## 手順

1. 引数のファイルパスを確認する
2. `chezmoi add $ARGUMENTS` を実行してソースディレクトリに追加する
3. 追加されたソースファイルのパスを `chezmoi source-path $ARGUMENTS` で確認する
4. `chezmoi status` で状態を確認する
5. ソースディレクトリで git add・commit・push する
   - コミットメッセージ: `feat: add $ARGUMENTS to chezmoi`
6. README.md の Managed Files テーブルを更新する（ソースパスと展開先を追記）
7. README の変更も git add・commit・push する

## 注意事項

- 機密情報を含むファイル（認証情報、トークンなど）は追加しない
- マシン固有の設定は `~/.zshrc.local` で管理し、chezmoi には追加しない
- git push は SSH 経由で行う（`cd ~/.local/share/chezmoi && git push`）
