#!/bin/bash

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                      🎨 Gorgeous GRUB Installer                          ║
# ║        Интерактивный установщик тем GRUB из коллекции Gorgeous-GRUB      ║
# ║                    https://github.com/Jacksaur/Gorgeous-GRUB             ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'
BOLD='\033[1m'

# Конфигурация
GRUB_THEMES_DIR="/boot/grub/themes"
GRUB_CONFIG="/etc/default/grub"
TEMP_DIR="/tmp/gorgeous-grub-install"
USE_GUM=false

# Проверяем наличие gum
if command -v gum &> /dev/null; then
    USE_GUM=true
fi

# База данных тем: "Название|URL|Тип|Папка|Описание|Категория"
declare -a THEMES=(
    # 🎮 Игровые темы
    "Minegrub|https://github.com/Lxtharia/minegrub-theme|github|minegrub|Minecraft главное меню|🎮 Игровые"
    "Minegrub Combined|https://github.com/Lxtharia/double-minegrub-menu|github-script|minegrub|Двойное меню Minecraft|🎮 Игровые"
    "Minegrub World Select|https://github.com/Lxtharia/minegrub-world-sel-theme|github|minegrub-world-selection|Minecraft выбор мира|🎮 Игровые"
    "Grubphemous|https://github.com/pvtoari/grubphemous-theme|github|grubphemous|Blasphemous стиль|🎮 Игровые"
    "DOOM|https://github.com/Lxtharia/doomgrub-theme|github|doomgrub|DOOM стиль|🎮 Игровые"
    "Hollow Grub|https://github.com/sergoncano/hollow-knight-grub-theme|github|hollow-knight|Hollow Knight тема|🎮 Игровые"
    "GrubSouls|https://github.com/PedroMMarinho/grubsouls-theme|github|grubsouls|Dark Souls тема|🎮 Игровые"
    "Grubnautica|https://github.com/tatounee/Grubnautica|github|Grubnautica|Subnautica тема|🎮 Игровые"
    "ULTRAKILL|https://www.pling.com/p/2217746|pling|ultrakill|ULTRAKILL тема|🎮 Игровые"
    "Crossgrub|https://github.com/krypciak/crossgrub|github|crossgrub|CrossCode тема|🎮 Игровые"
    "CelesteGRUB|https://github.com/suilven641/CelesteGRUB|github|CelesteGRUB|Celeste тема|🎮 Игровые"
    "Lobotomy GRUB|https://github.com/rats-scamper/LoboGrubTheme|github|lobogrub|Lobotomy Corporation|🎮 Игровые"
    "Sekiro|https://github.com/semimqmo/sekiro_grub_theme|github|sekiro|Sekiro тема|🎮 Игровые"
    
    # 🌃 Киберпанк/Ретро
    "CyberGRUB-2077|https://github.com/adnksharp/CyberGRUB-2077|github|CyberGRUB-2077|Cyberpunk 2077|🌃 Киберпанк"
    "Cyberpunk 2077|https://www.pling.com/p/1515662|pling|cyberpunk2077|Официальная Cyberpunk|🌃 Киберпанк"
    "CyberRe|https://www.pling.com/p/1420727|pling|cyberre|Кибер-ретро|🌃 Киберпанк"
    "Virtuaverse|https://github.com/Patato777/dotfiles|github-subfolder|grub|Пиксельный киберпанк|🌃 Киберпанк"
    "CRT-Amber|https://www.pling.com/p/1727268|pling|crt-amber|Ретро CRT монитор|🌃 Киберпанк"
    "OldBIOS|https://www.pling.com/p/2072033|pling|oldbios|Старый BIOS|🌃 Киберпанк"
    "Matrix-Morpheus|https://github.com/Priyank-Adhav/Matrix-Morpheus-GRUB-Theme|github|Matrix-Morpheus|Матрица тема|🌃 Киберпанк"
    
    # 🎌 Аниме/Японские
    "YoRHa|https://github.com/OliveThePuffin/yorha-grub-theme|github|yorha|NieR: Automata|🎌 Аниме"
    "Persona 5 Royal|https://www.pling.com/p/2122684|pling|persona5|Persona 5 Royal|🎌 Аниме"
    "Wuthering Waves|https://www.pling.com/p/2184155|pling|wuthering-waves|Wuthering Waves|🎌 Аниме"
    "Grubshin Bootpact|https://github.com/max-ishere/grubshin-bootpact|github-installer|grubshin|Genshin Impact|🎌 Аниме"
    "VA-11 HALL-A|https://github.com/happyzxzxz/valhallaDots|github-subfolder|grub|VA-11 HALL-A бар|🎌 Аниме"
    "Milk Outside|https://www.pling.com/p/2296341|pling|milk|Milk Outside A Bag|🎌 Аниме"
    
    # ✨ Минималистичные
    "Catppuccin|https://github.com/catppuccin/grub|github-installer|catppuccin|Пастельная тема|✨ Минимализм"
    "Sleek|https://www.pling.com/p/1414997|pling|sleek|Элегантная тема|✨ Минимализм"
    "HyperFluent|https://www.pling.com/p/2133341|pling|hyperfluent|Windows 11 стиль|✨ Минимализм"
    "Elegant|https://github.com/vinceliuice/Elegant-grub2-themes|github-installer|Elegant|Элегантный набор|✨ Минимализм"
    "Modern Design|https://github.com/vinceliuice/grub2-themes|github-installer|grub2-themes|Современный дизайн|✨ Минимализм"
    "Graphite|https://www.pling.com/p/1676418|pling|graphite|Графитовая|✨ Минимализм"
    "Neumorphic|https://www.pling.com/p/1906415|pling|neumorphic|Неоморфизм|✨ Минимализм"
    "Breeze|https://www.pling.com/p/1000111|pling|breeze|KDE Breeze|✨ Минимализм"
    "Solarized-Dark|https://www.pling.com/p/1177401|pling|solarized-dark|Solarized Dark|✨ Минимализм"
    "Framework|https://github.com/HeinrichZurHorstMeyer/Framework-Grub-Theme|github|Framework|Framework Laptop|✨ Минимализм"
    
    # 🚀 Sci-Fi/Космос
    "Space Isolation|https://github.com/callmenoodles/space-isolation|github|space-isolation|Космическая изоляция|🚀 Sci-Fi"
    "Descent|https://www.pling.com/p/1000083|pling|descent|Классическая Descent|🚀 Sci-Fi"
    "SteamOS|https://github.com/LegendaryBibo/Steam-Big-Picture-Grub-Theme|github|steam|Steam Big Picture|🚀 Sci-Fi"
    
    # 🎭 Другие
    "DedSec|https://www.pling.com/p/1569525|pling|dedsec|Watch Dogs DedSec|🎭 Другие"
    "Dark Matter|https://www.pling.com/p/1603282|pling|dark-matter|Тёмная материя|🎭 Другие"
    "Fallout|https://www.pling.com/p/1230882|pling|fallout|Fallout тема|🎭 Другие"
    "BSOL|https://github.com/harishnkr/bsol|github|bsol|Blue Screen of Linux|🎭 Другие"
    "Grand Theft Gentoo|https://gitlab.com/imnotpua/grub_gtg|gitlab|gtg|GTA стиль|🎭 Другие"
    "LiquidGlass|https://github.com/Purp1eDuck2008/Liquid-GRUB|github|LiquidGlass|Стеклянный эффект|🎭 Другие"
)

