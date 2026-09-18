#!/bin/sh
# Run after install.sh, as the normal desktop user (never with sudo).
set -eu

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub io.github.kolunmi.Bazaar \
  org.libreoffice.LibreOffice \
  com.discordapp.Discord \
  com.spotify.Client \
  io.github.hrkfdn.ncspot

flatpak override --user --filesystem="$HOME/.local/share/icons"
flatpak override --user --filesystem="$HOME/.local/share/fonts"
flatpak override --user --filesystem="$HOME/.themes"

flatpak override --user --env=GTK_THEME=Orchis-Dark
flatpak override --user --env=ICON_THEME=Papirus-Dark

flatpak override --user --filesystem="$HOME/.config/ncspot" io.github.hrkfdn.ncspot

# this wouldn't work until open ncspot for the first time
#ln -sf "$HOME/.config/ncspot/config.toml" "$HOME/.var/app/io.github.hrkfdn.ncspot/config/ncspot/config.toml"
