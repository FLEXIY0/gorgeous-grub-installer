#!/bin/bash

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                      🎨 Gorgeous GRUB Installer                          ║
# ║        Интерактивный установщик тем GRUB из коллекции Gorgeous-GRUB      ║
# ║                    https://github.com/Jacksaur/Gorgeous-GRUB             ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

set -e

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Конфигурация
GRUB_THEMES_DIR="/boot/grub/themes"
GRUB_CONFIG="/etc/default/grub"
TEMP_DIR="/tmp/gorgeous-grub-install"

# База данных тем: "Название|URL|Тип (github/pling/gitlab)|Папка темы|Описание"
declare -a THEMES=(
    # Игровые темы
    "Minegrub|https://github.com/Lxtharia/minegrub-theme|github|minegrub|🎮 Minecraft главное меню с прокручивающимся текстом"
    "Minegrub Combined|https://github.com/Lxtharia/double-minegrub-menu|github-script|minegrub|🎮 Двойное меню Minecraft (главное + выбор мира)"
    "Minegrub World Select|https://github.com/Lxtharia/minegrub-world-sel-theme|github|minegrub-world-selection|🎮 Minecraft экран выбора мира"
    "Grubphemous|https://github.com/pvtoari/grubphemous-theme|github|grubphemous|⚔️ Тема в стиле Blasphemous"
    "DOOM|https://github.com/Lxtharia/doomgrub-theme|github|doomgrub|👹 Тема в стиле DOOM"
    "Hollow Grub|https://github.com/sergoncano/hollow-knight-grub-theme|github|hollow-knight|🦋 Тема Hollow Knight"
    "GrubSouls|https://github.com/PedroMMarinho/grubsouls-theme|github|grubsouls|⚔️ Dark Souls тема"
    "Grubnautica|https://github.com/tatounee/Grubnautica|github|Grubnautica|🌊 Subnautica тема"
    "ULTRAKILL|https://www.pling.com/p/2217746|pling|ultrakill|🔫 ULTRAKILL тема"
    "Crossgrub|https://github.com/krypciak/crossgrub|github|crossgrub|✝️ CrossCode тема"
    "CelesteGRUB|https://github.com/suilven641/CelesteGRUB|github|CelesteGRUB|🍓 Celeste тема"
    "Lobotomy GRUB|https://github.com/rats-scamper/LoboGrubTheme|github|lobogrub|🧠 Lobotomy Corporation тема"
    "Grubshin Bootpact|https://github.com/max-ishere/grubshin-bootpact|github-installer|grubshin|⭐ Genshin Impact тема"
    
    # Киберпанк/Ретро
    "CyberGRUB-2077|https://github.com/adnksharp/CyberGRUB-2077|github|CyberGRUB-2077|🌃 Cyberpunk 2077 тема"
    "Cyberpunk 2077|https://www.pling.com/p/1515662|pling|cyberpunk2077|🌃 Официальная Cyberpunk тема"
    "CyberRe|https://www.pling.com/p/1420727|pling|cyberre|🌃 Кибер-ретро тема"
    "Cyberpunk|https://www.pling.com/p/1429443|pling|cyberpunk|🌃 Общая киберпанк тема"
    "CyberXero|https://www.pling.com/p/1502415|pling|cyberxero|🌃 CyberXero тема"
    "Virtuaverse|https://github.com/Patato777/dotfiles|github-subfolder|grub|🕹️ Virtuaverse пиксельная тема"
    "CRT-Amber|https://www.pling.com/p/1727268|pling|crt-amber|📺 Ретро CRT монитор"
    "OldBIOS|https://www.pling.com/p/2072033|pling|oldbios|💾 Старый BIOS стиль"
    "Arcade|https://github.com/nobreDaniel/dotfile|github-subfolder|grub|🕹️ Аркадная тема"
    
    # Аниме/Японские
    "YoRHa|https://github.com/OliveThePuffin/yorha-grub-theme|github|yorha|🤖 NieR: Automata тема"
    "Persona 5 Royal|https://www.pling.com/p/2122684|pling|persona5|🎭 Persona 5 Royal тема"
    "Wuthering Waves|https://www.pling.com/p/2184155|pling|wuthering-waves|🌊 Wuthering Waves тема"
    "Sayonara|https://github.com/samoht9277/dotfiles|github-subfolder|grub/themes/sayonara|👋 Минималистичная японская тема"
    "VA-11 HALL-A|https://github.com/happyzxzxz/valhallaDots|github-subfolder|grub|🍸 VA-11 HALL-A бар тема"
    "Milk Outside|https://www.pling.com/p/2296341|pling|milk|🥛 Milk Outside A Bag of Milk"
    
    # Минималистичные/Современные
    "Catppuccin|https://github.com/catppuccin/grub|github-installer|catppuccin|🐱 Пастельная Catppuccin тема"
    "Sleek|https://www.pling.com/p/1414997|pling|sleek|✨ Современная элегантная тема"
    "HyperFluent|https://www.pling.com/p/2133341|pling|hyperfluent|💫 Windows 11 стиль"
    "Elegant|https://github.com/vinceliuice/Elegant-grub2-themes|github-installer|Elegant|🎩 Большой набор элегантных тем"
    "Modern Design|https://github.com/vinceliuice/grub2-themes|github-installer|grub2-themes|🎨 Современный дизайн (набор)"
    "Graphite|https://www.pling.com/p/1676418|pling|graphite|⚫ Графитовая минималистичная"
    "Neumorphic|https://www.pling.com/p/1906415|pling|neumorphic|🔘 Неоморфизм стиль"
    "Atomic|https://www.pling.com/p/1200710|pling|atomic|⚛️ Атомная тема"
    "Breeze|https://www.pling.com/p/1000111|pling|breeze|🌬️ KDE Breeze тема"
    "Solarized-Dark|https://www.pling.com/p/1177401|pling|solarized-dark|🌅 Solarized Dark"
    "Plasma Light|https://www.pling.com/p/1197062|pling|plasma-light|☀️ KDE Plasma светлая"
    "Plasma Dark|https://www.pling.com/p/1195799|pling|plasma-dark|🌙 KDE Plasma тёмная"
    "Distro Themes|https://www.pling.com/p/1482847|pling|distro|🐧 Темы дистрибутивов Linux"
    "Framework|https://github.com/HeinrichZurHorstMeyer/Framework-Grub-Theme|github|Framework|💻 Framework Laptop тема"
    
    # Sci-Fi/Space
    "Space Isolation|https://github.com/callmenoodles/space-isolation|github|space-isolation|🚀 Космическая изоляция"
    "Descent|https://www.pling.com/p/1000083|pling|descent|🛸 Классическая Descent"
    "Matrix-Morpheus|https://github.com/Priyank-Adhav/Matrix-Morpheus-GRUB-Theme|github|Matrix-Morpheus|🟢 Матрица тема"
    
    # Другие
    "SteamOS|https://github.com/LegendaryBibo/Steam-Big-Picture-Grub-Theme|github|steam|🎮 Steam Big Picture"
    "DedSec|https://www.pling.com/p/1569525|pling|dedsec|👁️ Watch Dogs DedSec"
    "Sekiro|https://github.com/semimqmo/sekiro_grub_theme|github|sekiro|⚔️ Sekiro тема"
    "Sekiro Shadow|https://github.com/MrVivekRajan/Grub-Themes|github-subfolder|SekiroShadow|⚔️ Sekiro Shadow версия"
    "Dark Matter|https://www.pling.com/p/1603282|pling|dark-matter|🌑 Тёмная материя"
    "Fallout|https://www.pling.com/p/1230882|pling|fallout|☢️ Fallout тема"
    "Linux Mind|https://www.pling.com/p/1397139|pling|linux-mind|🧠 Linux Mind"
    "BSOL|https://github.com/harishnkr/bsol|github|bsol|💙 Blue Screen of Linux"
    "Grand Theft Gentoo|https://gitlab.com/imnotpua/grub_gtg|gitlab|gtg|🚗 GTA стиль для Gentoo"
    "Grubby Terminal|https://gitlab.com/perthshiretim/grubby-terminal|gitlab|grubby-terminal|💻 Терминальная тема"
    "Billy's Agent|https://gitlab.com/Drorago/billys-agent-grub2-theme|gitlab|billys-agent|🕵️ Billy's Agent"
    "LiquidGlass|https://github.com/Purp1eDuck2008/Liquid-GRUB|github|LiquidGlass|💧 Стеклянный эффект"
)

