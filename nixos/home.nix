{ config, pkgs, pkgs-unstable, ... }:
{
  home.username = "pakin";
  home.homeDirectory = "/home/pakin";
  home.stateVersion = "26.05";

  imports = [
    ./home-modules/configSymlink.nix
    ./home-modules/theme.nix # forces qt platformtheme=gtk3, conflicts with plasma6
    ./home-modules/neovim.nix
    ./home-modules/mpd.nix
    ./home-modules/terminal.nix
    ./home-modules/firefox.nix
    ./home-modules/rclone-gdrive.nix
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

  # packages
  programs.opencode.package = pkgs-unstable.opencode;
  home.packages = with pkgs; [
    #dev
    gdb
    #jq # do i need this?
    rclone
    fuse3

    # wayland
    rofi
    waybar
    waylock
    wbg
    wl-clipboard
    grim
    slurp
    wlr-randr
    wdisplays
    gammastep
    wl-mirror
    libnotify
    wev

    # desktop utils
    bluetui
    wiremix
    brightnessctl
    btop
    aria2
    qalculate-gtk
    gimp
    jmtpfs
    gnome-clocks

    # Media
    zathura
    mpc
    rmpc
    mpv
    imv
    cava

    vesktop
    spotify
    yt-dlp
    opencode
    libreoffice
    thunderbird
    bitwarden-desktop
    #gnome keyring
    seahorse
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    videos = null;
    publicShare = null;
  };
}
