{ config, pkgs, ... }:
{
  home.username = "pakin";
  home.homeDirectory = "/home/pakin";
  home.stateVersion = "26.05";

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
  # services
  #xdg.portal.enable = true; # enable mango automatically enable xdg-desktop-portal

  # google drive rclone
  systemd.user.tmpfiles.rules = [
    "d /home/pakin/gdrive 0755 pakin users -"
  ];

  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Mount Google Drive via rclone";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
      StartLimitIntervalSec = "600";
      StartLimitBurst = "5";
    };
    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount gdrive: /home/pakin/gdrive \
          --vfs-cache-mode full \
          --vfs-cache-max-size 50G \
          --buffer-size 1G \
          --vfs-read-ahead 512M
      '';
      Restart = "on-failure";
      RestartSec = "5";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # packages
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

  imports = [
    ./home-modules/configSymlink.nix
    ./home-modules/theme.nix # forces qt platformtheme=gtk3, conflicts with plasma6
    ./home-modules/neovim.nix
    ./home-modules/mpd.nix
    ./home-modules/terminal.nix
    ./home-modules/firefox.nix
  ];
}
