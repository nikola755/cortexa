#!/bin/bash

# Dotfiles Install Script
# Restores system configuration from dotfiles repository
# Usage: ./install.sh [--skip-packages] [--skip-backup]

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
SKIP_PACKAGES=false
SKIP_BACKUP=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-packages)
            SKIP_PACKAGES=true
            shift
            ;;
        --skip-backup)
            SKIP_BACKUP=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo "=== Dotfiles Install Script ==="
echo "Installing configuration from $DOTFILES_DIR"
echo ""

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo "ERROR: This script is designed for Arch Linux."
    echo "Please adapt for your distribution."
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing git..."
    sudo pacman -S --needed git
fi

# ============================================
# STEP 1: Install packages
# ============================================
if [ "$SKIP_PACKAGES" = false ]; then
    echo "[1/8] Installing packages..."
    echo ""
    
    # Install pacman packages
    echo "Installing official repository packages..."
    if [ -f "$DOTFILES_DIR/pacman-packages.txt" ]; then
        sudo pacman -S --needed - < "$DOTFILES_DIR/pacman-packages.txt" || true
    fi
    
    echo ""
    echo "Installing AUR packages..."
    
    # Check for AUR helper
    AUR_HELPER=""
    if command -v paru &> /dev/null; then
        AUR_HELPER="paru"
    elif command -v yay &> /dev/null; then
        AUR_HELPER="yay"
    else
        echo "No AUR helper found. Installing paru..."
        git clone https://aur.archlinux.org/paru.git /tmp/paru-install
        cd /tmp/paru-install && makepkg -si && cd -
        rm -rf /tmp/paru-install
        AUR_HELPER="paru"
    fi
    
    if [ -f "$DOTFILES_DIR/aur-packages.txt" ]; then
        $AUR_HELPER -S --needed - < "$DOTFILES_DIR/aur-packages.txt" || true
    fi
else
    echo "[1/8] Skipping package installation (--skip-packages)"
fi

# ============================================
# STEP 2: Create directory structure
# ============================================
echo ""
echo "[2/8] Creating directory structure..."

directories=(
    "$CONFIG_DIR"
    "$HOME/.local/share/applications"
    "$HOME/.local/share/color-schemes"
    "$HOME/.local/share/icons"
    "$HOME/.local/share/mime"
    "$HOME/.local/share/nvim"
    "$HOME/.local/share/opencode"
    "$HOME/.local/share/qalculate"
    "$HOME/.local/share/fish"
    "$HOME/.ssh"
    "$HOME/.gnupg"
)

for dir in "${directories[@]}"; do
    mkdir -p "$dir"
done

# ============================================
# STEP 3: Backup existing configs
# ============================================
if [ "$SKIP_BACKUP" = false ]; then
    echo ""
    echo "[3/8] Backing up existing configurations..."
    
    BACKUP_DIR="$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"
    if [ -d "$CONFIG_DIR" ]; then
        echo "Moving existing configs to: $BACKUP_DIR"
        mv "$CONFIG_DIR" "$BACKUP_DIR"
        echo "Backup created. To restore later: mv $BACKUP_DIR $CONFIG_DIR"
    else
        echo "No existing .config directory found."
    fi
else
    echo ""
    echo "[3/8] Skipping backup (--skip-backup)"
fi

# ============================================
# STEP 4: Install configuration files
# ============================================
echo ""
echo "[4/8] Installing configuration files..."

