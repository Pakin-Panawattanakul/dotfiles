#!/bin/sh
case "$(hostname)" in
  nixos-home) 
    wlr-randr --output DP-3 --mode 1920x1080@165Hz
    solaar -w hide & ;; 
  nixos-NV15)
    wlr-randr --output eDP-1 --mode 1920x1080@165Hz 
    solaar -w hide & ;; 
esac
