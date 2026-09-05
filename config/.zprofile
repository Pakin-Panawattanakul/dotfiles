#nvidia
# this is not require to set by default just for forcing
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia

export MENU_LAUNCHER=bemenu
export BMENU_BACKEND=wayland
export BEMENU_OPTS="\
-i -c -l 10 -W 0.25 -p '' -H 28 --fixed-height \
--fn \"JetBrainsMono Nerd Font Propo 13\"  \
--tf #b3f6c0 --tb #14161be6 \
--nf #e0e2ea --nb #14161be6 \
--ff #e0e2ea --fb #14161be6 \
--hf #8cf8f7 --hb #14161be6 \
--af #e0e2ea --ab #14161be6"

export PATH="$HOME/.local/bin:$HOME/Scripts:$PATH"

# home-manager session vars display managers auto source this but greetd:tuigreet does not
# if [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
#   . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
# fi

