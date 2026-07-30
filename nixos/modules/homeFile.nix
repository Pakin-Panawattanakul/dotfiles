{ config, ... }:
let
  home = config.home.homeDirectory;
  dotfiles = "${home}/dotfiles";

  homeFiles = [
    "Pictures/wallpapers"
    "Scripts"
    ".local/share/rofi/themes"
  ];

  homeFileSymlink = path:
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/files/${path}";
in
{
  home.file =
    builtins.listToAttrs (
      map (path: {
        name = path;

        value = {
          source = homeFileSymlink path;
        };
      }) homeFiles
    );
}
