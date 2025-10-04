#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting eehcx dotfiles installation...${NC}"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Backup existing configs
backup_config() {
    if [ -d "$1" ] || [ -f "$1" ]; then
        echo -e "${YELLOW}Backing up $1 to $1.backup${NC}"
        cp -r "$1" "$1.backup" 2>/dev/null
    fi
}

# Install packages based on package manager
if command_exists pacman; then
    echo -e "${GREEN}Detected Arch Linux. Installing packages...${NC}"
    sudo pacman -S --needed \
        hyprland \
        foot \
        waybar \
        wofi \
        grim \
        slurp \
        gvim \
        nemo \
        hyprpaper \
        playerctl \
        brightnessctl \
        wireplumber \
        pipewire \
        ratbagd

elif command_exists apt; then
    echo -e "${GREEN}Detected Debian/Ubuntu. Installing packages...${NC}"
    sudo apt update
    sudo apt install -y \
        foot \
        waybar \
        wofi \
        grim \
        slurp \
        vim-gtk3 \
        nemo \
        playerctl \
        brightnessctl \
        wireplumber \
        pipewire

    echo -e "${YELLOW}Note: Hyprland may need to be installed manually on Debian/Ubuntu${NC}"
fi

# Create config directories
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/wofi
mkdir -p ~/.vim/plugged

# Backup existing configs
backup_config ~/.config/hypr
backup_config ~/.config/waybar
backup_config ~/.config/wofi
backup_config ~/.vimrc

# Install Vim plugins
echo -e "${GREEN}Installing Vim plugins...${NC}"
if command_exists vim; then
    vim +PlugInstall +qall
elif command_exists nvim; then
    nvim +PlugInstall +qall
fi

# Copy dotfiles
echo -e "${GREEN}Copying configuration files...${NC}"

# Hyprland configs
cp hyprland.conf ~/.config/hypr/
cp hyprpaper.conf ~/.config/hypr/

# Waybar config
cp style.css ~/.config/waybar/  # Assuming this is waybar style

# Wofi config
cp wofi-style.css ~/.config/wofi/style.css  # Rename if needed

# Vim config
cp vim-config.vim ~/.vimrc  # Rename your vim config file

# Make scripts executable
chmod +x scripts/* 2>/dev/null || true

# Set up optional dependencies
echo -e "${YELLOW}Optional dependencies you might want:${NC}"
echo "- warp-cli: For VPN (already in your autostart)"
echo "- emote: For emoji picker (Super + .)"
echo "- ratbagd: For mouse configuration"
echo "- nm-applet: Network manager (commented in your config)"

# Enable services
if command_exists systemctl; then
    echo -e "${GREEN}Enabling services...${NC}"
    systemctl --user enable wireplumber 2>/dev/null || true
    sudo systemctl enable ratbagd 2>/dev/null || true
fi

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}Please check the following:${NC}"
echo "1. Update wallpaper path in ~/.config/hypr/hyprpaper.conf"
echo "2. Review mouse configuration in hyprland.conf"
echo "3. Restart Hyprland (Super + M) to apply changes"
echo "4. Install missing fonts if any UI elements look broken"

# Check for common issues
if ! command_exists foot; then
    echo -e "${RED}Warning: foot terminal not found. Update terminal in hyprland.conf${NC}"
fi

if ! command_exists wofi; then
    echo -e "${RED}Warning: wofi not found. Update menu in hyprland.conf${NC}"
fi