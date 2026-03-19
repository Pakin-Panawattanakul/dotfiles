#!/bin/sh
# assume that git is already installed

# Function to check if a command fails
check_exit() {
  if [ $? -ne 0 ]; then
    echo "Error: $1 failed. Exiting script."
    exit 1
  fi
}

# Update system
sudo apt update && sudo apt full-upgrade
check_exit "System update and upgrade"

# Install nala
sudo apt install nala
check_exit "Installing nala"

# Git config
git config --global user.name 'Pakin-Panawattanakul'
git config --global user.email pakin.pan@proton.me
git config --global credential.helper store
check_exit "Git configuration"

sleep 1

# Install packages
# System
sudo nala install git network-manager nm-connection-editor ufw bluez \
  tlp powertop upower \
  pipewire pipewire-pulse wireplumber \
  build-essetial man-db brightnessctl curl wget gawk aria2  btop \
  efibootmgr timeshift
check_exit "Installing system packages"

# sway
sudo nala install sway swaybg sway-notification-center swayidle swaylock \
  i3status autotiling foot foot-themes foot-terminfo wmenu wl-clipboard \
  xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-wlr xwayland \
  nwg-look nwg-displays wev wlr-randr wl-mirror \
  fonts-noto fonts-noto-cjk ttf-ms-fonts
check_exit "Installing sway packagages"

# Install more tools
sudo nala install zsh stow starship zoxide eza bat fd-find ncdu fzf ripgrep tmux pipx rustc cargo npm \
  firefox qutebrowser flatpak zip unzip 7zip neovim tree-sitter-cli \
  gammastep zoxide slurp grim imv zathura \
  fastfetch tree lazygit rocks git-lfs
check_exit "Installing additional tools"

xdg-user-dirs-update

# Create necessary directories
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"
check_exit "Creating directories"

# Install tldr
pipx install tldr
check_exit "Installing tldr"

# Backup existing configs
mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
mv "$HOME/.oh-my-zsh" "$HOME/.oh-my-zsh.bak"
check_exit "Backing up existing configs"

# Install zsh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
check_exit "Installing oh-my-zsh"

# Clone zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
check_exit "Cloning zsh plugins"

rm "$HOME/.zshrc"
check_exit "Removing old zshrc"

# Download and install JetBrains Mono Nerd Fonts
mkdir -p "$HOME/.fonts"
cd "$HOME"
aria2c --out "Downloads/" https://release-assets.githubusercontent.com/github-production-release-asset/27574418/618d36f5-7bcc-4e03-a153-30d18952aa14?sp=r&sv=2018-11-09&sr=b&spr=https&se=2026-03-18T18%3A31%3A30Z&rscd=attachment%3B+filename%3DJetBrainsMono.zip&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2026-03-18T17%3A30%3A39Z&ske=2026-03-18T18%3A31%3A30Z&sks=b&skv=2018-11-09&sig=G
unzip "$HOME/Downloads/JetBrainsMono.zip" -d "$HOME/.fonts/"
check_exit "Downloading and installing JetBrainsMono fonts"

# Add flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
check_exit "Adding flathub repository"

# Uncomment to clone your dotfiles repo
# git clone https://github.com/Pakin-Panawattanakul/dotfiles.git
# check_exit "Cloning dotfiles repo"

# Set up dotfiles
cd dotfiles && stow .
cd "$HOME"
check_exit "Stowing dotfiles"

# Install kernel headers and NVIDIA drivers
sudo nala install linux-headers-generic && sudo nala install nvidia-kernel-dkms nvidia-driver
check_exit "Installing kernel headers and NVIDIA drivers"