# ════════════════════════════════════════════════════════════════════════════
# 🎨 GUM-стилизованные функции
# ════════════════════════════════════════════════════════════════════════════

print_header() {
    if $USE_GUM; then
        clear
        gum style \
            --border double \
            --border-foreground 212 \
            --padding "1 3" \
            --margin "1" \
            --align center \
            "🎨 $(gum style --foreground 212 --bold 'Gorgeous GRUB Installer')" \
            "" \
            "$(gum style --foreground 245 'Красивые темы для вашего загрузчика')"
    else
        clear
        echo -e "${PURPLE}"
        echo "╔═══════════════════════════════════════════════════════════════════════════╗"
        echo "║                      🎨 Gorgeous GRUB Installer                          ║"
        echo "║              Красивые темы для вашего загрузчика                         ║"
        echo "╚═══════════════════════════════════════════════════════════════════════════╝"
        echo -e "${NC}"
    fi
}

print_success() {
    if $USE_GUM; then
        gum style --foreground 10 "✓ $1"
    else
        echo -e "${GREEN}✓ $1${NC}"
    fi
}

print_error() {
    if $USE_GUM; then
        gum style --foreground 9 "✗ $1"
    else
        echo -e "${RED}✗ $1${NC}"
    fi
}

print_warning() {
    if $USE_GUM; then
        gum style --foreground 11 "⚠ $1"
    else
        echo -e "${YELLOW}⚠ $1${NC}"
    fi
}

