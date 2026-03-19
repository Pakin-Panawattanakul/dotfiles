#!/bin/sh
# assume that git is already install

sudo apt update && sudo apt full-upgrade
sudo apt install nala

git config --global user.name 'Pakin-Panawattanakul'
git config --global user.email pakin.pan@proton.me
git config --global credential.helper store

sleep 1

sudo nala install git network-manager nm-connection-editor ufw \
  sway swaybg sway-notification-center swayidle swaylock i3status autotiling foot foot-themes wmenu wl-clipboard \
  xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-wlr xwayland nwg-look nwg-displays wev wlr-randr wl-mirror
  
sudo nala install  zsh stow starship zoxide eza bat fd-find ncdu fzf ripgrep tmux pipx rustc cargo npm man-db btop \
  efibootmgr timeshift tlp powertop upower \
  bluez bluez-utils

sleep 1
sudo nala install firefox qutebrowser flatpak zip unzip 7zip neovim tree-sitter-cli curl wget aria2 gawk \
  pipewire pipewire-pulse wireplumber \
  gammastep zoxide slurp grim

xdg-user-dirs-update

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"

pipx install tldr

mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
mv "$HOME/.oh-my-zsh" "$HOME/.oh-my-zsh.bak"

# Install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
sleep 1
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
rm "$HOME/.zshrc"

# Downloads JetBrains Mono Nerd Fonts
mkdir -p "$HOME/.fonts"
cd "$HOME"
aria2c --out "Downloads/" https://release-assets.githubusercontent.com/github-production-release-asset/27574418/618d36f5-7bcc-4e03-a153-30d18952aa14\?sp\=r\&sv\=2018-11-09\&sr\=b\&spr\=https\&se\=2026-03-18T18%3A31%3A30Z\&rscd\=attachment%3B+filename%3DJetBrainsMono.zip\&rsct\=application%2Foctet-stream\&skoid\=96c2d410-5711-43a1-aedd-ab1947aa7ab0\&sktid\=398a6654-997b-47e9-b12b-9515b896b4de\&skt\=2026-03-18T17%3A30%3A39Z\&ske\=2026-03-18T18%3A31%3A30Z\&sks\=b\&skv\=2018-11-09\&sig\=G
unzip "$HOME/Downloads/JetBrainsMono.zip" -d "$HOME/.fonts/"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#git clone https://github.com/Pakin-Panawattanakul/dotfiles.git
cd dotfiles && stow .
cd "$HOME"

sudo nala install linux-headers-generic && sudo nala install nvidia-kernel-dkms nvidia-driver
