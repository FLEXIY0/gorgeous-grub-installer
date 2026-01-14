# 🎨 Gorgeous GRUB Installer

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Bash-green?style=for-the-badge&logo=gnu-bash" alt="Bash">
  <img src="https://img.shields.io/badge/TUI-Gum-ff69b4?style=for-the-badge" alt="Gum">
  <img src="https://img.shields.io/badge/Themes-45+-purple?style=for-the-badge" alt="Themes">
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" alt="License">
</p>

<p align="center">
  <b>Красивый интерактивный установщик тем GRUB</b><br>
  <i>Навигация стрелками • Поиск • Анимации • 45+ тем</i>
</p>

---

## ✨ Особенности

- 🎮 **Интерактивный интерфейс** — навигация стрелками ↑↓, поиск в реальном времени
- 🎨 **45+ красивых тем** — от игровых до минималистичных
- ⚡ **Быстрая установка** — одной командой из GitHub
- 🔍 **Умный поиск** — находите темы по названию или описанию
- 📦 **Управление** — установка, применение, удаление тем
- 🖥️ **Настройка разрешения** — легко изменить разрешение GRUB
- 💫 **Анимации загрузки** — красивые спиннеры при установке

## 🎬 Демонстрация

```
╭───────────────────────────────────────────────────╮
│      🎨 Gorgeous GRUB Installer                   │
│                                                   │
│      Красивые темы для вашего загрузчика          │
╰───────────────────────────────────────────────────╯

Текущая тема: grubphemous
Установлено тем: 4

▸ 🎨 Установить новую тему
  ✅ Применить установленную тему
  🗑️  Удалить тему
  🖥️  Настроить разрешение
  🔄 Отключить двойное меню Minegrub
  🚪 Выход
```

## 📦 Установка

### Требования

- Linux с GRUB/GRUB2
- `git`, `sudo`
- `gum` (опционально, для красивого UI)

### Быстрая установка

```bash
# Установить gum (для красивого интерфейса)
# Arch Linux:
paru -S gum
# или: sudo pacman -S gum

# Ubuntu/Debian:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum

# Fedora:
sudo dnf install gum
```

```bash
# Клонировать репозиторий
git clone https://github.com/YOUR_USERNAME/gorgeous-grub-installer.git
cd gorgeous-grub-installer

# Запустить
./gorgeous-grub.sh
```

## 🚀 Использование

### Интерактивный режим

```bash
./gorgeous-grub.sh
```

Используйте **↑↓** для навигации, **Enter** для выбора, **Esc** для отмены.

### Командная строка

```bash
# Показать все доступные темы
./gorgeous-grub.sh --list

# Поиск темы
./gorgeous-grub.sh --search doom
./gorgeous-grub.sh --search minecraft
./gorgeous-grub.sh --search аниме

# Установить тему напрямую  
./gorgeous-grub.sh --install "Grubphemous"
./gorgeous-grub.sh --install "DOOM"
./gorgeous-grub.sh --install "Catppuccin"
```

## 🎨 Категории тем

| Категория | Примеры тем |
|-----------|-------------|
| 🎮 **Игровые** | Minegrub, DOOM, Dark Souls, Hollow Knight, Celeste, Sekiro |
| 🌃 **Киберпанк** | Cyberpunk 2077, CyberRe, CRT-Amber, Matrix, Virtuaverse |
| 🎌 **Аниме** | YoRHa, Persona 5, Genshin Impact, VA-11 HALL-A |
| ✨ **Минимализм** | Catppuccin, Sleek, HyperFluent, Elegant, Graphite |
| 🚀 **Sci-Fi** | Space Isolation, SteamOS, Descent |
| 🎭 **Другие** | DedSec, Fallout, BSOL, Grand Theft Gentoo |

## 📸 Превью тем

### Grubphemous
![Grubphemous](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/Blasphemous.png)

### Minegrub
![Minegrub](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/Minegrub.png)

### Catppuccin
![Catppuccin](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/Catppuccin.png)

### DOOM
![DOOM](https://raw.githubusercontent.com/Jacksaur/Gorgeous-GRUB/main/Images/DOOM.png)

## 🔧 Как это работает

1. **Выбор темы** — выберите тему из списка с помощью стрелок или поиска
2. **Автоклонирование** — скрипт автоматически клонирует репозиторий темы
3. **Установка** — тема копируется в `/boot/grub/themes/`
4. **Применение** — конфигурация GRUB обновляется автоматически
5. **Готово!** — перезагрузите компьютер и наслаждайтесь

## 🛠️ Дополнительные функции

### Отключение двойного меню Minegrub

Если вы установили "Minegrub Combined" и хотите вернуться к обычному меню:

```bash
./gorgeous-grub.sh
# Выберите: 🔄 Отключить двойное меню Minegrub
```

### Изменение разрешения

```bash
./gorgeous-grub.sh
# Выберите: 🖥️ Настроить разрешение
```

## 🤝 Участие в проекте

1. Fork репозитория
2. Создайте ветку (`git checkout -b feature/новая-функция`)
3. Commit (`git commit -am 'Добавить функцию'`)
4. Push (`git push origin feature/новая-функция`)
5. Создайте Pull Request

## 📄 Лицензия

MIT License — смотрите [LICENSE](LICENSE)

## 🙏 Благодарности

- [Jacksaur/Gorgeous-GRUB](https://github.com/Jacksaur/Gorgeous-GRUB) — коллекция тем
- [Charm](https://charm.sh/) — за прекрасный инструмент Gum
- Всем авторам тем за их отличную работу!

---

<p align="center">
  Made with ❤️ for Linux community<br>
  <a href="https://github.com/Jacksaur/Gorgeous-GRUB">Источник тем</a>
</p>
