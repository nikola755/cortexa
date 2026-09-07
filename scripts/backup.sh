#!/bin/bash

# Dotfiles Backup Script
# Creates a 1:1 copy of system configuration (excluding sensitive data)

set -e

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
LOCAL_DIR="$HOME/.local"

echo "=== Dotfiles Backup Script ==="
echo "Backing up system configuration to $DOTFILES_DIR"

# Create directory structure
mkdir -p "$DOTFILES_DIR/config"
mkdir -p "$DOTFILES_DIR/.config"
mkdir -p "$DOTFILES_DIR/.local/share/applications"
mkdir -p "$DOTFILES_DIR/.local/share/color-schemes"
mkdir -p "$DOTFILES_DIR/.local/share/icons"
mkdir -p "$DOTFILES_DIR/.local/share/mime"
mkdir -p "$DOTFILES_DIR/.local/share/nvim"
mkdir -p "$DOTFILES_DIR/.local/share/opencode"
mkdir -p "$DOTFILES_DIR/.local/share/qalculate"
mkdir -p "$DOTFILES_DIR/.local/share/fish"
mkdir -p "$DOTFILES_DIR/home"

echo ""
echo "[1/8] Backing up Hyprland configuration..."
cp -r "$CONFIG_DIR/hypr" "$DOTFILES_DIR/config/" 2>/dev/null || true

echo "[2/8] Backing up terminal and shell configuration..."
cp -r "$CONFIG_DIR/kitty" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp -r "$CONFIG_DIR/fish" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp "$CONFIG_DIR/starship.toml" "$DOTFILES_DIR/config/" 2>/dev/null || true

echo "[3/8] Backing up Neovim configuration..."
cp -r "$CONFIG_DIR/nvim" "$DOTFILES_DIR/config/" 2>/dev/null || true
# Remove lazy-lock.json and .git from nvim config
rm -f "$DOTFILES_DIR/config/nvim/lazy-lock.json" 2>/dev/null || true
rm -rf "$DOTFILES_DIR/config/nvim/.git" 2>/dev/null || true

echo "[4/8] Backing up editor and IDE configuration..."
cp -r "$CONFIG_DIR/opencode" "$DOTFILES_DIR/config/" 2>/dev/null || true
# Remove node_modules from opencode
rm -rf "$DOTFILES_DIR/config/opencode/node_modules" 2>/dev/null || true
rm -f "$DOTFILES_DIR/config/opencode/package-lock.json" 2>/dev/null || true

echo "[5/8] Backing up UI and theme configuration..."
cp -r "$CONFIG_DIR/waybar" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp -r "$CONFIG_DIR/gtk-3.0" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp -r "$CONFIG_DIR/gtk-4.0" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp -r "$CONFIG_DIR/qt5ct" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp -r "$CONFIG_DIR/qt6ct" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp "$CONFIG_DIR/kdeglobals" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp "$CONFIG_DIR/mimeapps.list" "$DOTFILES_DIR/config/" 2>/dev/null || true

echo "[6/8] Backing up system monitor and utility configuration..."
cp -r "$CONFIG_DIR/btop" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp -r "$CONFIG_DIR/cava" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp -r "$CONFIG_DIR/fastfetch" "$DOTFILES_DIR/config/" 2>/dev/null || true
cp -r "$CONFIG_DIR/htop" "$DOTFILES_DIR/config/" 2>/dev/null || true

echo "[7/8] Backing up file manager configuration..."
cp -r "$CONFIG_DIR/Thunar" "$DOTFILES_DIR/config/" 2>/dev/null || true

echo "[8/8] Backing up home directory dotfiles..."
cp "$HOME/.bashrc" "$DOTFILES_DIR/home/" 2>/dev/null || true
cp "$HOME/.bash_profile" "$DOTFILES_DIR/home/" 2>/dev/null || true
cp "$HOME/.bash_logout" "$DOTFILES_DIR/home/" 2>/dev/null || true

# Export package lists
echo ""
echo "=== Exporting Package Lists ==="
echo "Exporting pacman packages..."
pacman -Qe | awk '{print $1}' > "$DOTFILES_DIR/pacman-packages.txt"

echo "Exporting AUR packages (paru)..."
paru -Qe 2>/dev/null | awk '{print $1}' > "$DOTFILES_DIR/aur-packages.txt" || true

# Create VSCode/VSCodium settings backup
echo ""
echo "=== Backing up VSCodium settings ==="
mkdir -p "$DOTFILES_DIR/config/VSCodium/User"
if [ -d "$CONFIG_DIR/VSCodium/User" ]; then
    cp "$CONFIG_DIR/VSCodium/User/settings.json" "$DOTFILES_DIR/config/VSCodium/User/" 2>/dev/null || true
    cp "$CONFIG_DIR/VSCodium/User/keybindings.json" "$DOTFILES_DIR/config/VSCodium/User/" 2>/dev/null || true
fi

# Create systemd user services backup if exists
if [ -d "$HOME/.config/systemd/user" ]; then
    echo "Backing up systemd user services..."
    mkdir -p "$DOTFILES_DIR/config/systemd/user"
    cp -r "$HOME/.config/systemd/user" "$DOTFILES_DIR/config/systemd/" 2>/dev/null || true
fi

echo ""
echo "=== Backup Complete ==="
echo "Your dotfiles have been backed up to: $DOTFILES_DIR"
echo ""
echo "Next steps:"
echo "1. cd $DOTFILES_DIR"
echo "2. git init"
echo "3. git add ."
echo "4. git commit -m 'Initial dotfiles backup'"
echo "5. Create a private GitHub repository"
echo "6. git remote add origin <your-repo-url>"
echo "7. git push -u origin main"
