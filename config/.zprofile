#nvidia
# this is not require to set by default just for forcing
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia

# User Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# System Directories
export XDG_DATA_DIRS="/usr/local/share:$HOME/.local/share/flatpak/exports/share:/usr/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
export XDG_CONFIG_DIRS="/etc/xdg"

export PATH="$HOME/.local/bin:$HOME/Scripts:$PATH"

# home-manager session vars display managers auto source this but greetd:tuigreet does not
# if [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
#   . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
# fi

