```
                            d8                            
 e88'888  e88 88e  888,8,  d88    ,e e,   Y8b Y8Y  ,"Y88b 
d888  '8 d888 888b 888 "  d88888 d88 88b   Y8b Y  "8" 888 
Y888   , Y888 888P 888     888   888   ,  e Y8b   ,ee 888 
 "88,e8'  "88 88"  888     888    "YeeP" d8b Y8b  "88 888 
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f218468a-8107-43fa-8164-7ac0a356bca7" />
<img width="1920" height="1079" alt="image" src="https://github.com/user-attachments/assets/1dc43901-fd74-4af4-8018-45b0f2175ee1" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/db64340c-e6fa-4154-a297-71762f606fb1" />

## what is this?

arch linux + hyprland + noctalia dotfiles.
one script to restore my entire system.

## install

```bash
git clone https://github.com/nikola755/cortexa.git ~/cortexa
cd ~/cortexa
chmod +x install.sh
./install.sh
```

## options

```
--fast           skip all prompts
--skip-packages  only restore configs
--skip-backup    don't backup existing configs
```

## what gets installed

```
hyprland          wayland compositor
noctalia          bar, font, theme, nightlight
kitty             terminal (fish shell)
nvim              neovim (nvchad)
opencode          ai coding assistant
thunar            file manager
btop/cava         system monitor/visualizer
fastfetch         system info
gtk/qt            noctalia themes
jetbrains mono    nerd font
```

## structure

```
cortexa/
├── install.sh
├── scripts/
│   ├── backup.sh
│   ├── pacman-packages.txt
│   └── aur-packages.txt
├── config/
│   ├── hypr/
│   ├── kitty/
│   ├── fish/
│   ├── nvim/
│   ├── opencode/
│   ├── noctalia/
│   ├── btop/
│   ├── cava/
│   ├── fastfetch/
│   ├── thunar/
│   ├── gtk-3.0/
│   ├── gtk-4.0/
│   ├── qt5ct/
│   ├── qt6ct/
│   └── applications/
└── home/
    ├── .bashrc
    ├── .bash_profile
    └── .bash_logout
```

## update backup

```bash
cd ~/cortexa
./scripts/backup.sh
```
