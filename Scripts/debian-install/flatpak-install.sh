#!/bin/sh
flatpak install flathub io.github.kolunmi.Bazaar 

flatpak install flathub org.libreoffice.LibreOffice \
  com.discordapp.Discord \
  com.github.tchx84.Flatseal \
  org.freedesktop.Platform.GL32.nvidia-595-45-04 \
  com.valvesoftware.Steam \
  com.spotify.Client \
  io.github.hrkfdn.ncspot \
  org.mozilla.Thunderbird

flatpak override --filesystem='~/.local/share/icons'
flatpak override --filesystem='~/.local/share/fonts'
flatpak override --filesystem='~/.themes'

flatpak override --env=GTK_THEME=Orchis-Dark-Compact
flatpak override --env=ICON_THEME=Papirus-Dark

flatpak override --filesystem='~/.config/ncspot' io.github.hrkfdn.ncspot

# this wouldn't work until open ncspot for the first time
flatpak run io.github.hrkfdn.ncspot
ln -sf "$HOME/.config/ncspot/config.toml" "$HOME/.var/app/io.github.hrkfdn.ncspot/config/ncspot/config.toml"
