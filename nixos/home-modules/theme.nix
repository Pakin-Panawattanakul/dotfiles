{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Orchis-Dark";
      package = pkgs.orchis-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    colorScheme = "dark";
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk3";
  #   style.name = "gtk2";
  # };
}
