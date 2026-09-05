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
    wlr-randr --output HDMI-A-2 --mode 1920x1080@144.001007Hz --pos 0,0
    wlr-randr --output eDP-1 --mode 1920x1080@165Hz --right-of HDMI-A-2
    solaar -w hide & ;; 
  nixos-T480)
    wlr-randr --output HDMI-A-2 --mode 1920x1080@120Hz --pos 0,0
    wlr-randr --output eDP-1 --right-of HDMI-A-2
esac

gammastep -l 15.87:100.99 -m wayland -b 1:0.9 &

swayidle \
  timeout 1200 'waylock -ignore-empty-password -init-color 0x2c2e33 -input-color 0x005523 -fail-color 0x590008' \
  timeout 1800 'systemctl suspend'

exec dbus-update-activation-environment --systemd \
  DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots 
  # QT_QPA_PLATFORM QT_QPA_PLATFORMTHEME QT_STYLE_OVERRIDE QT_PLUGIN_PATH GTK_THEME
