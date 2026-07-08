#!/bin/sh
pkill -x pipewire
pkill -x mpd

pipewire > /dev/null 2>&1 &

# wait for the real socket instead of a fixed sleep
for i in $(seq 1 50); do
    [ -S "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/pipewire-0" ] && break
    sleep 0.05
done

mpd > /dev/null 2>&1 &
