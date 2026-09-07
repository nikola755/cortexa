# arch-hyprland

My personal Arch Linux + Hyprland + Noctalia configuration.

## What's Installed

- **Hyprland** - Wayland compositor
- **Noctalia** - Full settings (bar, font, theme, nightlight)
- **Kitty** - Terminal with fish shell
- **Neovim** - NvChad config
- **OpenCode** - AI coding assistant
- **Thunar** - File manager
- **btop/cava/fastfetch** - System tools
- **GTK/Qt** - Noctalia themes
- **JetBrains Mono Nerd Font**

## Quick Install

```bash
git clone https://github.com/nikola755/arch-hyprland.git ~/arch-hyprland
cd ~/arch-hyprland
chmod +x install.sh
./install.sh
```

## Options

- `--fast` - Skip all prompts, use defaults
- `--skip-packages` - Only restore configs
- `--skip-backup` - Don't backup existing configs

## What's Excluded

- VPN configs (AmneziaVPN starts but configs not saved)
- SSH/GPG keys
- Browser data
- Obsidian/Logseq notes
- Passwords & credentials

## Structure

```
arch-hyprland/
├── install.sh          # One-click installer
├── backup.sh           # Update your backup
├── pacman-packages.txt # Official packages
├── aur-packages.txt    # AUR packages
├── config/
│   ├── hypr/          # Hyprland config
│   ├── kitty/         # Terminal
│   ├── fish/          # Shell
│   ├── nvim/          # Editor
│   ├── opencode/      # AI assistant
│   ├── noctalia/      # Noctalia settings
│   ├── btop/          # System monitor
│   ├── cava/          # Visualizer
│   ├── fastfetch/     # System info
│   ├── Thunar/        # File manager
│   ├── gtk-*/         # GTK themes
│   ├── qt*/           # Qt colors
│   └── applications/  # Desktop entries
└── home/
    ├── .bashrc
    ├── .bash_profile
    └── .bash_logout
```

## Update Backup

```bash
cd ~/arch-hyprland
./backup.sh
```