print_info() {
    if $USE_GUM; then
        gum style --foreground 12 "ℹ $1"
    else
        echo -e "${CYAN}ℹ $1${NC}"
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# 🔧 Системные функции
# ════════════════════════════════════════════════════════════════════════════

check_dependencies() {
    local missing=()
    for cmd in git sudo; do
        if ! command -v $cmd &> /dev/null; then
            missing+=($cmd)
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        print_error "Отсутствуют зависимости: ${missing[*]}"
        exit 1
    fi
}

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
}

get_current_theme() {
    if [ -f "$GRUB_CONFIG" ]; then
        local theme=$(grep "^GRUB_THEME=" "$GRUB_CONFIG" 2>/dev/null | cut -d'=' -f2 | tr -d '"')
        if [ -n "$theme" ]; then
            basename "$(dirname "$theme")"
        else
            echo "Не установлена"
        fi
    else
        echo "Конфиг не найден"
    fi
}

get_installed_themes() {
    local themes=()
    if [ -d "$GRUB_THEMES_DIR" ]; then
        for theme_dir in "$GRUB_THEMES_DIR"/*/; do
            if [ -f "$theme_dir/theme.txt" ]; then
                themes+=("$(basename "$theme_dir")")
            fi
        done
    fi
    echo "${themes[@]}"
}

# ════════════════════════════════════════════════════════════════════════════
# 📦 Функции установки
# ════════════════════════════════════════════════════════════════════════════

install_github_theme() {
    local url=$1
    local folder=$2
    local name=$3
    
    print_info "Клонирование репозитория..."
    
    if $USE_GUM; then
        gum spin --spinner dot --title "Клонирование $name..." -- \
            git clone --depth 1 "$url.git" repo 2>/dev/null
    else
        git clone --depth 1 "$url.git" repo 2>/dev/null
    fi
    
    if [ $? -ne 0 ]; then
        print_error "Не удалось клонировать репозиторий"
        return 1
    fi
    
    local theme_path=""
    theme_path=$(find repo -name "theme.txt" -printf "%h\n" 2>/dev/null | head -1)
    
    if [ -z "$theme_path" ]; then
        print_error "Файл theme.txt не найден"
        return 1
    fi
    
    local theme_name=$(basename "$theme_path")
    print_info "Найдена тема: $theme_name"
    
    sudo mkdir -p "$GRUB_THEMES_DIR"
    sudo cp -r "$theme_path" "$GRUB_THEMES_DIR/"
    
    apply_theme "$GRUB_THEMES_DIR/$theme_name/theme.txt"
}

install_github_script_theme() {
    local url=$1
    local name=$2
    
    print_info "Клонирование репозитория..."
    
    if $USE_GUM; then
        gum spin --spinner dot --title "Клонирование $name..." -- \
            git clone --depth 1 "$url.git" repo 2>/dev/null
    else
        git clone --depth 1 "$url.git" repo 2>/dev/null
    fi
    
    if [ $? -ne 0 ]; then
        print_error "Не удалось клонировать репозиторий"
        return 1
    fi
    
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

install_github_with_installer() {
    local url=$1
    local name=$2
    
    print_info "Клонирование репозитория..."
    
    if $USE_GUM; then
        gum spin --spinner dot --title "Клонирование $name..." -- \
            git clone --depth 1 "$url.git" repo 2>/dev/null
    else
        git clone --depth 1 "$url.git" repo 2>/dev/null
    fi
    
    if [ $? -ne 0 ]; then
        print_error "Не удалось клонировать репозиторий"
        return 1
    fi
    
    cd repo
    
    if [ -f "install.sh" ]; then
        print_info "Запуск установщика темы..."
        sudo bash install.sh
        print_success "Установка завершена!"
    else
        cd ..
        install_github_theme "$url" "" "$name"
    fi
}

install_github_subfolder_theme() {
    local url=$1
    local folder=$2
    local name=$3
    
    print_info "Клонирование репозитория..."
    
    if $USE_GUM; then
        gum spin --spinner dot --title "Клонирование $name..." -- \
            git clone --depth 1 "$url.git" repo 2>/dev/null
    else
        git clone --depth 1 "$url.git" repo 2>/dev/null
    fi
    
    if [ $? -ne 0 ]; then
        print_error "Не удалось клонировать репозиторий"
        return 1
    fi
    
    if [ -d "repo/$folder" ]; then
        local theme_name=$(basename "$folder")
        sudo mkdir -p "$GRUB_THEMES_DIR"
        sudo cp -r "repo/$folder" "$GRUB_THEMES_DIR/$theme_name"
        
        if [ -f "$GRUB_THEMES_DIR/$theme_name/theme.txt" ]; then
            apply_theme "$GRUB_THEMES_DIR/$theme_name/theme.txt"
        else
            print_warning "theme.txt не найден"
        fi
    else
        print_error "Папка $folder не найдена"
        return 1
    fi
}

install_gitlab_theme() {
    local url=$1
    local folder=$2
    local name=$3
    
    print_info "Клонирование репозитория GitLab..."
    
    if $USE_GUM; then
        gum spin --spinner dot --title "Клонирование $name..." -- \
            git clone --depth 1 "$url.git" repo 2>/dev/null
    else
        git clone --depth 1 "$url.git" repo 2>/dev/null
    fi
    
    if [ $? -ne 0 ]; then
        print_error "Не удалось клонировать репозиторий"
        return 1
    fi
    
    local theme_path=""
    theme_path=$(find repo -name "theme.txt" -printf "%h\n" 2>/dev/null | head -1)
    
    if [ -z "$theme_path" ]; then
        print_error "Файл theme.txt не найден"
        return 1
    fi
    
    local theme_name=$(basename "$theme_path")
    sudo mkdir -p "$GRUB_THEMES_DIR"
    sudo cp -r "$theme_path" "$GRUB_THEMES_DIR/"
    
    apply_theme "$GRUB_THEMES_DIR/$theme_name/theme.txt"
}

install_pling_theme() {
    local url=$1
    local folder=$2
    local name=$3
    
    print_warning "Темы с Pling требуют ручной загрузки."
    echo ""
    
    if $USE_GUM; then
        gum style --foreground 15 "Для установки темы $(gum style --bold "$name"):"
        echo "  1. Откройте: $(gum style --foreground 12 "$url")"
        echo "  2. Нажмите на вкладку 'Files'"
        echo "  3. Скачайте архив темы"
        echo "  4. Распакуйте в: $(gum style --foreground 12 "$GRUB_THEMES_DIR/")"
        echo "  5. Запустите скрипт снова и примените тему"
        echo ""
        
        if gum confirm "Открыть ссылку в браузере?"; then
            xdg-open "$url" 2>/dev/null &
        fi
    else
        echo -e "Для установки темы ${BOLD}$name${NC}:"
        echo -e "  1. Откройте: ${CYAN}$url${NC}"
        echo -e "  2. Нажмите на вкладку 'Files'"
        echo -e "  3. Скачайте архив темы"  
        echo -e "  4. Распакуйте в: ${CYAN}$GRUB_THEMES_DIR/${NC}"
        echo -e "  5. Запустите скрипт снова и примените тему"
    fi
}

apply_theme() {
    local theme_path=$1
    
    print_info "Применение темы..."
    
    sudo sed -i '/^GRUB_THEME=/d' "$GRUB_CONFIG"
    echo "GRUB_THEME=\"$theme_path\"" | sudo tee -a "$GRUB_CONFIG" > /dev/null
    
    if ! grep -q "^GRUB_TIMEOUT_STYLE=menu" "$GRUB_CONFIG"; then
        sudo sed -i '/^GRUB_TIMEOUT_STYLE=/d' "$GRUB_CONFIG"
        echo "GRUB_TIMEOUT_STYLE=menu" | sudo tee -a "$GRUB_CONFIG" > /dev/null
    fi
    
    print_info "Обновление конфигурации GRUB..."
    
    if $USE_GUM; then
        gum spin --spinner dot --title "Обновление GRUB..." -- \
            sudo grub-mkconfig -o /boot/$GRUB_PREFIX/grub.cfg 2>/dev/null
    else
        sudo grub-mkconfig -o /boot/$GRUB_PREFIX/grub.cfg 2>/dev/null
    fi
    
    print_success "Тема успешно применена!"
    print_info "Перезагрузите компьютер, чтобы увидеть изменения."
}

install_theme() {
    local idx=$1
    IFS='|' read -r name url type folder desc category <<< "${THEMES[$idx]}"
    
    print_header
    
    if $USE_GUM; then
        gum style \
            --border rounded \
            --border-foreground 212 \
            --padding "1 2" \
            --margin "1" \
            "🔧 Установка: $(gum style --bold --foreground 212 "$name")" \
            "" \
            "$(gum style --foreground 245 "$desc")"
    else
        echo -e "${BOLD}🔧 Установка темы: $name${NC}"
        echo -e "${WHITE}$desc${NC}\n"
    fi
    
    echo ""
    
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"
    cd "$TEMP_DIR"
    
    case $type in
        "github") install_github_theme "$url" "$folder" "$name" ;;
        "github-script") install_github_script_theme "$url" "$name" ;;
        "github-installer") install_github_with_installer "$url" "$name" ;;
        "github-subfolder") install_github_subfolder_theme "$url" "$folder" "$name" ;;
        "pling") install_pling_theme "$url" "$folder" "$name" ;;
        "gitlab") install_gitlab_theme "$url" "$folder" "$name" ;;
    esac
    
    cd /
    rm -rf "$TEMP_DIR"
    
    echo ""
    if $USE_GUM; then
        gum input --placeholder "Нажмите Enter для продолжения..." > /dev/null
    else
        read -p "Нажмите Enter для продолжения..."
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# 🎮 Интерактивное меню с GUM
# ════════════════════════════════════════════════════════════════════════════

select_theme_to_install() {
    print_header
    
    if $USE_GUM; then
        # Собираем список тем для выбора
        local options=()
        for theme_data in "${THEMES[@]}"; do
            IFS='|' read -r name url type folder desc category <<< "$theme_data"
            options+=("$category  $name  •  $desc")
        done
        
        echo ""
        gum style --foreground 212 --bold "🎨 Выберите тему для установки"
        gum style --foreground 245 "Используйте ↑↓ для навигации, Enter для выбора, Esc для отмены"
        echo ""
        
        local selected
        selected=$(printf '%s\n' "${options[@]}" | gum filter \
            --height 20 \
            --placeholder "Поиск темы..." \
            --indicator "▸" \
            --indicator.foreground 212 \
            --match.foreground 212)
        
        if [ -z "$selected" ]; then
            return
        fi
        
        # Находим индекс выбранной темы
        local idx=0
        for theme_data in "${THEMES[@]}"; do
            IFS='|' read -r name url type folder desc category <<< "$theme_data"
            local check="$category  $name  •  $desc"
            if [ "$check" == "$selected" ]; then
                install_theme $idx
                return
            fi
            ((idx++))
        done
    else
        # Fallback без gum
        echo -e "${BOLD}🎨 Доступные темы:${NC}\n"
        
        local idx=1
        for theme_data in "${THEMES[@]}"; do
            IFS='|' read -r name url type folder desc category <<< "$theme_data"
            printf "  ${CYAN}%2d${NC}) %-20s ${WHITE}%s${NC}\n" "$idx" "$name" "$desc"
            ((idx++))
        done
        
        echo -e "\n  ${CYAN} 0${NC}) ← Назад"
        echo ""
        read -p "Выберите тему: " choice
        
        if [ "$choice" == "0" ] || [ -z "$choice" ]; then
            return
        fi
        
        if [ "$choice" -ge 1 ] && [ "$choice" -le ${#THEMES[@]} ]; then
            install_theme $((choice - 1))
        fi
    fi
}

select_installed_theme() {
    print_header
    
    local themes=($(get_installed_themes))
    
    if [ ${#themes[@]} -eq 0 ]; then
        print_warning "Установленные темы не найдены"
        sleep 2
        return
    fi
    
    if $USE_GUM; then
        echo ""
        gum style --foreground 212 --bold "✅ Выберите тему для применения"
        echo ""
        
        local selected
        selected=$(printf '%s\n' "${themes[@]}" | gum choose \
            --cursor "▸ " \
            --cursor.foreground 212 \
            --selected.foreground 212)
        
        if [ -n "$selected" ]; then
            apply_theme "$GRUB_THEMES_DIR/$selected/theme.txt"
            gum input --placeholder "Нажмите Enter..." > /dev/null
        fi
    else
        echo -e "${BOLD}📦 Установленные темы:${NC}\n"
        
        local idx=1
        for theme in "${themes[@]}"; do
            echo -e "  ${CYAN}$idx${NC}) $theme"
            ((idx++))
        done
        
        echo -e "\n  ${CYAN}0${NC}) ← Назад"
        echo ""
        read -p "Выберите тему: " choice
        
        if [ "$choice" == "0" ] || [ -z "$choice" ]; then
            return
        fi
        
        if [ "$choice" -ge 1 ] && [ "$choice" -le ${#themes[@]} ]; then
            apply_theme "$GRUB_THEMES_DIR/${themes[$((choice-1))]}/theme.txt"
            read -p "Нажмите Enter..."
        fi
    fi
}

remove_theme_menu() {
    print_header
    
    local themes=($(get_installed_themes))
    
    if [ ${#themes[@]} -eq 0 ]; then
        print_warning "Установленные темы не найдены"
        sleep 2
        return
    fi
    
    if $USE_GUM; then
        echo ""
        gum style --foreground 9 --bold "🗑️ Выберите тему для удаления"
        echo ""
        
        local selected
        selected=$(printf '%s\n' "${themes[@]}" | gum choose \
            --cursor "▸ " \
            --cursor.foreground 9)
        
        if [ -n "$selected" ]; then
            if gum confirm "Удалить тему '$selected'?"; then
                sudo rm -rf "$GRUB_THEMES_DIR/$selected"
                print_success "Тема '$selected' удалена"
            fi
            gum input --placeholder "Нажмите Enter..." > /dev/null
        fi
    else
        echo -e "${BOLD}🗑️ Удаление темы:${NC}\n"
        
        local idx=1
        for theme in "${themes[@]}"; do
            echo -e "  ${CYAN}$idx${NC}) $theme"
            ((idx++))
        done
        
        echo -e "\n  ${CYAN}0${NC}) ← Назад"
        echo ""
        read -p "Выберите тему: " choice
        
        if [ "$choice" == "0" ] || [ -z "$choice" ]; then
            return
        fi
        
        if [ "$choice" -ge 1 ] && [ "$choice" -le ${#themes[@]} ]; then
            local selected="${themes[$((choice-1))]}"
            read -p "Удалить тему '$selected'? [y/N]: " confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                sudo rm -rf "$GRUB_THEMES_DIR/$selected"
                print_success "Тема удалена"
            fi
            read -p "Нажмите Enter..."
        fi
    fi
}

set_resolution_menu() {
    print_header
    
    local current_res=$(grep "^GRUB_GFXMODE=" "$GRUB_CONFIG" 2>/dev/null | cut -d'=' -f2 | tr -d '"')
    
    if $USE_GUM; then
        echo ""
        gum style --foreground 212 --bold "🖥️ Настройка разрешения GRUB"
        gum style --foreground 245 "Текущее: ${current_res:-auto}"
        echo ""
        
        local resolutions=("1920x1080" "2560x1440" "1366x768" "1280x720" "3840x2160" "auto" "Ввести вручную...")
        
        local selected
        selected=$(printf '%s\n' "${resolutions[@]}" | gum choose \
            --cursor "▸ " \
            --cursor.foreground 212)
        
        if [ -z "$selected" ]; then
            return
        fi
        
        local new_res="$selected"
        if [ "$selected" == "Ввести вручную..." ]; then
            new_res=$(gum input --placeholder "Введите разрешение (например, 1920x1080)")
        fi
        
        if [ -n "$new_res" ]; then
            sudo sed -i "s/^GRUB_GFXMODE=.*/GRUB_GFXMODE=$new_res/" "$GRUB_CONFIG"
            if ! grep -q "^GRUB_GFXMODE=" "$GRUB_CONFIG"; then
                echo "GRUB_GFXMODE=$new_res" | sudo tee -a "$GRUB_CONFIG" > /dev/null
            fi
            
            gum spin --spinner dot --title "Обновление GRUB..." -- \
                sudo grub-mkconfig -o /boot/$GRUB_PREFIX/grub.cfg 2>/dev/null
            
            print_success "Разрешение установлено: $new_res"
            gum input --placeholder "Нажмите Enter..." > /dev/null
        fi
    else
        echo -e "${BOLD}🖥️ Настройка разрешения GRUB:${NC}\n"
        echo -e "Текущее разрешение: ${CYAN}${current_res:-auto}${NC}\n"
        
        echo -e "  ${CYAN}1${NC}) 1920x1080"
        echo -e "  ${CYAN}2${NC}) 2560x1440"
        echo -e "  ${CYAN}3${NC}) 1366x768"
        echo -e "  ${CYAN}4${NC}) auto"
        echo -e "\n  ${CYAN}0${NC}) ← Назад"
        echo ""
        read -p "Выберите: " choice
        
        local new_res=""
        case $choice in
            1) new_res="1920x1080" ;;
            2) new_res="2560x1440" ;;
            3) new_res="1366x768" ;;
            4) new_res="auto" ;;
            0) return ;;
        esac
        
        if [ -n "$new_res" ]; then
            sudo sed -i "s/^GRUB_GFXMODE=.*/GRUB_GFXMODE=$new_res/" "$GRUB_CONFIG"
            sudo grub-mkconfig -o /boot/$GRUB_PREFIX/grub.cfg 2>/dev/null
            print_success "Разрешение установлено: $new_res"
            read -p "Нажмите Enter..."
        fi
    fi
}

