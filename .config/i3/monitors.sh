#!/usr/bin/env bash

# Make laptop screen primary
xrandr --output eDP-1 --mode 1920x1080 --rate 165 --primary

# Mirror any connected external monitors
for output in DP-1 DP-2 HDMI-1-0 HDMI-1; do
    if xrandr | grep -q "^$output connected"; then
        xrandr --output "$output" --mode 1920x1080 --same-as eDP-1
    fi
done

nitrogen --restore
