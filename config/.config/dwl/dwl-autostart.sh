#!/bin/sh

$HOME/Scripts/low_battery.sh &
wbg "$HOME/Pictures/wallpapers/astronaut.png" &
brightnessctl set 50%

dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

wlr-randr --output DP-3 --mode 1920x1080@165
wlr-randr --output eDP-1 --mode 1920x1080@165
pkill -x pipewire
pkill -x mpd 
pkill -x mako
sleep 0.5
pipewire &
mpd &
mako &
