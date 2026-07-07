#!/bin/sh

$HOME/Scripts/low_battery.sh &
wbg "$HOME/Pictures/wallpapers/void_019.png" &
brightnessctl set 50%

dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

pkill -x pipewire
pkill -x mpd 
pkill -x mako
sleep 0.5
pipewire &
mpd &
mako &
