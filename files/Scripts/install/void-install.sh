#!/bin/sh
# void linux install scripts with dwl
install_dir="$(pwd)"

# Git config
git config --global user.email "pakin.pan@proton.me" 
git config --global user.name "Pakin Panawattanakul"
git config --global pull.rebase true
git config --global init.defaultBranch main

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/.local/share/fonts"
mkdir -p "$HOME/.local/share/themes"

# enable void repo
sudo xbps-install -y void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
sudo xbps-install -Syu

# essential
sudo xbps-install -y intel-ucode base-devel dbus elogind polkit man-db
sudo rm /var/service/wpa_supplicant
sudo ln -s /etc/sv/dbus  /etc/sv/polkitd /var/service
# /etc/sv/elogind not enable this and enable greetd and tuigreet at the end

# log
sudo xbps-install -y socklog-void
sudo ln -s /etc/sv/socklog-unix /etc/sv/nanoklogd /var/service

sudo xbps-install -y xdg-user-dirs
xdg-user-dirs-update

# network
sudo xbps-install -y iwd impala ufw
sudo ufw enable
sudo ln -s /etc/sv/ufw /var/service

# bluetooth
sudo xbps-install -y bluez bluetui
sudo ln -s /etc/sv/bluetoothd /var/service  

# sound
sudo xbps-install -y pipewire wireplumber wiremix libspa-bluetooth
: "${XDG_CONFIG_HOME:=${HOME}/.config}"
mkdir -p "${XDG_CONFIG_HOME}/pipewire/pipewire.conf.d"
ln -s /usr/share/examples/wireplumber/10-wireplumber.conf "${XDG_CONFIG_HOME}/pipewire/pipewire.conf.d/"
ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf "${XDG_CONFIG_HOME}/pipewire/pipewire.conf.d/"

# rtkit
sudo xbps-install -y rtkit
sudo ln -s /etc/sv/rtkit /var/service

# ntp
sudo xbps-install -y openntpd
sudo ln -s /etc/sv/openntpd /var/service

# power
sudo xbps-install -y tlp upower brightnessctl
sudo tlp start
sudo ln -s /etc/sv/tlp /var/service

# dwl dependecies
sudo xbps-install -y libinput libinput-devel wayland wayland-devel wlroots0.19 wlroots0.19-devel libxkbcommon libxkbcommon-devel wayland-protocols pkg-config xorg-server-xwayland
# someblock
sudo xbps-install -y cairo-devel  pango-devel meson ninja

# desktop portal
sudo xbps-install -y xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk

# wayland stuff 
sudo xbps-install -y wl-clipboard grim slurp wbg waylock wlr-randr wdisplays wl-mirror wev 

# desktop utils
sudo xbps-install -y wmenu libnotify mako imv zathura zathura-pdf-mupdf aria2

# themes and fonts
sudo xbps-install -y papirus-icon-theme noto-fonts-ttf nerd-fonts-ttf nwg-look qt6-wayland

# terminal
sudo xbps-install -y foot foot-terminfo bat zsh eza zoxide starship \
  fzf fd ncdu ripgrep tree fastfetch

# dev 
sudo xbps-install -y rust cargo python3-pip gdb git git-lfs lazygit

# neovim
sudo xbps-install -y neovim tree-sitter tree-sitter-devel nodejs luarocks

# utils / software
sudo xbps-install -y curl wget btop stow jq glxinfo tldr qmk thunderbird libreoffice libreoffice-i18n-th

# Media 
sudo xbps-install -y qutebrowser mpd mpc rmpc cava mpv yt-dlp

# flatpak
sudo xbps-install -y flatpak
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user --assumeyes dev.vencord.Vesktop  me.proton.Pass  com.spotify.Client io.gitlab.librewolf-community  net.davidotek.pupgui2
flatpak override --user --filesystem="$HOME/.themes"
flatpak override --user --env=GTK_THEME=Orchis-Dark

# balatro mod mamager
curl -sL https://raw.githubusercontent.com/skyline69/balatro-mod-manager/main/scripts/linux-install.sh | bash -s -- --clone

# game 
sudo xbps-install -y steam libdrm-32bit libgcc-32bit libstdc++-32bit gamemode

#https://bugraeren.com/blog/vivado_on_void_linux/
# --- vivado ---
# this should be already installed : make unzip zip gcc git libfdisk
sudo xbps-install -y graphviz 
# all ncurses compat libs
# this should be already installed : ncurses ncurses-libs ncurses-base
sudo xbps-install -y ncurses-libtinfo-libs \
   ncurses-libs-32bit ncurses-libtinfo-libs-32bit ncurses-term
sudo xbps-install -y xorg-server-xvfb xvfb-run # xvfb
sudo xbps-install -y nss libnss-cache # libnss3
sudo xbps-install -y  alsa-lib-32bit # asound2 # alsa-lib : should be already installed 
sudo xbps-install -y libXScrnSaver libXScrnSaver-32bit # libxss
sudo xbps-install -y gtk+3 gtk+3-32bit # gtk3
sudo cp /lib/libtinfo.so.6 /lib/libtinfo.so.5
sudo cp /lib/libncurses.so.6 /lib/libncurses.so.5

# ZSA keymapp dependency & proton pass
sudo cp "$install_dir/50-zsa.rules" "/etc/udev/rules.d/50-zsa.rules"
sudo groupadd plugdev
sudo usermod -aG plugdev $USER

# nvidia
choice=""
while [ "$choice" != "y" ] && [ "$choice" != "n" ]; do
    printf "Installing nvidia gpu driver?"
    read -r choice
done

install_nvidia(){
  sudo xbps-install mesa-dri nvidia  nvidia-libs-32bit
  sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT/c\GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 nvidia_drm.modeset=1 nvidia_drm.fbdev=1"' /etc/default/grub
}
if [ $choice = 'y' ]; then
  install_nvidia
fi

# Install oh-my-zsh 
if [ ! -d "$HOME/.oh-my-zsh"  ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  check_exit "Installing oh-my-zsh"
  # Clone zsh plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# set gpu ENV variables on for separate machine on .gpu
touch "$HOME/.gpu"

sudo xbps-install greetd tuigreet
sudo ln -s /etc/sv/greetd /var/service
