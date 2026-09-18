#!/bin/sh
# Bootstrap the Debian equivalent of this repository's NixOS configuration.
#
# Run from a clone of the repository, as the normal desktop user:
#   ./Scripts/debian-install/install.sh [--laptop|--no-laptop] [--nvidia|--no-nvidia] [--iwd]
#
# This deliberately does not install or enable a display manager.  Install one
# after confirming that `dwl` starts from a TTY; build/dwl/dwl.desktop already
# launches ~/.config/dwl/start-dwl.
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPO_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
STAMP=$(date +%Y%m%d-%H%M%S)
LAPTOP=auto
NVIDIA=auto
USE_IWD=false

usage() {
  printf '%s\n' "Usage: $0 [--laptop|--no-laptop] [--nvidia|--no-nvidia] [--iwd]"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --laptop) LAPTOP=true ;;
    --no-laptop) LAPTOP=false ;;
    --nvidia) NVIDIA=true ;;
    --no-nvidia) NVIDIA=false ;;
    --iwd) USE_IWD=true ;;
    -h|--help) usage; exit 0 ;;
    *) usage; exit 2 ;;
  esac
  shift
done

if [ "$(id -u)" -eq 0 ]; then
  printf '%s\n' 'Run this as the desktop user, not as root.' >&2
  exit 1
fi

if ! command -v apt-get >/dev/null 2>&1; then
  printf '%s\n' 'This installer is intended for Debian or an apt-based derivative.' >&2
  exit 1
fi

sudo -v
sudo apt-get update
sudo env DEBIAN_FRONTEND=noninteractive apt-get -y full-upgrade

package_exists() {
  apt-cache show "$1" >/dev/null 2>&1
}

install_available() {
  packages=''
  for package in "$@"; do
    if package_exists "$package"; then
      packages="$packages $package"
    else
      printf 'Skipping unavailable package: %s\n' "$package" >&2
    fi
  done
  [ -z "$packages" ] || sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y $packages
}

# Validate the compositor toolchain before spending time installing the desktop
# stack.  config.mk deliberately targets wlroots-0.19.
install_available \
  build-essential pkg-config make \
  libwayland-dev wayland-protocols libwlroots-dev libxkbcommon-dev libinput-dev libpixman-1-dev libfcft-dev \
  libxcb1-dev libxcb-icccm4-dev libxcb-ewmh-dev

if ! pkg-config --exists wlroots-0.19; then
  cat >&2 <<'EOF'
The checked-in DWL branch needs wlroots-0.19, but this Debian release does not
provide its pkg-config file.  Do not build DWL against another wlroots version;
use a Debian release with wlroots 0.19 or update the DWL submodule/config.mk first.
EOF
  exit 1
fi

link_path() {
  source_path=$1
  target_path=$2
  if [ -L "$target_path" ] && [ "$(readlink -f "$target_path")" = "$(readlink -f "$source_path")" ]; then
    return
  fi
  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    backup_path="${target_path}.pre-debian-dotfiles-${STAMP}"
    printf 'Backing up %s to %s\n' "$target_path" "$backup_path"
    mv "$target_path" "$backup_path"
  fi
  mkdir -p "$(dirname -- "$target_path")"
  ln -s "$source_path" "$target_path"
}

# Packages that back commands used directly by the dotfiles and DWL session.
install_available \
  ca-certificates curl wget git git-lfs git-credential-libsecret gawk aria2 btop file pciutils \
  network-manager network-manager-gnome ufw bluez \
  pipewire pipewire-pulse wireplumber \
  brightnessctl upower udisks2 fwupd \
  foot wl-clipboard xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk xwayland \
  zsh stow starship zoxide eza bat fd-find ncdu fzf ripgrep tmux pipx npm tldr \
  flatpak zip unzip 7zip tree-sitter-cli \
  gammastep slurp grim zathura zathura-pdf-poppler fastfetch tree lazygit luarocks \
  mpv qalc imv yazi wbg waylock swayidle bemenu wmenu wlr-randr wdisplays wl-mirror \
  mako-notifier libnotify-bin solaar seahorse firefox-esr geary libreoffice \
  neovim nodejs rustc cargo gcc gdb python3 gnumake \
  ffmpeg deno yt-dlp spotdl ncspot

