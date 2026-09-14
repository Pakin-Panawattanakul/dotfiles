{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    calibre
    z-library-desktop
  ];
}
