{ config, pkgs, ... }:
{

  services = {
    desktopManager.cosmic.enable = true;
    power-profiles-daemon.enable = false;
  };
  

  # home.packages = with pkgs; [
  # ];
}
