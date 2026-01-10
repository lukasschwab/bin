#!/bin/bash
# bin-setup.sh sets up a fresh macOS machine with CLI tools, GUI apps, and dotfiles.
#
# Requires Homebrew. See README for full setup instructions.
#
# Usage:
#   ~/bin/bin-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# -----------------------------------------------------------------------------
# CLI Tools (requires Homebrew)
# -----------------------------------------------------------------------------
brew install \
    ag \
    bat \
    basictex \
    colordiff \
    direnv \
    fzf \
    gemini-cli \
    gh \
    ghostscript \
    go \
    gum \
    imagemagick \
    jq \
    neovim \
    ocrmypdf \
    pandoc \
    tmux \
    uv \
    watchman \
    webp \
    yt-dlp

# -----------------------------------------------------------------------------
# GUI Applications (Casks)
# -----------------------------------------------------------------------------
brew install --cask \
    1password \
    claude-code \
    ghostty \
    google-chrome \
    obsidian \
    rectangle \
    tailscale-app \
    visual-studio-code \
    vlc \
    zed

# -----------------------------------------------------------------------------
# Directories
# -----------------------------------------------------------------------------
mkdir -p ~/Programming
mkdir -p ~/.config/nvim

# -----------------------------------------------------------------------------
# Oh My Zsh
# -----------------------------------------------------------------------------
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Plugins
if [ ! -d ~/.oh-my-zsh/custom/plugins/command-time ]; then
    git clone https://github.com/popstas/zsh-command-time.git \
        ~/.oh-my-zsh/custom/plugins/command-time
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# -----------------------------------------------------------------------------
# Dotfiles (symlinks)
# -----------------------------------------------------------------------------
# Neovim config
ln -sf "$SCRIPT_DIR/dotfiles/nvim/init.lua" ~/.config/nvim/init.lua

# Zsh theme
ln -sf "$SCRIPT_DIR/dotfiles/zsh/lukas.zsh-theme" ~/.oh-my-zsh/custom/themes/lukas.zsh-theme

# -----------------------------------------------------------------------------
# Git Configuration
# -----------------------------------------------------------------------------
echo ""
if gum confirm "Configure git user.name and user.email?"; then
    CURRENT_NAME=$(git config --global user.name 2>/dev/null || echo "")
    CURRENT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")
    GIT_NAME=$(gum input --placeholder "Your Name" --value "$CURRENT_NAME" --header "Git user.name:")
    GIT_EMAIL=$(gum input --placeholder "your_email@example.com" --value "$CURRENT_EMAIL" --header "Git user.email:")
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
    echo "Git configured: $GIT_NAME <$GIT_EMAIL>"
else
    echo "Skipping git configuration."
fi

# -----------------------------------------------------------------------------
# Post-install
# -----------------------------------------------------------------------------
echo ""
echo "=== Setup complete ==="
echo ""
echo "Manual steps:"
echo "1. Run 'gh auth login' to authenticate GitHub CLI"
echo "2. Create ~/.zshrc with: source ~/bin/binrc"
echo "3. Run 'source ~/.zshrc' to reload shell configuration"
