{ config, pkgs, ... }:
{

  users.users.pakin = {
    packages = with pkgs; [
      z-library-desktop
      calibre
    ];
  };

}
