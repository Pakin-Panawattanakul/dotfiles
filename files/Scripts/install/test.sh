#!/bin/sh
sv_enable(){
  sudo ln -s "/etc/sv/$0" /var/service
}
#sv_enable(uwf)

choice=""
while [ "$choice" != "y" ] && [ "$choice" != "n" ]; do
    printf "Installing nvidia gpu driver?"
    read -r choice
done

if [ ! $(fd BAT /sys/class/power_supply/) ]; then
  sudo xbps-install tlp 
fi
