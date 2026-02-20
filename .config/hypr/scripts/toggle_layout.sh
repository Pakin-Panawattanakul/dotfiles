#!/usr/bin/env bash

# Script for changing Hyprland Layouts (Master or Dwindle) on fly

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case $LAYOUT in
"master")
	hyprctl keyword general:layout dwindle
	;;
"dwindle")
	hyprctl keyword general:layout master
	;;
*) ;;

esac
