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

    font.name = "JetBrainsMonoNerdFont";
    font.size = 11;
    colorScheme = "dark";
  };

  xdg.configFile."kded6rc".text = ''
    [Module-gtkconfig]
    autoload=false
  '';

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk3";
  #   style.name = "gtk2";
  # };
}