# Функции для красивого вывода
print_header() {
    clear
    echo -e "${PURPLE}"
    echo "╔═══════════════════════════════════════════════════════════════════════════╗"
    echo "║                      🎨 Gorgeous GRUB Installer                          ║"
    echo "║        Интерактивный установщик тем GRUB из коллекции Gorgeous-GRUB      ║"
    echo "╚═══════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ $1${NC}"
}

# Проверка зависимостей
check_dependencies() {
    local missing=()
    
    for cmd in git curl wget sudo; do
        if ! command -v $cmd &> /dev/null; then
            missing+=($cmd)
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        print_error "Отсутствуют зависимости: ${missing[*]}"
        echo "Установите их командой: sudo pacman -S ${missing[*]}"
        exit 1
    fi
}

# Определение пути GRUB
detect_grub() {
    if [ -d "/boot/grub" ]; then
        GRUB_PREFIX="grub"
        GRUB_THEMES_DIR="/boot/grub/themes"
    elif [ -d "/boot/grub2" ]; then
        GRUB_PREFIX="grub2"
        GRUB_THEMES_DIR="/boot/grub2/themes"
    else
        print_error "GRUB не найден!"
        exit 1
    fi
    
    print_info "Используется: /boot/$GRUB_PREFIX"
}

# Получить текущую тему
get_current_theme() {
    if [ -f "$GRUB_CONFIG" ]; then
        grep "^GRUB_THEME=" "$GRUB_CONFIG" 2>/dev/null | cut -d'=' -f2 | tr -d '"' || echo "Не установлена"
    else
        echo "Конфиг не найден"
    fi
}

