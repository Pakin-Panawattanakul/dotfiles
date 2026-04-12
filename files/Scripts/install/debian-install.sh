#!/bin/sh
# assume that git is already installed to clone this scripts

# step before runnning this scripts
# 1. edit /etc/apt/sources.list : stable -> testing, + sid
# 2. edit /etc/apt/preferences.d/99repository-pin
## /etc/apt/preferences.d/99repositry-pin
## Package: * 
## Pin: release a=testing
## Pin-Priority: 500
## 
## Package: *
## Pin: release a=unstable
## Pin-Priority:50
# 3. set no install recommends as default
## /etc/apt/apt.conf.d/99norecommends
# APT::Install-Recommends "0";
# APT::Install-Suggests "0";

set -e
install_dir="$HOME/Scripts/install"
# Function to check if a command fails
check_exit() {
  if [ $? -ne 0 ]; then
    echo "Error: $1 failed. Exiting script."
    exit 1
  fi
}


# Install nala for better history
sudo apt update && sudo apt install -y nala

# Create necessary directories
sudo nala install -y xdg-user-dirs
xdg-user-dirs-update
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/fonts"
mkdir -p "$HOME/.icons"
mkdir -p "$HOME/.themes"
check_exit "Creating directories"

# Install git
sudo nala install -y git git-lfs lazygit 

cd "$HOME/dotfiles"
git submodule update --init --recursive
cd "$HOME/dotfiles/assets/"
git lfs pull
cd "$HOME"

# Git config
git config --global user.name 'Pakin-Panawattanakul'
git config --global user.email pakin.pan@proton.me
git config --global credential.helper store
check_exit "Git configuration"

sleep 1

# System essesnital
sudo nala install -y build-essential man-db curl gawk eject file

# Dev
sudo nala install -y neovim tree-sitter-cli npm python3-pip cargo rustc luarocks

# Network 
sudo nala install -y ufw iwd
cargo install impala

# Sound
sudo nala install -y pipewire pipewire-pulse wireplumber
# dependecies for wiremix
sudo nala install -y libpipewire-0.3-dev pkg-config clang 
cargo install wiremix

# bluetooth
sudo nala install -y bluez bluez-tools bluetui libspa-0.2-bluetooth
# dependecies for bluetui
sudo nala install -y libdbus-1-dev
cargo install bluetui

# power
sudo nala install -y powertop tlp upower

# internet 
sudo nala install -y firefox qutebrowser

# Terminal
sudo nala install -y foot foot-terminfo foot-themes zsh bat eza zoxide starship fzf ripgrep ncdu fd-find tmux tree stow tldr-py

# dwl
sudo nala install -y libinput-dev wayland-protocols libwlroots-0.19 libwlroots-0.19-dev \
  libxkbcommon-dev pkg-config \
  xdg-desktop-portal xdg-desktop-portal-wlr \
  polkitd pkexec xfce-polkit xwayland

# TODO: add build scripts

# desktop tools
sudo nala install -y slurp grim nwglook gammastep swaybg swaylock waybar wdisplays wlr-randr wl-mirror wl-present \
  brightnessctl libnotify-bin mako-notifier wl-clipboard wmenu imv zathura zathura-pdf-poppler 

# System utils
sudo nala install -y btop unzip zip 7zip aria2 timeshift

# flatpak
sudo nala install -y flatpak p11-kit xdg-desktop-portal-gtk
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Music
sudo nala install -y mpv mpc cava
cargo install rmpc --locked

# fonts & office
sudo nala install -y fonts-liberation fonts-noto ttf-mscorefonts-installer
sudo nala install -y libreoffice

# Install kernel headers and NVIDIA drivers
sudo nala install linux-headers-generic extrepo
sudo extrepo enable nvidia-cuda
sudo nala update && sudo nala upgrade
sudo nala install nvidia-open
check_exit "Installing kernel headers and NVIDIA drivers"


# Backup existing configs
if [ -e "$HOME/.bashrc" ]; then
 mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi
if [ -e "$HOME/.zshrc" ]; then
 mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi
if [ -e "$HOME/.zshenv" ]; then
 mv "$HOME/.zshenv" "$HOME/.zshenv.bak"
fi
if [ -e "$HOME/.profile" ]; then
 mv "$HOME/.profile" "$HOME/.profile.bak"
fi
check_exit "Backing up existing configs"

# Install oh-my-zsh 
if [ ! -d "$HOME/.oh-my-zsh"  ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  check_exit "Installing oh-my-zsh"
  # Clone zsh plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  check_exit "Cloning zsh plugins"
fi

# Install kernel headers and NVIDIA drivers
sudo nala install linux-headers-generic extrepo
sudo extrepo enable nvidia-cuda
sudo nala update && sudo nala upgrade
sudo nala install nvidia-open
check_exit "Installing kernel headers and NVIDIA drivers"

# ZSA keymapp dependency & proton pass
sudo nala install libwebkit2gtk-4.1-0 libgtk-3-0 libusb-1.0-0 dos2unix
sudo cp "$install_dir/50-zsa.rules" "/etc/udev/rules.d/50-zsa.rules"
sudo groupadd plugdev
sudo usermod -aG plugdev $USER
check_exit "Installing keymap dependency and proton pass"

echo "Finished initial Debian setup
1. edit /etc/fstab
2. Restart
3. Install flathub packages
4. Set themes with nwg-look
