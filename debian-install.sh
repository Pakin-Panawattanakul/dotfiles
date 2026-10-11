#!/bin/sh

sudo tee /etc/apt/sources.list > /dev/null <<"EOF"
deb http://deb.debian.org/debian/ forky main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ forky main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security forky-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security forky-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian sid main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian sid main contrib non-free non-free-firmware
EOF

sudo tee /etc/apt/preferences.d/forky-sid > /dev/null <<"EOF"
Package: *
Pin: release n=forky
Pin-Priority: 500

Package: *
Pin: release a=unstable
Pin-Priority: 50
EOF

sudo apt update

# -------------------------
# core utils
# -------------------------
sudo apt install \
  build-essential \
  curl \
  git \
  gawk \
  stow \
  zip \
  unzip \
  desktop-base

git config --global user.name "Pakin Panawattanakul"
git config --global user.email p.panawattanakul@gmail.com
git config --global pull.rebase true
git config --global init.defaultBranch main
git config --global submodule.recurse true
git config --global credential.helper store

# network & bluetooth
sudo apt install \
  network-manager \
  network-manager-applet \
  bluez \
  blueman \
 libspa-0.2-bluetooth

# pipewire
sudo apt install \
  pipewire \
  pipewire-pulse \
  wireplumber \
  pavucontrol

# -------------------------
# dwl
# -------------------------
# installing dwl deps
sudo apt install \
	libinput-dev \
	libwayland-dev \
	libwlroots-0.20 libwlroots-0.20-dev \
	libwlroots-0.19 libwlroots-0.19-dev \
	libxkbcommon-dev \
	wayland-protocols \
	pkg-config

#Xwayland deps
sudo apt install \
	libxcb1-dev \
	libxcb-icccm4-dev \
	xwayland

# bar patch
sudo apt install \
	libfcft-dev \
	libdrm-dev

# greeter
sudo apt install greetd
# pam_gnome_keyring lines unlock the login keyring on login (Debian bug #1143492):
# greetd/common-session don't do it themselves, and libpam-gnome-keyring's
# pam-config only ships the password stanza. auth must come after common-auth
# (so pam_unix's token is available), session last (after pam_systemd).
sudo tee /etc/pam.d/greetd > /dev/null <<"EOF"
#%PAM-1.0
@include common-auth
auth     optional pam_gnome_keyring.so
@include common-account
@include common-session
session required pam_env.so readenv=1
session required pam_env.so readenv=1 envfile=/etc/default/locale
session  optional pam_gnome_keyring.so auto_start
EOF

sudo tee /etc/greetd/config.toml > /dev/null <<"EOF"
[terminal]
vt = 7
[default_session]
command = "/usr/sbin/agreety --cmd 'start-dwl'"
user = "_greetd"
EOF

# Waylands utilities
sudo apt install \
  grim \
  slurp \
  xfce-polkit \
  libinput-tools \
  mako-notifier \
  bemenu \
  wl-clipboard \
  wlr-randr \
  wdisplays \
  wl-mirror \
  wev \
  gammastep \
  swayidle \
  swaylock \
  swaybg \
  libnotify-bin \
  nwg-look \
  brightnessctl

# -------------------------
# Terminal
# -------------------------
# terminal utilities
sudo apt install \
	zoxide \
	eza \
  fzf \
  fd-find \
	starship \
	fastfetch \
	bat \
	ncdu \
	ripgrep \
  tree

# neovim 
sudo apt install \
  neovim \
  tree-sitter-cli \
  luarocks \
  npm \
  cargo 

# --- zsh -=--
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# --- tmux ---
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# -------------------------
# Desktop Utilities
# -------------------------
sudo apt install \
  fonts-noto \
  orchis-gtk-theme \
  papirus-icon-theme 

sudo apt install --no-install-recommends \
  thunar \
  thunar-volman \
  thunar-archive-plugin

# other desktops utils
sudo apt install \
	foot \
	firefox \
  thunderbird \
  libreoffice \
  libreoffice-gtk3 \
  solaar \
  qalculate-gtk \
  aria2 \
  gnome-clocks \
  zathura \
  zathura-pdf-poppler \
  mpv \
  imv \
  fuse3 \
  proton-vpn-gtk-app

# flatpak
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install \
  com.bitwarden.desktop \
  dev.vencord.Vesktop \
  com.synology.SynologyDrive \
  com.spotify.Client \
  com.vysp3r.ProtonPlus

# -------------------------
# extrepo policy config
# -------------------------
# Must exist BEFORE any `extrepo enable` below: the shipped default only
# enables "main", and both nvidia-cuda and steam require the non-free policy.
sudo tee /etc/extrepo/config.yaml > /dev/null <<"EOF"
url: https://extrepo-team.pages.debian.net/extrepo-data
dist: debian
version: trixie
# To enable repositories that host software with non-DFSG-free licenses,
# uncomment "contrib" and/or "non-free" in the list below.
enabled_policies:
- main
- contrib
- non-free
EOF

# -------------------------
# Nvidia + Gaming
# -------------------------
if lspci | grep -iE "3d|display|vga" | grep -i nvidia; then
  echo "Nvidia GPU detected
  installing Nvidia propritry driver"

  sudo apt install linux-headers-generic
  sudo apt install extrepo
  sudo extrepo enable nvidia-cuda 
  sudo apt update
  sudo apt install nvidia-open
fi

# steam
if ! dpkg -s steam-launcher >/dev/null 2>&1; then
  sudo dpkg --add-architecture i386
  sudo extrepo enable steam
  sudo apt update
  sudo apt install -y steam-launcher
  # steam-launcher ships its own /etc/apt/sources.list.d/steam-stable.list for
  # this same repo (https, arch=amd64,i386). With the extrepo copy also enabled,
  # apt fails with "Conflicting values set for option Signed-By". Keep the
  # package's own source and disable the extrepo duplicate (reversible via
  # `sudo extrepo enable steam`).
  sudo extrepo disable steam
  sudo apt update
fi

# -------------------------
# udev rules (from modules/udev.nix)
# -------------------------
sudo groupadd -f plugdev
sudo usermod -aG plugdev,dialout "$USER"
sudo tee /etc/udev/rules.d/99-zsa.rules > /dev/null <<'EOF'
KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

# Legacy rules for live training over webusb (Not needed for firmware v21+)
# Rule for all ZSA keyboards
SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
# Rule for the Moonlander
SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
# Rule for the Ergodox EZ
SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
# Rule for the Planck EZ
SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

# Wally Flashing rules for the Ergodox EZ
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

# Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
# Keymapp Flashing rules for the Voyager
SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
EOF

sudo tee /etc/udev/rules.d/99-jtag.rules > /dev/null <<'EOF'
# Digilent JTAG cables 
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="666", GROUP="dialout"
# Xilinx Platform Cable USB II
ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0008", MODE="666", GROUP="dialout"
ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0013", MODE="666", GROUP="dialout"
EOF
