#!/bin/sh

while true; do
    battery=$(upower -i "$(upower -e | grep BAT)" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
    if [ -z "$battery" ]; then
      exit
    fi
    if [ "$battery" -le "20" ]; then
         notify-send -i battery-low "Low battery: ${battery}%" 
        sleep 240
    else
        sleep 120
    fi
done
