#!/bin/zsh
# =============================================================================
# dotfiles setup script
# =============================================================================

set -e

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
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

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
# chezmoi
# -----------------------------------------------------------------------------
echo ""
echo "Applying dotfiles..."
chezmoi init git@github.com:bobtaroh/dotfiles.git
chezmoi diff
echo ""
read "apply?Apply dotfiles? [y/N] "
if [[ "$apply" == "y" ]]; then
  chezmoi apply
fi

echo ""
echo "Setup complete!"
