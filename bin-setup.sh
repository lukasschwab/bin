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
	glow \
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
	wget \
    yt-dlp

# -----------------------------------------------------------------------------
# GUI Applications (Casks)
# -----------------------------------------------------------------------------
brew install --cask \
    1password \
	caffeine \
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
# macOS System Preferences
# -----------------------------------------------------------------------------
echo ""
if gum confirm "Configure macOS system preferences?" --default=true; then
    echo ""
    echo "--- Trackpad Settings ---"

    # Trackpad speed (default is 1.0, higher = faster)
    if gum confirm "Set trackpad speed to fast (1.5)?" --default=true; then
        defaults write -g com.apple.trackpad.scaling -float 1.5
        echo "Trackpad speed set to 1.5"
    fi

    # Natural scrolling (true = natural/inverted, false = traditional)
    if gum confirm "Disable natural scrolling (use traditional scroll direction)?" --default=true; then
        defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
        echo "Natural scrolling disabled"
    fi

    # Tap to click
    if gum confirm "Enable tap to click?" --default=true; then
        defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
        defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
        echo "Tap to click enabled"
    fi

    echo ""
    echo "--- Dock Settings ---"

    # Dock position
    DOCK_POSITION=$(gum choose --header "Dock position:" "left (Recommended)" "bottom" "right")
    DOCK_POSITION=${DOCK_POSITION%% *}  # Remove " (Recommended)" suffix
    defaults write com.apple.dock orientation -string "$DOCK_POSITION"
    echo "Dock position set to $DOCK_POSITION"

    # Dock size
    if gum confirm "Set dock size to small (42)?" --default=true; then
        defaults write com.apple.dock tilesize -int 42
        echo "Dock size set to 42"
    fi

    # Auto-hide dock
    if gum confirm "Enable dock auto-hide?" --default=true; then
        defaults write com.apple.dock autohide -bool true
        echo "Dock auto-hide enabled"
    fi

    # Show recent apps in dock
    if gum confirm "Hide recent apps in dock?" --default=true; then
        defaults write com.apple.dock show-recents -bool false
        echo "Recent apps hidden from dock"
    fi

    echo ""
    echo "--- Finder & Desktop Settings ---"

    # Show file extensions
    if gum confirm "Show all file extensions?" --default=true; then
        defaults write NSGlobalDomain AppleShowAllExtensions -bool true
        echo "All file extensions visible"
    fi

    # Desktop icon size
    if gum confirm "Set desktop icon size to small (44)?" --default=true; then
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 44" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
        echo "Desktop icon size set to 44"
    fi

    # Desktop icon arrangement
    if gum confirm "Arrange desktop icons by date added?" --default=true; then
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy dateAdded" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
        echo "Desktop icons arranged by date added"
    fi

    # Restart affected apps
    echo ""
    echo "Restarting Dock and Finder to apply changes..."
    killall Dock 2>/dev/null || true
    killall Finder 2>/dev/null || true

    echo "macOS preferences configured!"
else
    echo "Skipping macOS preferences configuration."
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
