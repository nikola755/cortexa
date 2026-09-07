#!/bin/bash

# Dotfiles Install Script
# Optimized for low-end hardware
# Usage: ./install.sh [--skip-packages] [--skip-backup] [--fast]

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
SKIP_PACKAGES=false
SKIP_BACKUP=false
FAST_MODE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-packages) SKIP_PACKAGES=true; shift ;;
        --skip-backup) SKIP_BACKUP=true; shift ;;
        --fast) FAST_MODE=true; shift ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err() { echo -e "${RED}[-]${NC} $1"; }
prompt() { echo -e "${CYAN}[?]${NC} $1"; }

# Prompt helper
confirm() {
    local prompt_text="$1"
    local default="${2:-y}"
    local response
    
    if [ "$FAST_MODE" = true ]; then
        return 0
    fi
    
    if [ "$default" = "y" ]; then
        prompt "$prompt_text [Y/n]: "
    else
        prompt "$prompt_text [y/N]: "
    fi
    
    read -r response
    response=${response:-$default}
    [[ "$response" =~ ^[Yy]$ ]]
}

echo "=== Dotfiles Install Script ==="
echo "Installing from: $DOTFILES_DIR"
echo ""

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    err "This script is designed for Arch Linux."
    exit 1
fi

# ============================================
# STEP 1: Install packages (optimized)
# ============================================
if [ "$SKIP_PACKAGES" = false ]; then
    log "Step 1/9: Installing packages..."
    
    # Install pacman packages
    if [ -f "$DOTFILES_DIR/scripts/pacman-packages.txt" ]; then
        PACKAGE_COUNT=$(wc -l < "$DOTFILES_DIR/scripts/pacman-packages.txt")
        log "Installing $PACKAGE_COUNT official packages..."
        
        if confirm "Install official packages?" "y"; then
            sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/scripts/pacman-packages.txt" 2>/dev/null || \
            sudo pacman -S --needed - < "$DOTFILES_DIR/scripts/pacman-packages.txt" || true
        else
            warn "Skipping official packages"
        fi
    fi
    
    # Install AUR packages
    AUR_HELPER=""
    if command -v paru &> /dev/null; then
        AUR_HELPER="paru"
    elif command -v yay &> /dev/null; then
        AUR_HELPER="yay"
    else
        warn "No AUR helper found."
        echo ""
        echo "  1) Install paru (binary - fast)"
        echo "  2) Compile paru from source (slow, ~5-10 min)"
        echo "  3) Skip AUR packages"
        echo ""
        
        if [ "$FAST_MODE" = false ]; then
            read -p "Choose [1/2/3]: " choice
        else
            choice=1
        fi
        
        case $choice in
            1)
                log "Installing paru binary..."
                # Try to get pre-built binary
                PARU_VERSION=$(curl -sL "https://api.github.com/repos/Morganamilo/paru/releases/latest" | grep '"tag_name"' | cut -d'"' -f4)
                if [ -n "$PARU_VERSION" ]; then
                    curl -sLO "https://github.com/Morganamilo/paru/releases/download/${PARU_VERSION}/paru-${PARU_VERSION}-x86_64.pkg.tar.zst"
                    sudo pacman -U --noconfirm "paru-${PARU_VERSION}-x86_64.pkg.tar.zst" 2>/dev/null || {
                        warn "Binary install failed, compiling..."
                        git clone https://aur.archlinux.org/paru.git /tmp/paru-install 2>/dev/null
                        cd /tmp/paru-install && makepkg -si --noconfirm && cd - > /dev/null
                        rm -rf /tmp/paru-install
                    }
                    rm -f "paru-${PARU_VERSION}-x86_64.pkg.tar.zst"
                else
                    warn "Could not fetch paru version, compiling..."
                    git clone https://aur.archlinux.org/paru.git /tmp/paru-install 2>/dev/null
                    cd /tmp/paru-install && makepkg -si --noconfirm && cd - > /dev/null
                    rm -rf /tmp/paru-install
                fi
                AUR_HELPER="paru"
                ;;
            2)
                log "Compiling paru from source..."
                git clone https://aur.archlinux.org/paru.git /tmp/paru-install 2>/dev/null
                cd /tmp/paru-install && makepkg -si && cd - > /dev/null
                rm -rf /tmp/paru-install
                AUR_HELPER="paru"
                ;;
            3)
                warn "Skipping AUR packages"
                ;;
            *)
                warn "Invalid choice, skipping AUR packages"
                ;;
        esac
    fi
    
    if [ -f "$DOTFILES_DIR/scripts/aur-packages.txt" ]; then
        log "Installing AUR packages..."
        $AUR_HELPER -S --needed --noconfirm - < "$DOTFILES_DIR/scripts/aur-packages.txt" 2>/dev/null || \
        $AUR_HELPER -S --needed - < "$DOTFILES_DIR/scripts/aur-packages.txt" || true
    fi
