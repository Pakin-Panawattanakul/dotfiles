#!/bin/sh

# start runit user service
if [ -n "$DBUS_SESSION_BUS_ADDRESS" ]; then
    env | grep -E '^DBUS_SESSION_BUS_ADDRESS' > "$XDG_RUNTIME_DIR/dbus-session-env"
fi
sv restart "$HOME"/.runit/service/*
