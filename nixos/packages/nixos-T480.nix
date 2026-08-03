{config ,pkgs, ... }:
{

  home.packages = with pkgs; [
    z-library-desktop
    calibre
  ];
}