else
    warn "Skipping package installation"
fi

# ============================================
# STEP 2: Create directory structure (parallel)
# ============================================
log "Step 2/9: Creating directories..."

# Create all directories in parallel for speed
dirs=(
    "$CONFIG_DIR"
    "$HOME/.local/share/applications"
    "$HOME/.local/share/color-schemes"
    "$HOME/.local/share/icons"
    "$HOME/.local/share/mime"
    "$HOME/.local/share/fonts"
    "$HOME/.local/state/noctalia"
    "$HOME/Documents"
    "$HOME/Documents/notes"
    "$HOME/Documents/projects"
    "$HOME/Pictures"
    "$HOME/Pictures/Screenshots"
    "$HOME/Pictures/Wallpapers"
    "$HOME/Downloads"
    "$HOME/.ssh"
    "$HOME/.gnupg"
)

for dir in "${dirs[@]}"; do
    mkdir -p "$dir" &
done
wait

# ============================================
# STEP 3: Backup existing configs
# ============================================
if [ "$SKIP_BACKUP" = false ]; then
    log "Step 3/9: Backing up existing configs..."
    
    BACKUP_DIR="$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"
    if [ -d "$CONFIG_DIR" ]; then
        mv "$CONFIG_DIR" "$BACKUP_DIR"
        log "Backup: $BACKUP_DIR"
    fi
else
    warn "Skipping backup"
fi

# ============================================
# STEP 4: Install config files (parallel)
# ============================================
log "Step 4/9: Installing configs..."