# Copy all config directories
if [ -d "$DOTFILES_DIR/config" ]; then
    for item in "$DOTFILES_DIR/config"/*; do
        if [ -e "$item" ]; then
            item_name=$(basename "$item")
            echo "  Installing: $item_name"
            cp -r "$item" "$CONFIG_DIR/"
        fi
    done
fi

# ============================================
# STEP 5: Install home directory dotfiles
# ============================================
echo ""
echo "[5/8] Installing home directory dotfiles..."

home_files=(
    ".bashrc"
    ".bash_profile"
    ".bash_logout"
)

for file in "${home_files[@]}"; do
    if [ -f "$DOTFILES_DIR/home/$file" ]; then
        echo "  Installing: $file"
        cp "$DOTFILES_DIR/home/$file" "$HOME/"
    fi
done

# ============================================
# STEP 5.25: Install desktop entries
# ============================================
echo ""
echo "[5.25/8] Installing desktop entries..."

if [ -d "$DOTFILES_DIR/config/applications" ]; then
    mkdir -p "$HOME/.local/share/applications"
    for file in "$DOTFILES_DIR/config/applications"/*.desktop; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            echo "  Installing: $filename"
            cp "$file" "$HOME/.local/share/applications/"
        fi
    done
fi

# ============================================
# STEP 5.5: Install Noctalia settings
# ============================================
echo ""
echo "[5.5/8] Installing Noctalia settings..."

NOCTALIA_STATE_DIR="$HOME/.local/state/noctalia"
mkdir -p "$NOCTALIA_STATE_DIR"

if [ -f "$DOTFILES_DIR/config/noctalia/settings.toml" ]; then
    echo "  Installing: settings.toml"
    cp "$DOTFILES_DIR/config/noctalia/settings.toml" "$NOCTALIA_STATE_DIR/"
fi

if [ -f "$DOTFILES_DIR/config/noctalia/state.toml" ]; then
    echo "  Installing: state.toml"
    cp "$DOTFILES_DIR/config/noctalia/state.toml" "$NOCTALIA_STATE_DIR/"
fi

# ============================================
# STEP 6: Set permissions
# ============================================
echo ""
echo "[6/8] Setting permissions..."

# Set secure permissions for sensitive files
sensitive_files=(
    "$CONFIG_DIR/starship.toml"
    "$CONFIG_DIR/Thunar/uca.xml"
    "$CONFIG_DIR/htop/htoprc"
    "$HOME/.ssh"
    "$HOME/.gnupg"
)

for file in "${sensitive_files[@]}"; do
    if [ -e "$file" ]; then
        chmod 600 "$file" 2>/dev/null || true
    fi
done

# Make scripts executable
chmod +x "$DOTFILES_DIR/backup.sh" 2>/dev/null || true
chmod +x "$DOTFILES_DIR/install.sh" 2>/dev/null || true

# ============================================
# STEP 7: Install fonts
# ============================================
echo ""
echo "[7/8] Installing fonts..."

# Create fonts directory
mkdir -p "$HOME/.local/share/fonts"

# Check if JetBrains Mono Nerd Font is installed
if ! fc-list | grep -q "JetBrainsMono Nerd Font"; then
    echo "  Installing JetBrains Mono Nerd Font..."
    cd /tmp
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
    tar -xf JetBrainsMono.tar.xz -C "$HOME/.local/share/fonts/"
    rm JetBrainsMono.tar.xz
    fc-cache -fv
    cd -
else
    echo "  JetBrains Mono Nerd Font already installed."
fi

# ============================================
# STEP 8: Configure shell
# ============================================
echo ""
echo "[8/8] Configuring shell..."

# Set fish as default shell
if command -v fish &> /dev/null; then
    echo "  Fish shell detected."
    echo "  To set fish as default shell, run:"
    echo "    chsh -s /bin/fish"
fi

# ============================================
# Post-installation
# ============================================
echo ""
echo "==========================================="
echo "    Installation Complete!"
echo "==========================================="
echo ""
echo "Installed components:"
echo "  - Hyprland (Wayland compositor)"
echo "  - Kitty (Terminal)"
echo "  - Fish (Shell)"
echo "  - Neovim (Editor)"
echo "  - OpenCode (AI Assistant)"
echo "  - Thunar (File manager)"
echo "  - btop/cava/fastfetch (System tools)"
echo "  - Noctalia (Full settings: bar, font, theme, etc)"
echo "  - GTK/Qt themes"
echo "  - JetBrains Mono Nerd Font"
echo ""
echo "Next steps:"
echo "  1. Log out and log back in"
echo "  2. Set fish as default shell: chsh -s /bin/fish"
echo "  3. Reload Hyprland: hyprctl reload"
echo "  4. Restart your display manager if needed"
echo ""
echo "To update your backup in the future, run:"
echo "  cd $DOTFILES_DIR && ./backup.sh"
echo ""
