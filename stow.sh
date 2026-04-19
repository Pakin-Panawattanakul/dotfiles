#!/bin/sh
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/.local/share/fonts"
mkdir -p "$HOME/.local/share/keymapp"
mkdir -p "$HOME/.local/share/rofi"
mkdir -p "$HOME/.themes"

# stowing config and asset dir
stow files
stow config
stow rofi-scripts --target="$HOME/.local/bin" 
ln -sf "$HOME/dotfiles/config/.config/sway/start-sway" "$HOME/.local/bin"

# mpd
mkdir -p "$HOME/.local/state/mpd"
touch "$HOME/.local/state/mpd/state"
touch "$HOME/.config/mpd/database"
