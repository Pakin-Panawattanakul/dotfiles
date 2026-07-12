#!/bin/sh
# void linux install scripts
ask_install() {
    choice=""
    while [ "$choice" != "y" ] && [ "$choice" != "n" ]; do
        printf "Install %s? [y/n] " "$1"
        read -r choice
    done
    [ "$choice" = "y" ]
}
install_dir="$(pwd)"

# Git config
git config --global user.email "p.panawattanakul@gmail.com" 
git config --global user.name "Pakin Panawattanakul"
git config --global pull.rebase true
git config --global init.defaultBranch main
git config --global submodule.recurse true

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/.local/share/fonts"
mkdir -p "$HOME/.local/share/themes"

# enable void repo
sudo xbps-install -y void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree xtools-minimal
sudo xbps-install -Syu

# essential
sudo xbps-install -y intel-ucode base-devel dbus elogind polkit man-db
sudo ln -sf /etc/sv/dbus  /etc/sv/polkitd /var/service

# log
sudo xbps-install -y socklog-void
sudo ln -sf /etc/sv/socklog-unix /etc/sv/nanoklogd /var/service

sudo xbps-install -y xdg-user-dirs xdg-utils
xdg-user-dirs-update
rmdir "$HOME/Publics"
rmdir "$HOME/Videos"

# network
sudo xbps-install -y NetworkManager ufw
sudo xbps-install -y nmap netcat tcpdump
wireless_setup(){
  sudo xbps-install -y iwd impala
  sudo ln -sf /etc/sv/iwd /var/service
  echo "[General]
  EnableNetworkConfiguration=false
  UseDefaultInterface=true" | sudo tee /etc/iwd/main.conf
  sudo mkdir -p /etc/NetworkManager/conf.d
  echo "[device]
wifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf
  sudo ln -sf /etc/sv/iwd /var/service
}
sudo rm -f /var/service/wpa_supplicant
sudo rm -f /var/service/dhcpcd
ask_install "wireless setup" && wireless_setup
sudo ln -sf /etc/sv/NetworkManager/ /var/service
sudo ln -sf /etc/sv/ufw /var/service
sudo ufw enable

# bluetooth
sudo xbps-install -y bluez bluetui
sudo ln -sf /etc/sv/bluetoothd /var/service  

# sound
sudo xbps-install -y pipewire wireplumber wiremix libspa-bluetooth
: "${XDG_CONFIG_HOME:=${HOME}/.config}"
mkdir -p "${XDG_CONFIG_HOME}/pipewire/pipewire.conf.d"
ln -sf /usr/share/examples/wireplumber/10-wireplumber.conf "${XDG_CONFIG_HOME}/pipewire/pipewire.conf.d/"
ln -sf /usr/share/examples/pipewire/20-pipewire-pulse.conf "${XDG_CONFIG_HOME}/pipewire/pipewire.conf.d/"

# rtkit
sudo xbps-install -y rtkit
sudo ln -sf /etc/sv/rtkit /var/service

# ntp
sudo xbps-install -y openntpd
sudo ln -sf /etc/sv/openntpd /var/service

# power
sudo xbps-install -y tlp upower brightnessctl
sudo ln -sf /etc/sv/tlp /var/service
sudo tlp start

# desktop portal
sudo xbps-install -y xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk

# setup runit user service 
sudo mkdir -p /etc/sv/runsvdir-pakin
sudo tee /etc/sv/runsvdir-pakin/run << 'EOF'
#!/bin/sh
export USER="pakin"
export HOME="/home/pakin"
export XDG_RUNTIME_DIR="/run/user/$(id -u $USER)"
groups="$(id -Gn "$USER" | tr ' ' ':')"
svdir="$HOME/.runit/service"
exec chpst -u "$USER:$groups" runsvdir "$svdir"
EOF
sudo chmod +x /etc/sv/runsvdir-pakin/run
sudo ln -sf /etc/sv/runsvdir-pakin /var/service

#******************** dwl ********************
sudo xbps-install -y libinput libinput-devel wayland wayland-devel wlroots0.19  wlroots0.19-devel libxkbcommon libxkbcommon-devel \
  wayland-protocols pkg-config
sudo xbps-install -y libxcb libxcb-devel xorg-server-xwayland
# somebar
sudo xbps-install -y rofi waylock wbg mako
# bar patches
sudo xbps-install -y tllist fcft fcft-devel pixman

# wayland stuff 
sudo xbps-install -y wl-clipboard grim slurp wlr-randr wdisplays wl-mirror wev gammastep

# desktop utils
sudo xbps-install -y libnotify imv aria2 qalculate-gtk

# thunar
sudo xbps-install -y Thunar thunar-archive-plugin thunar-volman tumbler xarchiver

