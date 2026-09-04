{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs-unstable; [
    # wayland
    rofi
    waylock
    wbg
    wl-clipboard
    grim
    slurp
    wlr-randr
    wdisplays
    gammastep
    wl-mirror
    libnotify
    wev
  ];

}