# ════════════════════════════════════════════════════════════════════════════
# 🏠 Главное меню
# ════════════════════════════════════════════════════════════════════════════

main_menu() {
    while true; do
        print_header
        
        local current_theme=$(get_current_theme)
        local installed_themes=($(get_installed_themes))
        
        if $USE_GUM; then
            # Статус
            gum style --foreground 245 "Текущая тема: $(gum style --foreground 212 --bold "$current_theme")"
            gum style --foreground 245 "Установлено тем: $(gum style --foreground 10 "${#installed_themes[@]}")"
            echo ""
            
            # Меню
            local options=(
                "🎨 Установить новую тему"
                "✅ Применить установленную тему"
                "🗑️  Удалить тему"
                "🖥️  Настроить разрешение"
                "🔄 Отключить двойное меню Minegrub"
                "🚪 Выход"
            )
            
            local selected
            selected=$(printf '%s\n' "${options[@]}" | gum choose \
                --cursor "▸ " \
                --cursor.foreground 212 \
                --selected.foreground 212 \
                --height 8)
            
            case "$selected" in
                "🎨 Установить новую тему") select_theme_to_install ;;
                "✅ Применить установленную тему") select_installed_theme ;;
                "🗑️  Удалить тему") remove_theme_menu ;;
                "🖥️  Настроить разрешение") set_resolution_menu ;;
                "🔄 Отключить двойное меню Minegrub")
                    sudo grub-editenv - unset config_file 2>/dev/null || true
                    print_success "Двойное меню отключено"
                    sleep 1
                    ;;
                "🚪 Выход")
                    echo ""
                    gum style --foreground 10 "До свидания! 👋"
                    exit 0
                    ;;
            esac
        else
            # Fallback без gum
            echo -e "${WHITE}Текущая тема: ${CYAN}$current_theme${NC}"
            echo -e "${WHITE}Установлено тем: ${GREEN}${#installed_themes[@]}${NC}\n"
            
            echo -e "${BOLD}📋 Главное меню:${NC}"
            echo -e "  ${CYAN}1${NC}) 🎨 Установить новую тему"
            echo -e "  ${CYAN}2${NC}) ✅ Применить установленную тему"
            echo -e "  ${CYAN}3${NC}) 🗑️  Удалить тему"
            echo -e "  ${CYAN}4${NC}) 🖥️  Настроить разрешение"
            echo -e "  ${CYAN}5${NC}) 🔄 Отключить двойное меню Minegrub"
            echo -e "  ${CYAN}0${NC}) 🚪 Выход"
            echo ""
            read -p "Выберите действие: " action
            
            case $action in
                1) select_theme_to_install ;;
                2) select_installed_theme ;;
                3) remove_theme_menu ;;
                4) set_resolution_menu ;;
                5)
                    sudo grub-editenv - unset config_file 2>/dev/null || true
                    print_success "Двойное меню отключено"
                    sleep 1
                    ;;
                0)
                    echo -e "\n${GREEN}До свидания! 👋${NC}\n"
                    exit 0
                    ;;
            esac
        fi
    done
}

