#!/bin/sh
setxkbmap -layout us,th -variant colemak_dh_ortho, -option 'grp:win_space_toggle,lv3:caps_switch'
sleep 0.2
xmodmap -e "keycode 43 = m M Thai_maitho Thai_maitaikhu h H" \
-e "keycode 44 = n N Thai_maiek Thai_maichattawa j J" \
-e "keycode 45 = e E Thai_saraaa Thai_sorusi k K" \
-e "keycode 46 = i I Thai_sosua Thai_sosala l L"
