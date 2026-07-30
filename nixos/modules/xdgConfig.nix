{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  xdgConfigs = [
    "eza"
    "foot"
    "mako"
    "mango"
    "mpd"
    "nvim"
    "rmpc"
    "rofi"
    "yazi"
  ];
  xdgConfigSymlink = name:
    config.lib.file.mkOutOfStoreSymlink
      "${dotfiles}/config/.config/${name}";
in {
  xdg.configFile =
    builtins.listToAttrs (
      map (name: {
        name = name;
        value = {
          source = xdgConfigSymlink name;
        };
      }) xdgConfigs
    );
}