# ════════════════════════════════════════════════════════════════════════════
# 📖 CLI режим
# ════════════════════════════════════════════════════════════════════════════

show_help() {
    echo -e "${BOLD}🎨 Gorgeous GRUB Installer${NC}"
    echo ""
    echo "Использование:"
    echo "  ./gorgeous-grub.sh              Интерактивный режим"
    echo "  ./gorgeous-grub.sh --list       Показать все темы"
    echo "  ./gorgeous-grub.sh --search Q   Поиск темы"
    echo "  ./gorgeous-grub.sh --install N  Установить тему"
    echo "  ./gorgeous-grub.sh --help       Эта справка"
    echo ""
}

list_all_themes() {
    echo -e "${BOLD}🎨 Доступные темы:${NC}\n"
    
    local idx=1
    for theme_data in "${THEMES[@]}"; do
        IFS='|' read -r name url type folder desc category <<< "$theme_data"
        printf "  ${CYAN}%2d${NC}) %-22s ${WHITE}%-30s${NC} ${PURPLE}%s${NC}\n" "$idx" "$name" "$desc" "$category"
        ((idx++))
    done
    
    echo ""
    echo -e "💡 Используйте: ${CYAN}./gorgeous-grub.sh --install \"Название\"${NC}"
}

search_theme() {
    local query=$1
    echo -e "${BOLD}🔍 Поиск: $query${NC}\n"
    
    local found=0
    local idx=1
    for theme_data in "${THEMES[@]}"; do
        IFS='|' read -r name url type folder desc category <<< "$theme_data"
        if echo "$name $desc $category" | grep -iq "$query"; then
            printf "  ${CYAN}%2d${NC}) %-22s ${WHITE}%s${NC}\n" "$idx" "$name" "$desc"
            found=1
        fi
        ((idx++))
    done
    
    [ $found -eq 0 ] && echo -e "  ${YELLOW}Ничего не найдено${NC}"
}

install_by_name() {
    local query=$1
    
    local idx=0
    for theme_data in "${THEMES[@]}"; do
        IFS='|' read -r name url type folder desc category <<< "$theme_data"
        if echo "$name" | grep -iq "^$query$" || echo "$name" | grep -iq "$query"; then
            print_info "Найдена тема: $name"
            install_theme $idx
            return 0
        fi
        ((idx++))
    done
    
    print_error "Тема '$query' не найдена"
    echo "Используйте --list для просмотра тем"
    exit 1
}

# ════════════════════════════════════════════════════════════════════════════
# 🚀 Точка входа
# ════════════════════════════════════════════════════════════════════════════

check_dependencies
detect_grub

case "${1:-}" in
    --help|-h) show_help; exit 0 ;;
    --list|-l) list_all_themes; exit 0 ;;
    --search|-s)
        [ -z "${2:-}" ] && { print_error "Укажите запрос"; exit 1; }
        search_theme "$2"; exit 0 ;;
    --install|-i)
        [ -z "${2:-}" ] && { print_error "Укажите название темы"; exit 1; }
        install_by_name "$2"; exit 0 ;;
    "") main_menu ;;
    *) print_error "Неизвестный аргумент: $1"; show_help; exit 1 ;;
esac