# Показать список установленных тем
show_installed_themes() {
    echo -e "\n${BOLD}📦 Установленные темы:${NC}"
    if [ -d "$GRUB_THEMES_DIR" ]; then
        local count=0
        for theme_dir in "$GRUB_THEMES_DIR"/*/; do
            if [ -d "$theme_dir" ]; then
                local name=$(basename "$theme_dir")
                if [ -f "$theme_dir/theme.txt" ]; then
                    echo -e "  ${GREEN}●${NC} $name"
                    ((count++))
                fi
            fi
        done
        if [ $count -eq 0 ]; then
            echo -e "  ${YELLOW}Темы не найдены${NC}"
        fi
    else
        echo -e "  ${YELLOW}Папка тем не существует${NC}"
    fi
}

# Показать категории тем
show_categories() {
    echo -e "\n${BOLD}📂 Категории тем:${NC}"
    echo -e "  ${CYAN}1${NC}) 🎮 Игровые (Minecraft, DOOM, Dark Souls...)"
    echo -e "  ${CYAN}2${NC}) 🌃 Киберпанк/Ретро"
    echo -e "  ${CYAN}3${NC}) 🎌 Аниме/Японские"
    echo -e "  ${CYAN}4${NC}) ✨ Минималистичные/Современные"
    echo -e "  ${CYAN}5${NC}) 🚀 Sci-Fi/Космос"
    echo -e "  ${CYAN}6${NC}) 📋 Все темы"
    echo -e "  ${CYAN}0${NC}) ← Назад"
}

# Показать темы по категории
show_themes_by_category() {
    local category=$1
    local start_idx=0
    local end_idx=${#THEMES[@]}
    
    case $category in
        1) # Игровые
            start_idx=0; end_idx=13 ;;
        2) # Киберпанк
            start_idx=13; end_idx=22 ;;
        3) # Аниме
            start_idx=22; end_idx=29 ;;
        4) # Минималистичные
            start_idx=29; end_idx=44 ;;
        5) # Sci-Fi
            start_idx=44; end_idx=47 ;;
        6) # Все
            start_idx=0; end_idx=${#THEMES[@]} ;;
    esac
    
    echo -e "\n${BOLD}🎨 Доступные темы:${NC}\n"
    
    local display_num=1
    for ((i=start_idx; i<end_idx; i++)); do
        IFS='|' read -r name url type folder desc <<< "${THEMES[$i]}"
        printf "  ${CYAN}%2d${NC}) %-25s ${WHITE}%s${NC}\n" "$display_num" "$name" "$desc"
        ((display_num++))
    done
    
    echo -e "\n  ${CYAN} 0${NC}) ← Назад"
    echo ""
    echo -n "Выберите тему для установки: "
    
    read -r choice
    
    if [ "$choice" == "0" ]; then
        return
    fi
    
    local actual_idx=$((start_idx + choice - 1))
    if [ $actual_idx -ge $start_idx ] && [ $actual_idx -lt $end_idx ]; then
        install_theme $actual_idx
    else
        print_error "Неверный выбор"
        sleep 1
    fi
}

# Установка темы
install_theme() {
    local idx=$1
    IFS='|' read -r name url type folder desc <<< "${THEMES[$idx]}"
    
    print_header
    echo -e "${BOLD}🔧 Установка темы: $name${NC}"
    echo -e "${WHITE}$desc${NC}\n"
    
    # Создаём временную директорию
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"
    cd "$TEMP_DIR"
    
    case $type in
        "github")
            install_github_theme "$url" "$folder" "$name"
            ;;
        "github-script")
            install_github_script_theme "$url" "$name"
            ;;
        "github-installer")
            install_github_with_installer "$url" "$name"
            ;;
        "github-subfolder")
            install_github_subfolder_theme "$url" "$folder" "$name"
            ;;
        "pling")
            install_pling_theme "$url" "$folder" "$name"
            ;;
        "gitlab")
            install_gitlab_theme "$url" "$folder" "$name"
            ;;
    esac
    
    # Очистка
    cd /
    rm -rf "$TEMP_DIR"
    
    echo ""
    read -p "Нажмите Enter для продолжения..."
}

# Установка темы с GitHub
install_github_theme() {
    local url=$1
    local folder=$2
    local name=$3
    
    print_info "Клонирование репозитория..."
    git clone --depth 1 "$url.git" repo 2>/dev/null || {
        print_error "Не удалось клонировать репозиторий"
        return 1
    }
    
    # Поиск папки с theme.txt
    local theme_path=""
    theme_path=$(find repo -name "theme.txt" -printf "%h\n" | head -1)
    
    if [ -z "$theme_path" ]; then
        print_error "Файл theme.txt не найден в репозитории"
        return 1
    fi
    
    local theme_name=$(basename "$theme_path")
    
    print_info "Найдена тема: $theme_name"
    print_info "Копирование в $GRUB_THEMES_DIR..."
    
    sudo mkdir -p "$GRUB_THEMES_DIR"
    sudo cp -r "$theme_path" "$GRUB_THEMES_DIR/"
    
    apply_theme "$GRUB_THEMES_DIR/$theme_name/theme.txt"
}

# Установка темы с GitHub с скриптом установки
install_github_script_theme() {
    local url=$1
    local name=$2
    
    print_info "Клонирование репозитория..."
    git clone --depth 1 "$url.git" repo 2>/dev/null || {
        print_error "Не удалось клонировать репозиторий"
        return 1
    }
    
    cd repo
    
    if [ -f "install.sh" ]; then
        print_info "Запуск скрипта установки..."
        sudo bash install.sh
        print_success "Тема установлена!"
    else
        print_error "Скрипт установки не найден"
        return 1
    fi
}

# Установка темы с GitHub с installer
install_github_with_installer() {
    local url=$1
    local name=$2
    
    print_info "Клонирование репозитория..."
    git clone --depth 1 "$url.git" repo 2>/dev/null || {
        print_error "Не удалось клонировать репозиторий"
        return 1
    }
    
    cd repo
    
    if [ -f "install.sh" ]; then
        print_info "Найден скрипт установки. Запускаем..."
        echo -e "${YELLOW}Следуйте инструкциям установщика темы:${NC}\n"
        sudo bash install.sh
        print_success "Установка завершена!"
    else
        # Пробуем найти theme.txt
        install_github_theme "$url" "" "$name"
    fi
}

# Установка темы из подпапки GitHub
install_github_subfolder_theme() {
    local url=$1
    local folder=$2
    local name=$3
    
    print_info "Клонирование репозитория..."
    git clone --depth 1 "$url.git" repo 2>/dev/null || {
        print_error "Не удалось клонировать репозиторий"
        return 1
    }
    
    if [ -d "repo/$folder" ]; then
        local theme_name=$(basename "$folder")
        print_info "Копирование темы из подпапки $folder..."
        
        sudo mkdir -p "$GRUB_THEMES_DIR"
        sudo cp -r "repo/$folder" "$GRUB_THEMES_DIR/$theme_name"
        
        if [ -f "$GRUB_THEMES_DIR/$theme_name/theme.txt" ]; then
            apply_theme "$GRUB_THEMES_DIR/$theme_name/theme.txt"
        else
            print_warning "theme.txt не найден, тема может не работать"
        fi
    else
        print_error "Папка $folder не найдена"
        return 1
    fi
}

# Установка темы из GitLab
install_gitlab_theme() {
    local url=$1
    local folder=$2
    local name=$3
    
    print_info "Клонирование репозитория GitLab..."
    git clone --depth 1 "$url.git" repo 2>/dev/null || {
        print_error "Не удалось клонировать репозиторий"
        return 1
    }
    
    # Поиск папки с theme.txt
    local theme_path=""
    theme_path=$(find repo -name "theme.txt" -printf "%h\n" | head -1)
    
    if [ -z "$theme_path" ]; then
        print_error "Файл theme.txt не найден в репозитории"
        return 1
    fi
    
    local theme_name=$(basename "$theme_path")
    
    print_info "Найдена тема: $theme_name"
    sudo mkdir -p "$GRUB_THEMES_DIR"
    sudo cp -r "$theme_path" "$GRUB_THEMES_DIR/"
    
    apply_theme "$GRUB_THEMES_DIR/$theme_name/theme.txt"
}

# Установка темы с Pling
install_pling_theme() {
    local url=$1
    local folder=$2
    local name=$3
    
    print_warning "Темы с Pling требуют ручной загрузки."
    echo ""
    echo -e "Для установки темы ${BOLD}$name${NC}:"
    echo -e "  1. Откройте: ${CYAN}$url${NC}"
    echo -e "  2. Нажмите на вкладку 'Files'"
    echo -e "  3. Скачайте архив темы"
    echo -e "  4. Распакуйте в: ${CYAN}$GRUB_THEMES_DIR/${NC}"
    echo -e "  5. Запустите этот скрипт снова и выберите 'Применить установленную тему'"
    echo ""
    
    # Открываем URL в браузере
    if command -v xdg-open &> /dev/null; then
        read -p "Открыть ссылку в браузере? [Y/n]: " open_browser
        if [[ "$open_browser" != "n" && "$open_browser" != "N" ]]; then
            xdg-open "$url" 2>/dev/null &
        fi
    fi
}

# Применение темы
apply_theme() {
    local theme_path=$1
    
    print_info "Применение темы..."
    
    # Удаляем старую строку GRUB_THEME и добавляем новую
    sudo sed -i '/^GRUB_THEME=/d' "$GRUB_CONFIG"
    echo "GRUB_THEME=\"$theme_path\"" | sudo tee -a "$GRUB_CONFIG" > /dev/null
    
    # Устанавливаем GRUB_TIMEOUT_STYLE=menu
    if ! grep -q "^GRUB_TIMEOUT_STYLE=menu" "$GRUB_CONFIG"; then
        sudo sed -i '/^GRUB_TIMEOUT_STYLE=/d' "$GRUB_CONFIG"
        echo "GRUB_TIMEOUT_STYLE=menu" | sudo tee -a "$GRUB_CONFIG" > /dev/null
    fi
    
    # Обновляем конфигурацию GRUB
    print_info "Обновление конфигурации GRUB..."
    
    if command -v update-grub &> /dev/null; then
        sudo update-grub
    elif [ -f "/boot/grub/grub.cfg" ]; then
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    elif [ -f "/boot/grub2/grub.cfg" ]; then
        sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    fi
    
    print_success "Тема успешно применена!"
    print_info "Тема: $theme_path"
    print_info "Перезагрузите компьютер, чтобы увидеть изменения."
}

# Применить установленную тему
apply_installed_theme() {
    print_header
    echo -e "${BOLD}📦 Выберите установленную тему для применения:${NC}\n"
    
    if [ ! -d "$GRUB_THEMES_DIR" ]; then
        print_error "Папка тем не существует"
        read -p "Нажмите Enter..."
        return
    fi
    
    local themes=()
    local count=0
    
    for theme_dir in "$GRUB_THEMES_DIR"/*/; do
        if [ -f "$theme_dir/theme.txt" ]; then
            local name=$(basename "$theme_dir")
            themes+=("$name")
            ((count++))
            echo -e "  ${CYAN}$count${NC}) $name"
        fi
    done
    
    if [ $count -eq 0 ]; then
        print_warning "Установленные темы не найдены"
        read -p "Нажмите Enter..."
        return
    fi
    
    echo -e "\n  ${CYAN}0${NC}) ← Назад"
    echo ""
    read -p "Выберите тему: " choice
    
    if [ "$choice" == "0" ] || [ -z "$choice" ]; then
        return
    fi
    
    if [ "$choice" -ge 1 ] && [ "$choice" -le $count ]; then
        local selected_theme="${themes[$((choice-1))]}"
        apply_theme "$GRUB_THEMES_DIR/$selected_theme/theme.txt"
        read -p "Нажмите Enter..."
    else
        print_error "Неверный выбор"
        sleep 1
    fi
}

