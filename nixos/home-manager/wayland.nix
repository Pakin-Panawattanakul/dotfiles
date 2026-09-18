{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # wayland
    #rofi
    bemenu
    swayidle
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

  home.file.".local/bin/wmenu-drun".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/submodules/wmenu-scripts/wmenu-drun";
  home.file.".local/bin/wmenu-powermenu".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/submodules/wmenu-scripts/wmenu-powermenu";
}
