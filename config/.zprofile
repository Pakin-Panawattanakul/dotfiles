#nvidia
# this is not require to set by default just for forcing
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia

export PATH="$HOME/.local/bin:$HOME/Scripts:$PATH"

# home-manager session vars display managers auto source this but greetd:tuigreet does not
# if [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
#   . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
# fi