# yazi & dependency
sudo xbps-install -y yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg ImageMagick wl-clipboard

# themes and fonts
sudo xbps-install -y papirus-icon-theme noto-fonts-ttf noto-fonts-emoji nerd-fonts-ttf nwg-look qt6-wayland qt6ct

# terminal
sudo xbps-install -y foot foot-terminfo bat zsh eza zoxide starship \
  fzf fd ncdu ripgrep tree fastfetch

# dev 
sudo xbps-install -y rust cargo python3-pip gdb git git-lfs lazygit

# neovim
sudo xbps-install -y neovim tree-sitter tree-sitter-cli nodejs luarocks xxd

# utils / software
sudo xbps-install -y topgrade curl wget btop stow jq glxinfo tldr qmk thunderbird libreoffice libreoffice-i18n-th void-docs-browse Solaar

# Media 
sudo xbps-install -y  firefox mpd mpc rmpc cava mpv yt-dlp udiskie zathura zathura-pdf-mupdf

# flatpak
sudo xbps-install -y flatpak
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user --assumeyes dev.vencord.Vesktop com.spotify.Client com.bitwarden.desktop
flatpak override --user --filesystem="$HOME/.themes"
flatpak override --user --env=GTK_THEME=Orchis-Dark

# game
sudo xbps-install -y steam libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit libva-32bit gamemode gamescope
sudo sed -i "/#@student        hard    nproc           20/a *               hard    nofile             524288" /etc/security/limits.conf 
echo "vm.max_map_count=1048576" | sudo tee -a /etc/sysctl.conf

# virtualization
sudo xbps-install -y virtualbox-ose

# EDA / hardware design
sudo xbps-install -y kicad iverilog

#https://bugraeren.com/blog/vivado_on_void_linux/
# --- vivado ---
sudo xbps-install -y graphviz make unzip zip gcc git libfdisk \
  ncurses ncurses-libs ncurses-base ncurses-libtinfo-libs \
  ncurses-libs-32bit ncurses-libtinfo-libs-32bit ncurses-term \
  xorg-server-xvfb xvfb-run nss libnss-cache alsa-lib alsa-lib-32bit \
  libXScrnSaver libXScrnSaver-32bit gtk+3 gtk+3-32bit
sudo ln -sf /lib/libtinfo.so.6 /lib/libtinfo.so.5
sudo ln -sf /lib/libncurses.so.6 /lib/libncurses.so.5

# ZSA keymapp dependency & proton pass
sudo cp "$install_dir/50-zsa.rules" "/etc/udev/rules.d/50-zsa.rules"
sudo xbps-install -y libwebkit2gtk41
sudo groupadd plugdev
sudo usermod -aG plugdev $USER

# nvidia

install_nvidia(){
  sudo xbps-install -y mesa-dri nvidia  nvidia-libs-32bit
  sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT/c\GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=3 nvidia.NVreg_UseKernelSuspendNotifiers=1 nvidia.NVreg_TemporaryFilePath=/var/tmp/"' /etc/default/grub
}

install_intel(){
  sudo xbps-install mesa-dri mesa-dri-32bit vulkan-loader mesa-vulkan-intel intel-video-accel
}


ask_install "nvidia gpu driver" && install_nvidia
ask_install "intel gpu driver" && install_intel

# Install oh-my-zsh 
if [ ! -d "$HOME/.oh-my-zsh"  ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Installing oh-my-zsh"
  # Clone zsh plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# fix lofree keyboard
echo "options hid_apple fnmode=2" | sudo tee /etc/modprobe.d/20_lofree_fn_mode_fix.conf

# qmk
sudo xbps-install -y qmk dos2unix

# tpm
sudo xbps-install -y tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# grub theme
git clone --depth 1 https://github.com/VandalByte/darkmatter-grub2-theme.git && cd darkmatter-grub2-theme
sudo python3 darkmatter-theme.py --install

# greetd + tuigreet
sudo xbps-install -y greetd tuigreet
sudo sed -i 's|^command.*|command = "tuigreet --remember --remember-session --time --power-shutdown '\''loginctl poweroff'\'' --power-reboot '\''loginctl reboot'\''"|' /etc/greetd/config.toml
sudo sed -i 's|^vt.*|vt = 1|' /etc/greetd/config.toml

sudo ln -sf /etc/sv/greetd/ /var/service
sudo rm -f /var/service/agetty-tty1 

# Boox compatibility
sudo xbps-install -y jmtpfs android-tools syncthing syncthing-gtk

# cron
sudo xbps-install -y dcron
sudo ln -sf /etc/sv/dcron /var/service

# rclone setup
sudo xbps-install -y rclone fuse3
mkdir -p "$HOME/gdrive"
# rclone config # can not run this without browser
