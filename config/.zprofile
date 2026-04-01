# wayland stuff
export QT_QPA_PLATFORM=wayland
export QT_STYLE_OVERRIDE=kvantum
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1

# tell sway to use intel graphic card
#export WLR_DRM_DEVICES=/dev/dri/card1 # remove completely with udev rules
#export GBM_BACKEND=nvidia-drm
#export __GLX_VENDOR_LIBRARY_NAME=nvidia

export SWAY_ROFI_SCREENSHOT_SAVEDIR="$HOME/Pictures/screenshots"

export PATH="$HOME/.local/bin:$PATH"
