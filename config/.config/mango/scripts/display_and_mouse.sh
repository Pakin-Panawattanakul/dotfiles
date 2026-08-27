#!/bin/sh
case "$(hostname)" in
  nixos-home) 
    wlr-randr --output DP-3 --mode 1920x1080@165Hz
    solaar -w hide & ;; 
  nixos-NV15)
    wlr-randr --output eDP-1 --mode 1920x1080@165Hz 
    wlr-randr --output HDMI-A-2 --mode 1920x1080@144.001007Hz
    solaar -w hide & ;; 
esac
