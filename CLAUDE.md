# CLAUDE.md

## プロジェクト概要

chezmoi で管理する個人dotfilesリポジトリ。
ソースディレクトリ: `~/.local/share/chezmoi`（`chezmoi cd` で移動）

## 重要なルール

- ファイルの編集は必ず `~/.local/share/chezmoi/` 内のソースファイルに対して行う
- ホームディレクトリのファイル（`~/.zshrc` など）は出力物であり直接編集しない
- 編集後は `chezmoi apply` で反映し、git push で GitHub に同期する
- 機密情報（認証情報、トークン）は絶対に追加しない

## ファイル命名規則（chezmoi）

| ソース名 | 展開先 |
|---|---|
| `dot_foo` | `~/.foo` |
| `dot_foo.tmpl` | `~/.foo`（テンプレート） |
| `private_dot_foo` | `~/.foo`（パーミッション700） |
| `dot_config/foo` | `~/.config/foo` |

## よく使うコマンド

```sh
chezmoi edit --apply ~/.zshrc   # ファイルを編集して即反映（展開先パスを指定）
chezmoi diff                    # 未適用の変更内容を確認
chezmoi apply                   # ホームディレクトリに展開
chezmoi managed                 # 管理ファイル一覧
chezmoi verify                  # 整合性チェック
```

## テンプレート変数（~/.config/chezmoi/chezmoi.toml）

`dot_gitconfig.tmpl` などのテンプレートで使用するマシン固有の値。
新マシンでは `chezmoi init` 時に対話形式で入力する。

| 変数 | 用途 |
|---|---|
| `gitEmail` | git のメールアドレス |
| `gitName` | git のユーザー名 |
| `ghqRoot` | ghq のルートディレクトリ |

## Brewfile 構成

| ファイル | 用途 |
|---|---|
| `Brewfile` | 共通ツール（全マシン） |
| `Brewfile.personal` | 個人PC専用 |
| `Brewfile.work` | 会社PC専用（会社固有ツールを追記） |

## スキル

| スキル | 用途 |
|---|---|
| `/add-dotfile <展開先パス>` | 新しいファイルをchezmoi管理対象に追加 |
| `/update-dotfile <展開先パス>` | 管理済みファイルを編集して反映 |

## 除外ファイル

- `~/.zshrc.local` — マシン固有設定（git管理外）
- `~/.config/gh/` — GitHub CLI 認証情報
- `~/.claude/` — Claude Code の設定（skills/ ディレクトリを除く）
