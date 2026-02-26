# dotfiles

My personal configuration files.

## Managed Files
- `.zshrc`: Zsh共通設定（シンボリックリンクで `~/.zshrc` に配置）
- `.zshrc.local.example`: マシン固有設定のテンプレート
- `.config/ghostty`: Ghostty terminal configuration
- `.config/starship.toml`: Starship prompt configuration
- `.config/gh`: GitHub CLI configuration
- `vscode/`: VSCode settings and extensions list

## Zsh Configuration

`.zshrc`（共通設定）と `~/.zshrc.local`（マシン固有設定）の2ファイル構成。

```
dotfiles/.zshrc              # 共通設定（git管理）
dotfiles/.zshrc.local.example # ローカル設定のテンプレート（git管理）

~/.zshrc       -> dotfiles/.zshrc へのシンボリックリンク
~/.zshrc.local -> マシン固有設定（git管理外）
```

- `.zshrc` は `command -v` や `[[ -d/-f ... ]]` ガード付きで、ツールが未インストールの環境でも安全に動作する
- `.zshrc` の末尾で `~/.zshrc.local` を読み込む
- マシン固有のPATH・環境変数・エイリアスは `.zshrc.local` に記述する

初回セットアップ:
```zsh
cp ~/dotfiles/.zshrc.local.example ~/.zshrc.local
# ~/.zshrc.local を自分の環境に合わせて編集
```

## Setup
To manage your configuration files, create a symbolic link from the home directory to this repository.

### Usage
```zsh
ln -s [Path to source file in dotfiles] [Path to target location]
```

### Examples
```zsh
# zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc

# config files
ln -s ~/dotfiles/.config/ghostty ~/.config/ghostty
ln -s ~/dotfiles/.config/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/.config/gh ~/.config/gh

# VSCode
ln -s ~/dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
ln -s ~/dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
```

### VSCode Extensions
To install all extensions from the list:
```zsh
cat ~/dotfiles/vscode/extensions.txt | xargs -L 1 code --install-extension
```
