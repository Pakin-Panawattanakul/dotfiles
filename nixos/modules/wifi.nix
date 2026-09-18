{ config, pkgs, ... }:
{
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    Network = {
      EnableIPv6 = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };
  networking.networkmanager.wifi.backend = "iwd";

  environment.systemPackages = [ pkgs.impala ];
}