# Удалить тему
remove_theme() {
    print_header
    echo -e "${BOLD}🗑️ Удаление темы:${NC}\n"
    
    if [ ! -d "$GRUB_THEMES_DIR" ]; then
        print_error "Папка тем не существует"
        read -p "Нажмите Enter..."
        return
    fi
    
    local themes=()
    local count=0
    
    for theme_dir in "$GRUB_THEMES_DIR"/*/; do
        if [ -d "$theme_dir" ]; then
            local name=$(basename "$theme_dir")
            themes+=("$name")
            ((count++))
            echo -e "  ${CYAN}$count${NC}) $name"
        fi
    done
    
    if [ $count -eq 0 ]; then
        print_warning "Установленные темы не найдены"
        read -p "Нажмите Enter..."
        return
    fi
    
    echo -e "\n  ${CYAN}0${NC}) ← Назад"
    echo ""
    read -p "Выберите тему для удаления: " choice
    
    if [ "$choice" == "0" ] || [ -z "$choice" ]; then
        return
    fi
    
    if [ "$choice" -ge 1 ] && [ "$choice" -le $count ]; then
        local selected_theme="${themes[$((choice-1))]}"
        
        echo ""
        read -p "Удалить тему '$selected_theme'? [y/N]: " confirm
        
        if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
            sudo rm -rf "$GRUB_THEMES_DIR/$selected_theme"
            print_success "Тема '$selected_theme' удалена"
        else
            print_info "Отменено"
        fi
        
        read -p "Нажмите Enter..."
    else
        print_error "Неверный выбор"
        sleep 1
    fi
}

# Настройка разрешения GRUB
set_resolution() {
    print_header
    echo -e "${BOLD}🖥️ Настройка разрешения GRUB:${NC}\n"
    
    local current_res=$(grep "^GRUB_GFXMODE=" "$GRUB_CONFIG" 2>/dev/null | cut -d'=' -f2 | tr -d '"')
    echo -e "Текущее разрешение: ${CYAN}${current_res:-auto}${NC}\n"
    
    echo -e "Рекомендуемые разрешения:"
    echo -e "  ${CYAN}1${NC}) 1920x1080"
    echo -e "  ${CYAN}2${NC}) 1366x768"
    echo -e "  ${CYAN}3${NC}) 1280x720"
    echo -e "  ${CYAN}4${NC}) 2560x1440"
    echo -e "  ${CYAN}5${NC}) 3840x2160"
    echo -e "  ${CYAN}6${NC}) auto"
    echo -e "  ${CYAN}7${NC}) Ввести вручную"
    echo -e "\n  ${CYAN}0${NC}) ← Назад"
    echo ""
    read -p "Выберите: " choice
    
    local new_res=""
    case $choice in
        1) new_res="1920x1080" ;;
        2) new_res="1366x768" ;;
        3) new_res="1280x720" ;;
        4) new_res="2560x1440" ;;
        5) new_res="3840x2160" ;;
        6) new_res="auto" ;;
        7) 
            read -p "Введите разрешение (например, 1920x1080): " new_res
            ;;
        0) return ;;
        *) 
            print_error "Неверный выбор"
            sleep 1
            return
            ;;
    esac
    
    if [ -n "$new_res" ]; then
        sudo sed -i "s/^GRUB_GFXMODE=.*/GRUB_GFXMODE=$new_res/" "$GRUB_CONFIG"
        
        if ! grep -q "^GRUB_GFXMODE=" "$GRUB_CONFIG"; then
            echo "GRUB_GFXMODE=$new_res" | sudo tee -a "$GRUB_CONFIG" > /dev/null
        fi
        
        print_info "Обновление конфигурации GRUB..."
        if [ -f "/boot/grub/grub.cfg" ]; then
            sudo grub-mkconfig -o /boot/grub/grub.cfg
        elif [ -f "/boot/grub2/grub.cfg" ]; then
            sudo grub2-mkconfig -o /boot/grub2/grub.cfg
        fi
        
        print_success "Разрешение установлено: $new_res"
        read -p "Нажмите Enter..."
    fi
}

