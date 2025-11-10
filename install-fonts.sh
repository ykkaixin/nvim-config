#!/bin/bash

# Nerd Fonts 安装脚本
# 自动检测系统并安装 JetBrainsMono Nerd Font

set -e

echo "========================================"
echo "  Nerd Fonts 自动安装脚本"
echo "========================================"
echo ""

# 检测操作系统
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/debian_version ]; then
            echo "debian"
        elif [ -f /etc/redhat-release ]; then
            echo "redhat"
        elif [ -f /etc/arch-release ]; then
            echo "arch"
        else
            echo "linux"
        fi
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
echo "检测到系统: $OS"
echo ""

# 检查字体是否已安装
check_font_installed() {
    if [[ "$OS" == "macOS" ]]; then
        if ls ~/Library/Fonts/*Nerd*Font* 2>/dev/null | grep -q .; then
            return 0
        fi
        if ls /Library/Fonts/*Nerd*Font* 2>/dev/null | grep -q .; then
            return 0
        fi
    elif [[ "$OS" =~ ^(debian|redhat|arch|linux)$ ]]; then
        if fc-list | grep -i "nerd font" >/dev/null 2>&1; then
            return 0
        fi
    fi
    return 1
}

if check_font_installed; then
    echo "✅ Nerd Font 已经安装！"
    echo ""
    echo "如果终端中还是显示问号，请检查："
    echo "1. 终端设置中是否选择了 Nerd Font 字体"
    echo "2. 重启终端应用"
    exit 0
fi

echo "开始安装 JetBrainsMono Nerd Font..."
echo ""

# macOS 安装
install_macos() {
    echo "macOS 安装方法："
    echo ""

    # 检查 Homebrew
    if command -v brew &> /dev/null; then
        echo "✅ 检测到 Homebrew"
        echo "使用 Homebrew 安装..."
        echo ""

        # 添加 cask-fonts tap
        brew tap homebrew/cask-fonts 2>/dev/null || true

        # 安装字体
        brew install --cask font-jetbrains-mono-nerd-font

        echo ""
        echo "✅ 安装完成！"
    else
        echo "❌ 未检测到 Homebrew"
        echo ""
        echo "请选择安装方式："
        echo "1. 安装 Homebrew 后自动安装字体（推荐）"
        echo "2. 手动下载安装"
        echo ""
        read -p "选择 (1/2): " choice

        if [ "$choice" = "1" ]; then
            echo ""
            echo "安装 Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            echo ""
            echo "安装字体..."
            brew tap homebrew/cask-fonts
            brew install --cask font-jetbrains-mono-nerd-font

            echo ""
            echo "✅ 安装完成！"
        else
            manual_install
        fi
    fi

    echo ""
    echo "📝 下一步："
    echo "1. 打开终端设置（Terminal 或 iTerm2）"
    echo "2. 选择字体为 'JetBrainsMono Nerd Font' 或 'JetBrainsMono Nerd Font Mono'"
    echo "3. 重启终端"
}

# Linux (Debian/Ubuntu) 安装
install_debian() {
    echo "Debian/Ubuntu 安装..."
    echo ""

    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"

    echo "下载 JetBrainsMono Nerd Font..."
    DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
    TEMP_FILE="/tmp/JetBrainsMono.zip"

    if command -v curl &> /dev/null; then
        curl -fLo "$TEMP_FILE" "$DOWNLOAD_URL"
    elif command -v wget &> /dev/null; then
        wget -O "$TEMP_FILE" "$DOWNLOAD_URL"
    else
        echo "❌ 未找到 curl 或 wget，请先安装："
        echo "sudo apt update && sudo apt install curl"
        exit 1
    fi

    echo "解压字体文件..."
    unzip -o "$TEMP_FILE" -d "$FONT_DIR/JetBrainsMono" >/dev/null

    echo "更新字体缓存..."
    fc-cache -fv >/dev/null

    echo "清理临时文件..."
    rm "$TEMP_FILE"

    echo ""
    echo "✅ 安装完成！"
    echo ""
    echo "📝 下一步："
    echo "1. 打开终端设置"
    echo "2. 选择字体为 'JetBrainsMono Nerd Font' 或 'JetBrainsMono Nerd Font Mono'"
    echo "3. 重启终端"
}

# Arch Linux 安装
install_arch() {
    echo "Arch Linux 安装..."
    echo ""

    if command -v yay &> /dev/null; then
        echo "使用 yay 安装..."
        yay -S ttf-jetbrains-mono-nerd
    elif command -v paru &> /dev/null; then
        echo "使用 paru 安装..."
        paru -S ttf-jetbrains-mono-nerd
    else
        echo "使用 pacman 安装（如果在官方仓库）..."
        sudo pacman -S ttf-jetbrains-mono-nerd 2>/dev/null || install_debian
    fi

    echo ""
    echo "✅ 安装完成！"
    echo ""
    echo "📝 下一步："
    echo "1. 打开终端设置"
    echo "2. 选择字体为 'JetBrainsMono Nerd Font'"
    echo "3. 重启终端"
}

# Red Hat/Fedora 安装
install_redhat() {
    echo "Red Hat/Fedora 安装..."
    echo ""
    install_debian  # 使用相同的安装方式
}

# 手动安装说明
manual_install() {
    echo ""
    echo "📥 手动安装步骤："
    echo ""
    echo "1. 访问 Nerd Fonts 下载页面："
    echo "   https://github.com/ryanoasis/nerd-fonts/releases/latest"
    echo ""
    echo "2. 下载 JetBrainsMono.zip"
    echo ""
    echo "3. 解压并安装字体文件："
    if [[ "$OS" == "macOS" ]]; then
        echo "   - 双击 .ttf 文件"
        echo "   - 或将字体拖到 Font Book"
    else
        echo "   - 将 .ttf 文件复制到 ~/.local/share/fonts/"
        echo "   - 运行: fc-cache -fv"
    fi
    echo ""
    echo "4. 在终端设置中选择 'JetBrainsMono Nerd Font'"
    echo ""
}

# 根据系统执行安装
case $OS in
    macOS)
        install_macos
        ;;
    debian)
        install_debian
        ;;
    arch)
        install_arch
        ;;
    redhat)
        install_redhat
        ;;
    linux)
        echo "检测到 Linux 系统，尝试通用安装方式..."
        install_debian
        ;;
    *)
        echo "❌ 不支持的操作系统: $OS"
        echo ""
        manual_install
        exit 1
        ;;
esac

echo ""
echo "========================================"
echo "  安装完成！"
echo "========================================"
echo ""
echo "⚠️ 重要提醒："
echo "1. 重启终端应用"
echo "2. 在终端设置中选择 Nerd Font 字体"
echo "3. 重新打开 nvim 查看效果"
echo ""
echo "如果还是显示问号，请确认："
echo "- 终端字体已设置为 Nerd Font"
echo "- 终端已完全重启"
echo ""
