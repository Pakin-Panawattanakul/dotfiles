{ config, pkgs, ... }:
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
    font.size = 12;
    colorScheme = "dark";
  };

  home.sessionVariables = {
    #QT_QPA_PLATFORM = "wayland;xcb";
    GTK_THEME = "Orchis-Dark";
  };

  #  xdg.configFile = {
  #    "gtk-4.0/gtk.css".source = "${pkgs.orchis-theme}/share/themes/Orchis-Dark/gtk-4.0/gtk.css";
  #    "gtk-4.0/gtk-dark.css".source =
  #      "${pkgs.orchis-theme}/share/themes/Orchis-Dark/gtk-4.0/gtk-dark.css";
  #    "gtk-4.0/assets".source = "${pkgs.orchis-theme}/share/themes/Orchis-Dark/gtk-4.0/assets";
  #  };

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "Orchis-Dark";
    icon-theme = "Papirus-Dark";
    color-scheme = "prefer-dark";
  };
}