# Отключить двойное меню Minegrub
disable_double_menu() {
    print_info "Отключение двойного меню Minegrub..."
    sudo grub-editenv - unset config_file 2>/dev/null || true
    print_success "Двойное меню отключено"
    sleep 1
}

# Главное меню
main_menu() {
    while true; do
        print_header
        
        local current_theme=$(get_current_theme)
        echo -e "${WHITE}Текущая тема: ${CYAN}$current_theme${NC}\n"
        
        show_installed_themes
        
        echo -e "\n${BOLD}📋 Главное меню:${NC}"
        echo -e "  ${CYAN}1${NC}) 🎨 Установить новую тему"
        echo -e "  ${CYAN}2${NC}) ✅ Применить установленную тему"
        echo -e "  ${CYAN}3${NC}) 🗑️  Удалить тему"
        echo -e "  ${CYAN}4${NC}) 🖥️  Настроить разрешение"
        echo -e "  ${CYAN}5${NC}) 🔄 Отключить двойное меню Minegrub"
        echo -e "  ${CYAN}0${NC}) 🚪 Выход"
        echo ""
        read -p "Выберите действие: " action
        
        case $action in
            1)
                while true; do
                    print_header
                    show_categories
                    echo ""
                    read -p "Выберите категорию: " cat_choice
                    
                    case $cat_choice in
                        0) break ;;
                        [1-6]) show_themes_by_category "$cat_choice" ;;
                        *) print_error "Неверный выбор"; sleep 1 ;;
                    esac
                done
                ;;
            2) apply_installed_theme ;;
            3) remove_theme ;;
            4) set_resolution ;;
            5) disable_double_menu ;;
            0) 
                echo -e "\n${GREEN}До свидания! 👋${NC}\n"
                exit 0 
                ;;
            *) 
                print_error "Неверный выбор"
                sleep 1
                ;;
        esac
    done
}

# Точка входа
check_dependencies
detect_grub
main_menu
