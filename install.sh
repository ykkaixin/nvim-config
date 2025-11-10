#!/bin/bash

# Neovim Configuration Installation Script
# This script sets up the Neovim configuration on a new system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Neovim Configuration Installer${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}Error: Neovim is not installed!${NC}"
    echo ""
    echo "Please install Neovim first:"
    echo ""
    echo "  macOS:   brew install neovim"
    echo "  Ubuntu:  sudo apt install neovim"
    echo "  Arch:    sudo pacman -S neovim"
    echo "  Fedora:  sudo dnf install neovim"
    echo ""
    echo "Or download from: https://github.com/neovim/neovim/releases"
    exit 1
fi

echo -e "${GREEN}✓${NC} Neovim is installed"

# Check Neovim version
NVIM_VERSION=$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
echo -e "${GREEN}✓${NC} Neovim version: $NVIM_VERSION"

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# Backup existing configuration if it exists
if [ -d "$CONFIG_DIR" ]; then
    BACKUP_DIR="${CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    echo ""
    echo -e "${YELLOW}Warning: Existing Neovim configuration found at $CONFIG_DIR${NC}"
    echo -e "${YELLOW}Creating backup at $BACKUP_DIR${NC}"
    mv "$CONFIG_DIR" "$BACKUP_DIR"
    echo -e "${GREEN}✓${NC} Backup created"
fi

# Create symlink or copy configuration
echo ""
echo "Choose installation method:"
echo "  1) Symlink (recommended - allows easy updates via git pull)"
echo "  2) Copy (standalone - no connection to git repo)"
echo ""
read -p "Enter choice [1-2]: " choice

case $choice in
    1)
        echo ""
        echo "Creating symlink from $SCRIPT_DIR to $CONFIG_DIR"
        ln -sf "$SCRIPT_DIR" "$CONFIG_DIR"
        echo -e "${GREEN}✓${NC} Symlink created"
        ;;
    2)
        echo ""
        echo "Copying configuration from $SCRIPT_DIR to $CONFIG_DIR"
        mkdir -p "$CONFIG_DIR"
        cp -r "$SCRIPT_DIR"/{init.lua,lua} "$CONFIG_DIR/"
        echo -e "${GREEN}✓${NC} Configuration copied"
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac

# Install required dependencies
echo ""
echo -e "${YELLOW}Checking for required dependencies...${NC}"

# Check for git
if ! command -v git &> /dev/null; then
    echo -e "${RED}✗ Git is not installed${NC}"
    echo "Please install git first"
    exit 1
fi
echo -e "${GREEN}✓${NC} Git is installed"

# Check for Python and pip
if command -v python3 &> /dev/null; then
    echo -e "${GREEN}✓${NC} Python3 is installed"

    # Check for pip
    if command -v pip3 &> /dev/null; then
        echo -e "${GREEN}✓${NC} pip3 is installed"
    else
        echo -e "${YELLOW}! pip3 is not installed. Some Python features may not work.${NC}"
    fi
else
    echo -e "${YELLOW}! Python3 is not installed. Python LSP features will not work.${NC}"
fi

# Check for Node.js (needed for many LSP servers)
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✓${NC} Node.js is installed ($NODE_VERSION)"
else
    echo -e "${YELLOW}! Node.js is not installed. Some LSP servers require Node.js.${NC}"
    echo "  Install from: https://nodejs.org/"
fi

# Check for ripgrep (for Telescope live_grep)
if command -v rg &> /dev/null; then
    echo -e "${GREEN}✓${NC} ripgrep is installed"
else
    echo -e "${YELLOW}! ripgrep is not installed. Live grep in Telescope will not work.${NC}"
    echo "  Install: brew install ripgrep (macOS) or apt install ripgrep (Linux)"
fi

# Check for fd (optional but recommended for Telescope)
if command -v fd &> /dev/null; then
    echo -e "${GREEN}✓${NC} fd is installed"
else
    echo -e "${YELLOW}! fd is not installed (optional but recommended for Telescope)${NC}"
    echo "  Install: brew install fd (macOS) or apt install fd-find (Linux)"
fi

# Check for Nerd Fonts (required for icons in Markdown Typora mode)
echo ""
echo -e "${YELLOW}Checking for Nerd Fonts...${NC}"
NERD_FONT_INSTALLED=false

if [[ "$OSTYPE" == "darwin"* ]]; then
    if ls ~/Library/Fonts/*Nerd*Font* 2>/dev/null | grep -q .; then
        NERD_FONT_INSTALLED=true
    elif ls /Library/Fonts/*Nerd*Font* 2>/dev/null | grep -q .; then
        NERD_FONT_INSTALLED=true
    fi
elif fc-list 2>/dev/null | grep -i "nerd font" >/dev/null; then
    NERD_FONT_INSTALLED=true
fi

if [ "$NERD_FONT_INSTALLED" = true ]; then
    echo -e "${GREEN}✓${NC} Nerd Fonts is installed"
else
    echo -e "${YELLOW}! Nerd Fonts not detected${NC}"
    echo ""
    echo "  Nerd Fonts are required for:"
    echo "  • Markdown Typora mode (icons for headers, lists, checkboxes)"
    echo "  • File explorer icons"
    echo "  • Status line icons"
    echo ""
    read -p "Install Nerd Fonts now? [y/N]: " install_fonts

    if [[ "$install_fonts" =~ ^[Yy]$ ]]; then
        echo ""
        echo "Installing Nerd Fonts..."
        bash "$SCRIPT_DIR/install-fonts.sh"
    else
        echo ""
        echo "  You can install Nerd Fonts later by running:"
        echo "  ./install-fonts.sh"
        echo ""
        echo "  Or manually install from: https://www.nerdfonts.com/"
    fi
fi

# First run setup
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Next steps:"
echo ""
echo "  1. Launch Neovim by running: nvim"
echo ""
echo "  2. On first launch, lazy.nvim will automatically install all plugins"
echo "     This may take a few minutes. Please be patient!"
echo ""
echo "  3. After plugins are installed, Mason will install LSP servers"
echo "     Run :Mason to see the status"
echo ""
echo "  4. For AI autocomplete, authenticate Codeium (free):"
echo "     Run :Codeium Auth in Neovim and follow the instructions"
echo ""
echo "  5. To update plugins later, run :Lazy sync in Neovim"
echo ""
echo "Key features included:"
echo "  • Python LSP with intelligent autocomplete"
echo "  • Fuzzy finder (Telescope) - <leader>ff to search files"
echo "  • File explorer - <leader>e to toggle"
echo "  • AI autocomplete (Codeium) - Ctrl+g to accept suggestions"
echo "  • Git integration"
echo "  • Treesitter syntax highlighting"
echo "  • And much more!"
echo ""
echo "Keybindings:"
echo "  Leader key: <Space>"
echo "  <leader>ff - Find files"
echo "  <leader>fs - Search in files"
echo "  <leader>e  - Toggle file explorer"
echo "  K          - Hover documentation (in code)"
echo "  gd         - Go to definition"
echo "  <leader>ca - Code actions"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"
echo ""
