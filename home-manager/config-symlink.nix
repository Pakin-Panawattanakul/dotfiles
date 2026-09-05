{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles";
  xdgConfigs = [
    "dwl"
    "eza"
    "foot"
    "ncspot"
    "nvim"
    "opencode"
    "rmpc"
    "yt-dlp/plugins"
    "starship.toml"
    "xkb"
  ];
  xdgConfigSymlink = name: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/.config/${name}";

  homeFiles = [
    "Pictures/wallpapers"
    "Scripts"
    "Templates"
  ];

  homeFileSymlink = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/files/${path}";
in
{
  xdg.configFile = builtins.listToAttrs (
    map (name: {
      name = name;
      value = {
        source = xdgConfigSymlink name;
      };
    }) xdgConfigs
  );

  home.file =
    builtins.listToAttrs (
      map (path: {
        name = path;

        value = {
          source = homeFileSymlink path;
        };
      }) homeFiles
    )
    // {
      # custom
      ".profile".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/.profile";
    };

}
