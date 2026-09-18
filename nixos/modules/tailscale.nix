{config, pkgs,... }:
{

  services.tailscale = {
    enable = true;
  };

  environment.systemPackages = with pkgs;[
      nfs-utils
      cifs-utils
  ];

}
