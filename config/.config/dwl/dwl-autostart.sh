#!/bin/sh

$HOME/Scripts/random-wallpaper.sh &
$HOME/Scripts/low_battery.sh &
brightnessctl set 50%

dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
pkill -x mako
sleep 0.5
mako &

$HOME/Scripts/media.sh
