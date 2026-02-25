# dotfiles

My personal configuration files.

## Managed Files
- `.zshrc`: Zsh configuration
- `.config/ghostty`: Ghostty terminal configuration

## Setup
To manage your configuration files, create a symbolic link from the home directory to this repository.

### Usage
```bash
ln -s [Path to source file in dotfiles] [Path to target location]
```

### Examples
```bash
# zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc

# config files
ln -s ~/dotfiles/.config/ghostty ~/.config/ghostty
ln -s ~/dotfiles/.config/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/.config/gh ~/.config/gh
```
