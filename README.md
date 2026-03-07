# dotfiles

My personal configuration files, managed with [chezmoi](https://www.chezmoi.io/).

## Managed Files

| ソース | 展開先 |
|---|---|
| `dot_zshrc` | `~/.zshrc` |
| `dot_zprofile` | `~/.zprofile` |
| `dot_gitconfig.tmpl` | `~/.gitconfig` |
| `dot_config/starship.toml` | `~/.config/starship.toml` |
| `dot_config/ghostty/config` | `~/.config/ghostty/config` |
| `private_dot_ssh/config` | `~/.ssh/config` |
| `Library/Application Support/Code/User/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `Library/Application Support/Code/User/keybindings.json` | `~/Library/Application Support/Code/User/keybindings.json` |
| `dot_claude/skills/add-dotfile/SKILL.md` | `~/.claude/skills/add-dotfile/SKILL.md` |

**除外ファイル（git管理外）:**
- `~/.zshrc.local` — マシン固有設定（PATH、環境変数、エイリアスなど）
- `~/.config/gh/` — GitHub CLI 認証情報

## Setup

### 新しいマシン

```zsh
brew install chezmoi
chezmoi init git@github.com:bobtaroh/dotfiles.git
chezmoi diff   # 変更内容を確認
chezmoi apply
```

`chezmoi init` 実行中に以下を対話形式で入力する:

- **Git email address** — マシンで使う git のメールアドレス
- **Git name** — git のユーザー名
- **ghq root directory** — ghq のルートディレクトリ（例: `~/Documents/src`）

入力値は `~/.config/chezmoi/chezmoi.toml` に保存され、以降は聞かれない。

初回セットアップ後、マシン固有の設定を追加:

```zsh
cp $(chezmoi source-path)/.zshrc.local.example ~/.zshrc.local
# ~/.zshrc.local を自分の環境に合わせて編集
```

### 既存マシン（再適用）

```zsh
chezmoi apply
```

## Zsh Configuration

`.zshrc`（共通設定）と `~/.zshrc.local`（マシン固有設定）の2ファイル構成。

- `.zshrc` の末尾で `~/.zshrc.local` を読み込む
- マシン固有の PATH・環境変数・エイリアスは `.zshrc.local` に記述する

## Editor

chezmoi のエディタは VSCode に設定済み（`.chezmoi.toml.tmpl`）。

```zsh
chezmoi edit --apply ~/.zshrc   # VSCode で編集して即反映
```

## VSCode Extensions

インストール済み拡張機能の一覧は `vscode/extensions.txt` で管理。

```zsh
cat $(chezmoi source-path)/vscode/extensions.txt | xargs -L 1 code --install-extension
```

## Useful Commands

```zsh
chezmoi edit --apply <file>   # ファイルを編集して即反映
chezmoi diff                  # 未適用の変更内容を確認
chezmoi apply                 # ホームディレクトリに展開
chezmoi status                # 変更差分の状態確認
chezmoi managed               # chezmoi が管理するファイル一覧
chezmoi verify                # 展開済みファイルとソースの整合性チェック
chezmoi cd                    # ソースディレクトリに移動
```
