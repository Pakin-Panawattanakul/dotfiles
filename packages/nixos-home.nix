{ config, pkgs, ... }:
{

  services = {
    desktopManager.cosmic.enable = true;
    power-profiles-daemon.enable = false;
  };

  services.desktopManager.cosmic.showExcludedPkgsWarning = false;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-term
    cosmic-store
    cosmic-player
    cosmic-files
    cosmic-greeter
  ];

  # home.packages = with pkgs; [
  # ];
}
