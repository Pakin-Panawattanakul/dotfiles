#!/bin/sh

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/.local/share/fonts"
mkdir -p "$HOME/.local/share/keymapp"
mkdir -p "$HOME/.local/share/rofi"
mkdir -p "$HOME/.local/share/themes"

# stowing config and asset dir
stow assets
stow config
stow wmenu-scripts --target="$HOME/.local/bin" 
stow rofi --target="$HOME/.local/bin" 
