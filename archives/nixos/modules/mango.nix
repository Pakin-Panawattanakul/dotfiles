{ config, pkgs, pkgs-unstable, ... }:
{
  programs.mangowc ={
    enable = true;
    package = pkgs-unstable.mango;
  };
  
  environment.systemPackages = [
    pkgs.waybar
  ];
}
