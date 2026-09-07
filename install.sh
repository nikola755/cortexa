#!/bin/bash

# Dotfiles Install Script
# Restores system configuration from dotfiles repository

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "=== Dotfiles Install Script ==="
echo "Installing configuration from $DOTFILES_DIR"

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo "This script is designed for Arch Linux. Please adapt for your distribution."
    exit 1
fi

# Install packages
echo ""
echo "[1/6] Installing packages..."
echo "Installing pacman packages..."
sudo pacman -S --needed - < "$DOTFILES_DIR/pacman-packages.txt" || true

echo "Installing AUR packages (paru)..."
if command -v paru &> /dev/null; then
    paru -S --needed - < "$DOTFILES_DIR/aur-packages.txt" || true
else
    echo "paru not found. Installing paru first..."
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru && makepkg -si && cd -
    paru -S --needed - < "$DOTFILES_DIR/aur-packages.txt" || true
fi

# Create necessary directories
echo ""
echo "[2/6] Creating directory structure..."
mkdir -p "$CONFIG_DIR"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/color-schemes"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/.local/share/mime"

# Backup existing configs
echo ""
echo "[3/6] Backing up existing configurations..."
BACKUP_DIR="$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"
if [ -d "$CONFIG_DIR" ]; then
    echo "Moving existing configs to $BACKUP_DIR"
    mv "$CONFIG_DIR" "$BACKUP_DIR"
fi

# Copy configuration files
echo ""
echo "[4/6] Installing configuration files..."
cp -r "$DOTFILES_DIR/config"/* "$CONFIG_DIR/" 2>/dev/null || true

# Install home directory dotfiles
echo ""
echo "[5/6] Installing home directory dotfiles..."
[ -f "$DOTFILES_DIR/home/.bashrc" ] && cp "$DOTFILES_DIR/home/.bashrc" "$HOME/"
[ -f "$DOTFILES_DIR/home/.bash_profile" ] && cp "$DOTFILES_DIR/home/.bash_profile" "$HOME/"
[ -f "$DOTFILES_DIR/home/.bash_logout" ] && cp "$DOTFILES_DIR/home/.bash_logout" "$HOME/"

# Set permissions
echo ""
echo "[6/6] Setting permissions..."
chmod 600 "$CONFIG_DIR/starship.toml" 2>/dev/null || true
chmod 600 "$CONFIG_DIR/Thunar/uca.xml" 2>/dev/null || true
chmod 600 "$CONFIG_DIR/htop/htoprc" 2>/dev/null || true

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Please log out and log back in for all changes to take effect."
echo "You may need to:"
echo "1. Restart your display manager"
echo "2. Reconfigure your shell: chsh -s /bin/fish"
echo "3. Install additional fonts: fc-cache -fv"
echo "4. Reload Hyprland: hyprctl reload"
