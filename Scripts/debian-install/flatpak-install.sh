#!/bin/sh
flatpak install flathub io.github.kolunmi.Bazaar \
  org.libreoffice.LibreOffice \
  com.discordapp.Discord \
  com.github.tchx84.Flatseal \
  org.freedesktop.Platform.GL32.nvidia-595-45-04 \
  com.valvesoftware.Steam \
  com.spotify.Client \
  io.github.hrkfdn.ncspot \
  org.mozilla.Thunderbird \
  org.mozilla.firefox

sudo flatpak override --filesystem='~/.local/share/icons'
sudo flatpak override --filesystem='~/.local/share/fonts'
sudo flatpak override --filesystem='~/.themes'

sudo flatpak override --env=GTK_THEME=Orchis-Dark-Compact
sudo flatpak override --env=ICON_THEME=Papirus-Dark

sudo flatpak override --filesystem='~/.config/ncspot' io.github.hrkfdn.ncspot

# this wouldn't work until open ncspot for the first time
flatpak run io.github.hrkfdn.ncspot
ln -sf "$HOME/.config/ncspot/config.toml" "$HOME/.var/app/io.github.hrkfdn.ncspot/config/ncspot/config.toml"
