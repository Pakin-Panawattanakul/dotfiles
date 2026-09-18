{ config, pkgs, ... }:
{
  users.extraGroups.vboxusers.members = [ "pakin" ];
  virtualisation.virtualbox = {
    host.enable = true;
    guest = {
      enable = false;
      dragAndDrop = true;
    };
  };
}
