#!/bin/sh
# assume that git is already installed

install_dir="$HOME/Scripts/debian-install"
# Function to check if a command fails
check_exit() {
  if [ $? -ne 0 ]; then
    echo "Error: $1 failed. Exiting script."
    exit 1
  fi
}

# Update system
sudo apt update && sudo apt upgrade
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
  build-essential man-db brightnessctl curl wget gawk aria2  btop \
  efibootmgr timeshift \
  sway swaybg sway-notification-center swayidle swaylock imv \
  i3status autotiling foot foot-themes foot-terminfo wmenu wl-clipboard \
  xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-wlr xwayland \
  nwg-look nwg-displays wev wlr-randr wl-mirror \
  fonts-noto fonts-noto-cjk ttf-mscorefonts-installer \
  zsh stow starship zoxide eza bat fd-find ncdu du-dust fzf ripgrep tmux pipx npm \
  flatpak zip unzip 7zip tree-sitter-cli \
  gammastep zoxide slurp grim zathura zathura-pdf-poppler \
  fastfetch tree lazygit luarocks git-lfs \
  greetd tuigreet steam-devices 
check_exit "Installing packages"

xdg-user-dirs-update

# Create necessary directories
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/.local/share/fonts"
mkdir -p "$HOME/.themes"
check_exit "Creating directories"

# Install tldr
pipx install tldr
check_exit "Installing tldr"

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
  rm "$HOME/.zshrc"
  check_exit "Cloning zsh plugins"
fi


# Set up dotfiles
cd "$HOME/dotfiles" && stow .
cd "$HOME"
sudo ln -sf ~/.local/bin/sway /usr/local/bin/sway
check_exit "Stowing dotfiles"

# Install kernel headers and NVIDIA drivers
sudo nala install linux-headers-generic extrepo
sudo extrepo enable nvidia-cuda
sudo nala update && sudo nala upgrade
sudo nala install nvidia-open
check_exit "Installing kernel headers and NVIDIA drivers"

# build neovim from source
if [ ! $(which nvim) ]; then
cd "$HOME"
sudo nala install ninja-build gettext cmake curl build-essential git
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux-x86_64.deb
cd "$HOME"
check_exit "Buliding neovim"
fi

# Install yazi
if [ ! $(which yazi) ]; then
cd "$HOME"
  sudo nala install jq ffmpeg resvg imagemagick fd-find ripgrep
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  . "$HOME/.cargo/env"
  rustup update
  git clone https://github.com/sxyazi/yazi.git
  cd yazi
  cargo build --release --locked
  mv target/release/yazi target/release/ya "$HOME/.local/bin/"
  cd $HOME && rm -rf yazi
fi
check_exit "Installing yazi"

# ZSA keymapp dependency & proton pass
cd "$HOME/dotfiles" && git lfs pull
cd "$HOME"
sudo nala install libwebkit2gtk-4.1-0 libgtk-3-0 libusb-1.0-0 dos2unix
sudo nala install "$install_dir/ProtonPass.deb"
sudo cp "$install_dir/50-zsa.rules" "/etc/udev/rules.d/50-zsa.rules"
sudo groupadd plugdev
sudo usermod -aG plugdev $USER
check_exit "Installing keymap dependency and proton pass"

# unzip fonts, icons, theme
tar -xGf "$install_dir/Orchis.tar.xz" --directory "$HOME/.themes"
tar -xGf "$install_dir/papirus-icon-theme-20250501.tar.gz" --directory "$HOME/.local/share/icons"
unzip "$install_dir/JetBrainsMono.zip" -d "$HOME/.local/share/fonts"
check_exit "Unzip fonts themes and icons"

# Add flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
check_exit "Adding flathub repository"

echo "Finished initial Debian setup
1. edit /etc/fstab
2. Restart
3. Install flathub packages
4. Set themes
5. Vivado"