if [ -d "$DOTFILES_DIR/config" ]; then
    for item in "$DOTFILES_DIR/config"/*; do
        if [ -e "$item" ]; then
            item_name=$(basename "$item")
            # Skip applications - handled separately
            if [ "$item_name" != "applications" ]; then
                cp -r "$item" "$CONFIG_DIR/" &
            fi
        fi
    done
    wait
fi

# ============================================
# STEP 4.5: Install wallpapers
# ============================================
log "Step 4.5/9: Installing wallpapers..."

if [ -d "$DOTFILES_DIR/wallpapers" ]; then
    mkdir -p "$HOME/Pictures/Wallpapers"
    cp "$DOTFILES_DIR/wallpapers"/* "$HOME/Pictures/Wallpapers/" 2>/dev/null || true
fi

# ============================================
# STEP 5: Install desktop entries
# ============================================
log "Step 5/9: Installing desktop entries..."

if [ -d "$DOTFILES_DIR/config/applications" ]; then
    for file in "$DOTFILES_DIR/config/applications"/*.desktop; do
        if [ -f "$file" ]; then
            cp "$file" "$HOME/.local/share/applications/" &
        fi
    done
    wait
fi

# ============================================
# STEP 6: Install home directory dotfiles
# ============================================
log "Step 6/9: Installing home dotfiles..."

for file in .bashrc .bash_profile .bash_logout; do
    [ -f "$DOTFILES_DIR/home/$file" ] && cp "$DOTFILES_DIR/home/$file" "$HOME/"
done

# ============================================
# STEP 7: Install Noctalia settings
# ============================================
log "Step 7/9: Installing Noctalia settings..."

if [ -f "$DOTFILES_DIR/config/noctalia/settings.toml" ]; then
    cp "$DOTFILES_DIR/config/noctalia/settings.toml" "$HOME/.local/state/noctalia/"
fi
if [ -f "$DOTFILES_DIR/config/noctalia/state.toml" ]; then
    cp "$DOTFILES_DIR/config/noctalia/state.toml" "$HOME/.local/state/noctalia/"
fi

# ============================================
# STEP 8: Set permissions & post-install
# ============================================
log "Step 8/9: Setting permissions..."

# Secure sensitive files
chmod 600 "$CONFIG_DIR/starship.toml" 2>/dev/null || true
chmod 600 "$CONFIG_DIR/Thunar/uca.xml" 2>/dev/null || true
chmod 700 "$HOME/.ssh" 2>/dev/null || true
chmod 700 "$HOME/.gnupg" 2>/dev/null || true

# Make scripts executable
chmod +x "$DOTFILES_DIR/scripts/backup.sh" 2>/dev/null || true
chmod +x "$DOTFILES_DIR/install.sh" 2>/dev/null || true

# Install thunar-extract script
if [ -f "$DOTFILES_DIR/bin/thunar-extract" ]; then
    mkdir -p "$HOME/.local/bin"
    cp "$DOTFILES_DIR/bin/thunar-extract" "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/thunar-extract"
fi

# ============================================
# STEP 9: Install fonts & set wallpaper
# ============================================
log "Step 9/9: Installing fonts & setting wallpaper..."

# Install JetBrains Mono Nerd Font (fast download)
if ! fc-list 2>/dev/null | grep -q "JetBrainsMono Nerd Font"; then
    if confirm "Install JetBrains Mono Nerd Font?" "y"; then
        log "Downloading JetBrains Mono Nerd Font..."
        cd /tmp
        curl -sLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
        tar -xf JetBrainsMono.tar.xz -C "$HOME/.local/share/fonts/" 2>/dev/null
        rm -f JetBrainsMono.tar.xz
        fc-cache -f 2>/dev/null
        cd - > /dev/null
    else
        warn "Skipping font installation"
    fi
else
    log "Font already installed"
fi

# Set wallpaper if default exists
WALLPAPER="$HOME/Pictures/Wallpapers/default.jpg"
if [ -f "$WALLPAPER" ]; then
    log "Setting wallpaper..."
    # Try hyprpaper first, then swww, then feh
    if command -v hyprctl &> /dev/null; then
        hyprctl hyprpaper preload "$WALLPAPER" 2>/dev/null || true
        hyprctl hyprpaper wallpaper ", $WALLPAPER" 2>/dev/null || true
    elif command -v swww &> /dev/null; then
        swww img "$WALLPAPER" 2>/dev/null || true
    elif command -v feh &> /dev/null; then
        feh --bg-fill "$WALLPAPER" 2>/dev/null || true
    fi
fi

# ============================================
# Completion
# ============================================
echo ""
echo "==========================================="
echo -e "${GREEN}    Installation Complete!${NC}"
echo "==========================================="
echo ""
echo "Installed:"
echo "  - Hyprland + Noctalia (full settings)"
echo "  - Kitty (shell: fish)"
echo "  - Neovim (NvChad)"
echo "  - OpenCode"
echo "  - Thunar, btop, cava, fastfetch"
echo "  - GTK/Qt themes"
echo "  - JetBrains Mono Nerd Font"
echo "  - Desktop entries (nvim, opencode)"
echo "  - User folders created"
echo ""
echo "Kitty is set to use fish shell."
echo "To set fish systemwide: chsh -s /bin/fish"
echo ""
echo "Log out and back in to apply all changes."
