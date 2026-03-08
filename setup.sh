#!/bin/zsh
# =============================================================================
# dotfiles setup script
#
# Usage:
#   git clone git@github.com:bobtaroh/dotfiles.git ~/dotfiles-tmp
#   ~/dotfiles-tmp/setup.sh
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# -----------------------------------------------------------------------------
# Homebrew
# -----------------------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# -----------------------------------------------------------------------------
# Machine type
# -----------------------------------------------------------------------------
echo ""
echo "Which machine is this?"
echo "  [1] personal"
echo "  [2] work"
echo ""
read "machine?Enter 1 or 2: "

if [[ "$machine" != "1" && "$machine" != "2" ]]; then
  echo "Invalid input. Exiting."
  exit 1
fi

# -----------------------------------------------------------------------------
# Install packages
# -----------------------------------------------------------------------------
echo ""
echo "Installing common packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

if [[ "$machine" == "1" ]]; then
  echo ""
  echo "Installing personal packages..."
  brew bundle --file="$DOTFILES_DIR/Brewfile.personal"
else
  echo ""
  echo "Installing work packages..."
  brew bundle --file="$DOTFILES_DIR/Brewfile.work"
fi

# -----------------------------------------------------------------------------
# ghq root
# -----------------------------------------------------------------------------
echo ""
read "ghq_root?ghq root directory [~/Documents/src]: "
ghq_root="${ghq_root:-$HOME/Documents/src}"
git config --global ghq.root "$ghq_root"

# -----------------------------------------------------------------------------
# chezmoi
# -----------------------------------------------------------------------------
echo ""
echo "Applying dotfiles..."
chezmoi init git@github.com:bobtaroh/dotfiles.git

# ghq からchezmoiソースディレクトリへシンボリックリンクを作成
ghq_dotfiles="$ghq_root/github.com/bobtaroh/dotfiles"
mkdir -p "$(dirname "$ghq_dotfiles")"
if [[ ! -e "$ghq_dotfiles" ]]; then
  ln -s "$(chezmoi source-path)" "$ghq_dotfiles"
  echo "Created symlink: $ghq_dotfiles -> $(chezmoi source-path)"
fi
chezmoi diff
echo ""
read "apply?Apply dotfiles? [y/N] "
if [[ "$apply" == "y" ]]; then
  chezmoi apply
fi

# -----------------------------------------------------------------------------
# zshrc.local
# -----------------------------------------------------------------------------
if [[ ! -f "$HOME/.zshrc.local" ]]; then
  cp "$(chezmoi source-path)/.zshrc.local.example" "$HOME/.zshrc.local"
  echo ""
  echo "Created ~/.zshrc.local from example. Edit it for machine-specific settings."
fi

echo ""
echo "Setup complete!"
echo "Please restart your terminal."
