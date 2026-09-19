{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  # Enable Plasma
  services = {
    desktopManager.cosmic.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      extraPackages = [ pkgs.sddm-astronaut ];
    };
  };

  environment.systemPackages = [
    pkgs.sddm-astronaut
  ];
}
