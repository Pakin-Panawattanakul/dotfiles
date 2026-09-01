#!/bin/sh

bluetooth_state=$(bluetoothctl show | grep PowerState | cut -f 2 -d ' ')
if [ "$bluetooth_state" = 'off' ]; then
  bluetoothctl power on
  notify-send "Bluetooth on"
elif [ "$bluetooth_state" = 'on' ]; then
  bluetoothctl power off
  notify-send "Bluetooth off"
fi
