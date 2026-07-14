#!/bin/sh

$HOME/Scripts/random-wallpaper.sh &
$HOME/Scripts/low_battery.sh &
brightnessctl set 20%
pkill -x mako
mako &
if [ "$HOST" = "void-linux-PC" ]; then
  wlr-randr --output DP-3 --mode 1920x1080@165Hz
else if [ "$HOST" = "void-linux" ]; then
  wlr-randr --output eDP-1 --mode 1920x1080@165Hz
fi

"$HOME"/Scripts/runit-user-service.sh
exec dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
