# dotfiles

My personal configuration files.

## Managed Files
- `.zshrc`: Zsh configuration
- `.config/ghostty`: Ghostty terminal configuration
- `.config/starship.toml`: Starship prompt configuration
- `.config/gh`: GitHub CLI configuration
- `vscode/`: VSCode settings and extensions list

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
