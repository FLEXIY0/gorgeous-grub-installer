# Gorgeous GRUB Installer

<p align="center">
  <img src="https://img.shields.io/github/stars/YOUR_USERNAME/gorgeous-grub-installer?style=for-the-badge&color=yellow" alt="Stars">
  <img src="https://img.shields.io/badge/Shell-Bash-green?style=for-the-badge&logo=gnu-bash" alt="Bash">
  <img src="https://img.shields.io/badge/Themes-45+-purple?style=for-the-badge" alt="Themes">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License">
</p>

<p align="center">
  <b>Красивый интерактивный установщик тем GRUB</b><br>
  Навигация стрелками • Поиск • Анимации • 45+ тем
</p>

---

## Особенности

- **Интерактивный интерфейс** — навигация стрелками, поиск в реальном времени
- **45+ тем** — от игровых до минималистичных
- **Быстрая установка** — одной командой из GitHub
- **Умный поиск** — по названию или описанию
- **Управление** — установка, применение, удаление тем
- **Настройка разрешения** — легко изменить разрешение GRUB

## Демонстрация

```
╭───────────────────────────────────────────────────╮
│           Gorgeous GRUB Installer                 │
│                                                   │
│      Красивые темы для вашего загрузчика          │
╰───────────────────────────────────────────────────╯

Текущая тема: grubphemous
Установлено тем: 4

▸ Установить новую тему
  Применить установленную тему
  Удалить тему
  Настроить разрешение
  Выход
```

## Установка

### Требования

- Linux с GRUB/GRUB2
- `git`, `sudo`
- `gum` (опционально, для красивого UI)

### Установка gum

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

### Запуск

```bash
git clone https://github.com/YOUR_USERNAME/gorgeous-grub-installer.git
cd gorgeous-grub-installer
./gorgeous-grub.sh
```

## Использование

### Интерактивный режим

```bash
./gorgeous-grub.sh
```

Используйте **↑↓** для навигации, **Enter** для выбора.

### Командная строка

```bash
# Показать все темы
./gorgeous-grub.sh --list

# Поиск темы
./gorgeous-grub.sh --search doom

# Установить тему
./gorgeous-grub.sh --install "Grubphemous"
```

## Категории тем

| Категория | Примеры |
|-----------|---------|
| Игровые | Minegrub, DOOM, Dark Souls, Hollow Knight, Celeste |
| Киберпанк | Cyberpunk 2077, CRT-Amber, Matrix, Virtuaverse |
| Аниме | YoRHa, Persona 5, Genshin Impact |
| Минимализм | Catppuccin, Sleek, HyperFluent, Elegant |
| Sci-Fi | Space Isolation, SteamOS, Descent |

## Превью

| Grubphemous | Minegrub |
|:-----------:|:--------:|
| ![Grubphemous](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/Blasphemous.png) | ![Minegrub](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/Minegrub.png) |

| Catppuccin | DOOM |
|:----------:|:----:|
| ![Catppuccin](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/Catppuccin.png) | ![DOOM](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/DOOM.png) |

## Как это работает

1. Выберите тему из списка
2. Скрипт автоматически клонирует репозиторий
3. Тема копируется в `/boot/grub/themes/`
4. Конфигурация GRUB обновляется
5. Перезагрузитесь и наслаждайтесь

## Лицензия

MIT License — см. [LICENSE](LICENSE)

## Благодарности

- [Jacksaur/Gorgeous-GRUB](https://github.com/Jacksaur/Gorgeous-GRUB) — коллекция тем
- [Charm](https://charm.sh/) — инструмент Gum

---

<p align="center">
  Если проект понравился — поставьте ⭐
</p>
