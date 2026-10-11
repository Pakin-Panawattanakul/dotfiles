export PROTON_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM="wayland;xcb"
export GDK_BACKEND=wayland
export SDL_VIDEODRIVER=wayland,x11
export MOZ_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export XDG_SESSION_TYPE=wayland

export MENU_TERM=foot
export MENU_LAUNCHER=bemenu
export BMENU_BACKEND=wayland
export BEMENU_OPTS="\
-i -c -l 10 -W 0.25 -p '' -H 28 --fixed-height \
--fn \"JetBrainsMono Nerd Font Propo 13\"  \
--tf #8a9a7b --tb #181616e6 \
--nf #c5c9c5 --nb #181616e6 \
--ff #c5c9c5 --fb #181616e6 \
--hf #8ea4a2 --hb #181616e6 \
--af #c5c9c5 --ab #181616e6"

# swaylock colors (used by lock/powermenu scripts; rrggbb, no 0x)
export LOCK_INIT_COLOR=282727
export LOCK_INPUT_COLOR=2b3328
export LOCK_FAIL_COLOR=43242b
# override wmenu-powermenu's lock command (upstream default stays waylock)
export LOCK_CMD="$HOME/Scripts/lock.sh"

export PATH="$HOME/.local/bin:$HOME/Scripts:$PATH"
export XDG_DATA_DIRS=/usr/share:/usr/local/share/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS
# home-manager session vars display managers auto source this but greetd:tuigreet does not
# if [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
#   . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
# fi

