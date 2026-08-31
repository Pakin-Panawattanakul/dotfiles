#!/bin/sh

$HOME/Scripts/random-wallpaper.sh &
#wbg -s $HOME/Pictures/wallpapers/nix_01.png &
$HOME/Scripts/low_battery.sh &
brightnessctl set 40%
mpc stop

case "$(hostname)" in
  nixos-home) 
    wlr-randr --output DP-2 --mode 1920x1080@165Hz
    solaar -w hide & ;; 
  nixos-NV15)
    wlr-randr --output eDP-1 --mode 1920x1080@165Hz 
    solaar -w hide & ;; 
esac

gammastep -l 15.87:100.99 -m wayland -b 1:0.9 &

exec dbus-update-activation-environment --systemd \
  DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots 
  # QT_QPA_PLATFORM QT_QPA_PLATFORMTHEME QT_STYLE_OVERRIDE QT_PLUGIN_PATH GTK_THEME
