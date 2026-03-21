#!/bin/sh
flatpak install flathub io.github.kolunmi.Bazaar 

flatpak install --user flathub org.libreoffice.LibreOffice \
  com.discordapp.Discord \
  com.github.tchx84.Flatseal \
  org.freedesktop.Platform.GL32.nvidia-595-45-04 \
  com.valvesoftware.Steam \
  com.spotify.Client \
  io.github.hrkfdn.ncspot \
  org.mozilla.Thunderbird

flatpak override --user --filesystem='~/.local/share/icons'
flatpak override --user --filesystem='~/.local/share/fonts'
flatpak override --user --filesystem='~/.themes'

flatpak override --user --env=GTK_THEME=Orchis-Dark-Compact
flatpak override --user --env=ICON_THEME=Papirus-Dark

flatpak override --user --filesystem='~/.config/ncspot' io.github.hrkfdn.ncspot

ln -sf "$HOME/.config/ncspot/config.toml" "$HOME/.var/app/io.github.hrkfdn.ncspot/config/ncspot/config.toml"