# config/.zshrc intentionally uses Oh My Zsh only outside NixOS.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi
ZSH_CUSTOM_DIR="$HOME/.oh-my-zsh/custom"
if [ ! -d "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"
fi

# config/ and files/ are Stow packages: their contents map directly into $HOME.
# Do not use `stow .`, which would instead create ~/config and ~/files.
mkdir -p "$HOME/.local/bin" "$HOME/.local/share/fonts" "$HOME/.local/share/icons" "$HOME/.themes"
stow --dir "$REPO_DIR" --target "$HOME" --restow config files
for name in wmenu-drun wmenu-powermenu; do
  link_path "$REPO_DIR/submodules/wmenu-scripts/$name" "$HOME/.local/bin/$name"
done
xdg-user-dirs-update

# Build the locally pinned compositor and bar with the same headers NixOS used.
git -C "$REPO_DIR" submodule update --init --recursive
install -m 0644 "$REPO_DIR/config/.config/dwl/config.h" "$REPO_DIR/build/dwl/config.h"
install -m 0644 "$REPO_DIR/config/.config/dwl/blocks.h" "$REPO_DIR/build/someblocks/blocks.h"
make -C "$REPO_DIR/build/dwl" clean
make -C "$REPO_DIR/build/dwl"
sudo make -C "$REPO_DIR/build/dwl" install
make -C "$REPO_DIR/build/someblocks" clean
make -C "$REPO_DIR/build/someblocks"
sudo make -C "$REPO_DIR/build/someblocks" install

# Keep the non-Nix git identity and avoid the old plaintext credential helper.
git config --global user.name 'Pakin Panawattanakul'
git config --global user.email 'p.panawattanakul@gmail.com'
git config --global pull.rebase true
git config --global init.defaultBranch main
git config --global submodule.recurse true
if command -v git-credential-libsecret >/dev/null 2>&1; then
  git config --global credential.helper libsecret
fi

# The canonical copy is also used by the NixOS udev module.
sudo groupadd -f plugdev
sudo usermod -aG plugdev "$USER"
sudo install -Dm0644 "$REPO_DIR/files/Templates/50-zsa.rules" /etc/udev/rules.d/50-zsa.rules
sudo udevadm control --reload-rules

if [ "$LAPTOP" = auto ]; then
  if ls /sys/class/power_supply/BAT* >/dev/null 2>&1; then LAPTOP=true; else LAPTOP=false; fi
fi
if [ "$LAPTOP" = true ]; then
  install_available tlp powertop
  sudo install -d /etc/tlp.d
  sudo tee /etc/tlp.d/90-pakin.conf >/dev/null <<'EOF'
CPU_SCALING_GOVERNOR_ON_AC=performance
CPU_SCALING_GOVERNOR_ON_BAT=powersave
CPU_ENERGY_PERF_POLICY_ON_AC=performance
CPU_ENERGY_PERF_POLICY_ON_BAT=power
CPU_MIN_PERF_ON_AC=0
CPU_MAX_PERF_ON_AC=100
CPU_MIN_PERF_ON_BAT=0
CPU_MAX_PERF_ON_BAT=50
EOF
  sudo systemctl enable --now tlp.service 2>/dev/null || true
fi

if [ "$USE_IWD" = true ]; then
  install_available iwd
  sudo install -d /etc/NetworkManager/conf.d
  sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null <<'EOF'
[device]
wifi.backend=iwd
EOF
  sudo systemctl enable --now iwd.service
  sudo systemctl restart NetworkManager.service
fi

if [ "$NVIDIA" = auto ]; then
  if lspci -nn | grep -qi 'NVIDIA'; then NVIDIA=true; else NVIDIA=false; fi
fi
if [ "$NVIDIA" = true ]; then
  sudo dpkg --add-architecture i386
  sudo apt-get update
  install_available nvidia-driver nvidia-driver-libs:i386 gamemode steam-installer
fi

# Local theme/font archives are optional conveniences; NixOS previously supplied
# their equivalents from packages.
[ ! -f "$SCRIPT_DIR/Orchis.tar.xz" ] || tar -xf "$SCRIPT_DIR/Orchis.tar.xz" -C "$HOME/.themes"
[ ! -f "$SCRIPT_DIR/papirus-icon-theme-20250501.tar.gz" ] || tar -xf "$SCRIPT_DIR/papirus-icon-theme-20250501.tar.gz" -C "$HOME/.local/share/icons"
[ ! -f "$SCRIPT_DIR/JetBrainsMono.zip" ] || unzip -q -o "$SCRIPT_DIR/JetBrainsMono.zip" -d "$HOME/.local/share/fonts"

printf '%s\n' '' 'Debian bootstrap complete.' \
  'Log out/in once so new group membership takes effect.' \
  'Test `dwl` from a TTY before choosing and enabling a display manager.' \
  'Run Scripts/debian-install/flatpak-install.sh as your normal user for Flatpaks.'
