# Gorgeous GRUB Installer

<p align="center">
  <img src="https://img.shields.io/github/stars/FLEXIY0/gorgeous-grub-installer?style=for-the-badge&color=yellow" alt="Stars">
  <img src="https://img.shields.io/badge/Shell-Bash-green?style=for-the-badge&logo=gnu-bash" alt="Bash">
  <img src="https://img.shields.io/badge/Themes-45+-purple?style=for-the-badge" alt="Themes">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License">
</p>

<p align="center">
  <b>Beautiful interactive GRUB theme installer</b><br>
  Arrow navigation • Search • Animations • 45+ themes
</p>

<p align="center">
  <a href="README.md">English</a> | <a href="README.ru.md">Русский</a>
</p>

---

## Features

- **Interactive UI** — arrow key navigation, real-time search
- **45+ themes** — from gaming to minimalist
- **Quick install** — one command from GitHub
- **Smart search** — by name or description
- **Management** — install, apply, remove themes
- **Resolution settings** — easily change GRUB resolution

## Demo

```
╭───────────────────────────────────────────────────╮
│           Gorgeous GRUB Installer                 │
│                                                   │
│       Beautiful themes for your bootloader        │
╰───────────────────────────────────────────────────╯

Current theme: grubphemous
Installed themes: 4

▸ Install new theme
  Apply installed theme
  Remove theme
  Set resolution
  Exit
```

## Installation

### Requirements

- Linux with GRUB/GRUB2
- `git`, `sudo`
- `gum` (optional, for beautiful UI)

### Install gum

```bash
# Arch Linux
paru -S gum

# Ubuntu/Debian
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum

# Fedora
sudo dnf install gum
```

### Quick start (one command)

```bash
curl -sL https://raw.githubusercontent.com/FLEXIY0/gorgeous-grub-installer/master/gorgeous-grub.sh | bash
```

### Full installation

```bash
git clone https://github.com/FLEXIY0/gorgeous-grub-installer.git
cd gorgeous-grub-installer
./gorgeous-grub.sh
```

## Usage

### Interactive mode

```bash
./gorgeous-grub.sh
```

Use **↑↓** to navigate, **Enter** to select.

### Command line

```bash
# List all themes
./gorgeous-grub.sh --list

# Search theme
./gorgeous-grub.sh --search doom

# Install theme
./gorgeous-grub.sh --install "Grubphemous"
```

## Theme Categories

| Category | Examples |
|----------|----------|
| Gaming | Minegrub, DOOM, Dark Souls, Hollow Knight, Celeste |
| Cyberpunk | Cyberpunk 2077, CRT-Amber, Matrix, Virtuaverse |
| Anime | YoRHa, Persona 5, Genshin Impact |
| Minimal | Catppuccin, Sleek, HyperFluent, Elegant |
| Sci-Fi | Space Isolation, SteamOS, Descent |

## Preview

| Grubphemous | Minegrub |
|:-----------:|:--------:|
| ![Grubphemous](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/Blasphemous.png) | ![Minegrub](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/Minegrub.png) |

| Catppuccin | DOOM |
|:----------:|:----:|
| ![Catppuccin](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/Catppuccin.png) | ![DOOM](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/DOOM.png) |

## How it works

1. Select theme from list
2. Script automatically clones repository
3. Theme is copied to `/boot/grub/themes/`
4. GRUB config is updated
5. Reboot and enjoy

## License

MIT License — see [LICENSE](LICENSE)

## Credits

- [Jacksaur/Gorgeous-GRUB](https://github.com/Jacksaur/Gorgeous-GRUB) — theme collection
- [Charm](https://charm.sh/) — Gum tool

---

<p align="center">
  If you like this project — give it a ⭐
</p>
