# dotfiles

My personal configuration files, managed with [chezmoi](https://www.chezmoi.io/).

## Managed Files

| ソース | 展開先 |
|---|---|
| `dot_zshrc` | `~/.zshrc` |
| `dot_config/starship.toml` | `~/.config/starship.toml` |
| `dot_config/ghostty/config` | `~/.config/ghostty/config` |
| `Library/Application Support/Code/User/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `Library/Application Support/Code/User/keybindings.json` | `~/Library/Application Support/Code/User/keybindings.json` |

**除外ファイル（git管理外）:**
- `dot_config/gh/` — GitHub CLI 認証情報

## Setup

### 新しいマシン

```zsh
brew install chezmoi
chezmoi init --source ~/dotfiles github.com/bobtaroh/dotfiles
chezmoi apply
```

### 既存マシン（再適用）

```zsh
chezmoi apply
```

## Zsh Configuration

`.zshrc`（共通設定）と `~/.zshrc.local`（マシン固有設定）の2ファイル構成。

- `.zshrc` の末尾で `~/.zshrc.local` を読み込む
- マシン固有のPATH・環境変数・エイリアスは `.zshrc.local` に記述する

初回セットアップ:
```zsh
cp ~/dotfiles/.zshrc.local.example ~/.zshrc.local
# ~/.zshrc.local を自分の環境に合わせて編集
```

## VSCode Extensions

インストール済み拡張機能の一覧は `vscode/extensions.txt` で管理。

```zsh
cat ~/dotfiles/vscode/extensions.txt | xargs -L 1 code --install-extension
```

## Useful Commands

```zsh
chezmoi diff      # 未適用の変更内容を確認
chezmoi apply     # ホームディレクトリに展開
chezmoi status    # 変更差分の状態確認
chezmoi managed   # chezmoi が管理するファイル一覧
chezmoi verify    # 展開済みファイルとソースの整合性チェック
```
