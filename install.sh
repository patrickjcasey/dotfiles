#!/bin/bash

set -eu

DOTFILES_DIR="$HOME/.dotfiles/dotfiles"
CONFIG_DIR="$HOME/.config"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Create symlink with backup of existing files
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        # Already a symlink, remove it
        rm "$target"
        info "Removed existing symlink: $target"
    elif [ -e "$target" ]; then
        # File or directory exists, back it up
        local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
        mv "$target" "$backup"
        warn "Backed up existing file to: $backup"
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    ln -s "$source" "$target"
    info "Created symlink: $target -> $source"
}

# Ensure .config directory exists
mkdir -p "$CONFIG_DIR"

info "Installing dotfiles from $DOTFILES_DIR"
echo ""

# Config directories that go into ~/.config/
CONFIG_APPS=(
    "alacritty"
    "ghostty"
    "i3"
    "kitty"
    "lazygit"
    "nvim"
    "polybar"
    "rofi"
    "sway"
    "tmux"
    "waybar"
)

for app in "${CONFIG_APPS[@]}"; do
    if [ -d "$DOTFILES_DIR/$app" ]; then
        create_symlink "$DOTFILES_DIR/$app" "$CONFIG_DIR/$app"
    else
        warn "Directory not found: $DOTFILES_DIR/$app"
    fi
done

# Special case: zsh files go to home directory
if [ -d "$DOTFILES_DIR/zsh" ]; then
    if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
        create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    fi
fi

echo ""
info "Dotfiles installation complete!"
