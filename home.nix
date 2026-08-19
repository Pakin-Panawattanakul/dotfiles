{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.username = "pakin";
  home.homeDirectory = "/home/pakin";
  home.stateVersion = "26.05";

  imports = [
    ./home-manager/configSymlink.nix
    ./home-manager/theme.nix # forces qt platformtheme=gtk3, conflicts with plasma6
    ./home-manager/neovim.nix
    ./home-manager/mpd.nix
    ./home-manager/terminal.nix
    ./home-manager/firefox.nix
    ./home-manager/rclone-gdrive.nix
    ./packages/stable.nix
    ./packages/unstable.nix
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Pakin Panawattanakul";
        email = "p.panawattanakul@gmail.com";
      };
      pull.rebase = true;
      init.defaultBranch = "main";
      submodule.recurse = true;
      credential.helper = "libsecret";
    };
    package = pkgs.git.override { withLibsecret = true; };
    lfs.enable = true;
  };

  # conflicts with plasma6's notification system
  services.mako = {
    enable = true;
    settings = {

      font = "JetBrainsMonoNerdFont Regular 12";
      background-color = "#14161bff";
      text-color = "#e0e2ea";
      border-color = "#b3f6c0ff";
      border-radius = 4;
      border-size = 1;
      default-timeout = 5000;
      max-icon-size = 48;
      icon-path = "/etc/profiles/per-user/pakin/share/icons/Papirus-Dark";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    videos = null;
    publicShare = null;
  };
}
