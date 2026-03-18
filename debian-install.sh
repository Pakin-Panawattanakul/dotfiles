#!/bin/sh
# assume that git is already install

echo "Set up git"
git config --global user.name 'Pakin-Panawattanakul'
git config --global user.email pakin.pan@proton.me
git config --global credential.helper store

sudo apt update && sudo apt full-upgrade
sudo apt install nala

sleep 1

echo "Install Packages"
sudo nala install git network-manager nm-connection-editor ufw \
  sway swaybg sway-notification-center swayidle swaylock i3status autotiling foot foot-themes wmenu wl-clipboard \
  xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-wlr xwayland nwg-look nwg-displays wev wlr-randr wl-mirror \
  nala install zsh stow starship eza bat fd-find du-dust fzf ripgrep tmux pipx rustc cargo npm man-db  

sleep 1
sudo nala install firefox qutebrowser flatpak zip unzip 7zip neovim tree-sitter-cli curl wget aria2 gawk \
  pipewire pipewire-pulse wireplumber gammastep upower zoxide slurp grim

xdg-user-dirs-update

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"

pipx install tldr

echo "Install ZSH"
# Install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Downloads JetBrains Mono Nerd Fonts
echo "Install Fonts"
mkdir -p "$HOME/.fonts"
aria2c --out "$HOME/Downloads/JetBrainsMono.zip" https://release-assets.githubusercontent.com/github-production-release-asset/27574418/618d36f5-7bcc-4e03-a153-30d18952aa14\?sp\=r\&sv\=2018-11-09\&sr\=b\&spr\=https\&se\=2026-03-18T18%3A31%3A30Z\&rscd\=attachment%3B+filename%3DJetBrainsMono.zip\&rsct\=application%2Foctet-stream\&skoid\=96c2d410-5711-43a1-aedd-ab1947aa7ab0\&sktid\=398a6654-997b-47e9-b12b-9515b896b4de\&skt\=2026-03-18T17%3A30%3A39Z\&ske\=2026-03-18T18%3A31%3A30Z\&sks\=b\&skv\=2018-11-09\&sig\=G
unzip "$HOME/Downloads/JetBrainsMono.zip" -d "$HOME/.fonts/"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Clone dotfiles"
git clone https://github.com/Pakin-Panawattanakul/dotfiles.git
cd dotfiles && stow .
cd "$HOME"

echo "Install nvidia driver"
sudo nala install linux-headers-generic && sudo nala install nvidia-open-kernel-dkms nvidia-driver
