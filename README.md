# Dotfiles

Personal system configuration backup for Arch Linux with Hyprland.

## Screenshots

<!-- Add your screenshots here -->
<!-- Example: -->
<!-- ![Desktop](screenshots/desktop.png) -->
<!-- ![Terminal](screenshots/terminal.png) -->
<!-- ![Hyprland](screenshots/hyprland.png) -->

*Screenshots coming soon - add your own by placing images in `screenshots/` folder*

## What's Included

### Window Manager & Desktop
- **Hyprland** - Wayland compositor with Noctalia theme
- **Noctalia** - Shell, bar, and theme system (full settings included)

### Terminal & Shell
- **Kitty** - Terminal emulator with Noctalia theme
- **Fish** - Shell with custom configuration
- **Starship** - Cross-shell prompt

### Editors & IDEs
- **Neovim** - NvChad configuration
- **OpenCode** - AI coding assistant
- **VSCodium** - VS Code fork

### Applications
- **Thunar** - File manager
- **btop** - System monitor
- **cava** - Audio visualizer
- **fastfetch** - System info

### Theme & Appearance
- **GTK 3.0/4.0** - Noctalia theme
- **Qt5/Qt6** - Color schemes
- **KDE Colors** - Noctalia color scheme
- **Papirus** - Icon theme
- **JetBrains Mono Nerd Font** - Monospace font

## Installation

### Prerequisites

- Arch Linux (or Arch-based distribution)
- Git
- Paru (AUR helper)

### Quick Install

```bash
# Clone the repository
git clone https://github.com/nikola755/dotfiles.git ~/dotfiles

# Run the install script
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### Manual Install

```bash
# Install packages
sudo pacman -S --needed - < pacman-packages.txt
paru -S --needed - < aur-packages.txt

# Copy configuration files
cp -r config/* ~/.config/

# Copy home directory files
cp home/.bashrc ~/
cp home/.bash_profile ~/
cp home/.bash_logout ~/

# Set permissions
chmod 600 ~/.config/starship.toml
chmod 600 ~/.config/Thunar/uca.xml
```

## Backup

To update your backup after making changes:

```bash
cd ~/dotfiles
chmod +x backup.sh
./backup.sh
```

## What's Excluded

This backup intentionally excludes:

- **VPN configurations** - Network setup is personal
- **SSH keys** - Security sensitive
- **GPG keys** - Security sensitive
- **Browser data** - Cookies, sessions, history
- **Obsidian notes** - Personal content
- **Logseq notes** - Personal content
- **Passwords & credentials** - Security sensitive
- **API keys & tokens** - Security sensitive

## Package Lists

- `pacman-packages.txt` - Official repository packages
- `aur-packages.txt` - AUR packages

## Structure

```
dotfiles/
├── backup.sh              # Backup script
├── install.sh             # Installation script
├── .gitignore            # Excludes sensitive data
├── README.md             # This file
├── pacman-packages.txt   # Official packages
├── aur-packages.txt      # AUR packages
├── config/               # ~/.config files
│   ├── hypr/            # Hyprland configuration
│   ├── kitty/           # Terminal configuration
│   ├── fish/            # Shell configuration
│   ├── nvim/            # Neovim configuration
│   ├── opencode/        # OpenCode configuration
│   ├── noctalia/        # Noctalia settings (bar, font, theme)
│   ├── btop/            # System monitor
│   ├── cava/            # Audio visualizer
│   ├── fastfetch/       # System info
│   ├── Thunar/          # File manager
│   ├── gtk-3.0/         # GTK theme
│   ├── gtk-4.0/         # GTK theme
│   ├── qt5ct/           # Qt5 colors
│   ├── qt6ct/           # Qt6 colors
│   ├── VSCodium/        # Editor settings
│   └── starship.toml    # Shell prompt
└── home/                 # Home directory dotfiles
    ├── .bashrc
    ├── .bash_profile
    └── .bash_logout
```

## Restoration

After a fresh install:

1. Install Git: `sudo pacman -S git`
2. Clone this repository
3. Run `./install.sh`
4. Log out and back in
5. Enjoy your familiar environment!

## Notes

- This is a **private repository** - keep it secure
- Regularly update your backup after system changes
- Review `.gitignore` before committing sensitive data
- Consider using `git-crypt` for additional encryption

## License

Personal use only.
