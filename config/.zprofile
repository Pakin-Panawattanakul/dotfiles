# wayland stuff
export QT_QPA_PLATFORM=wayland
export QT_STYLE_OVERRIDE=kvantum
export SDL_VIDEODRIVER=wayland
export ELM_DISPLAY=wl
export _JAVA_AWT_WM_NONREPARENTING=1
# in void have to run on firefox xwayland instead
export MOZ_ENABLE_WAYLAND=0

# tell sway to use intel graphic card
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia

export SWAY_ROFI_SCREENSHOT_SAVEDIR="$HOME/Pictures/screenshots"

export PATH="$HOME/.local/bin:$PATH"
