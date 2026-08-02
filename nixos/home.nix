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
      Restart = "no";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      extraConfig = builtins.readFile ../files/Templates/user.js;
      search = {
        force          = true;
        default        = "ddg";
        privateDefault = "ddg";

        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "query";   value = "{searchTerms}"; }
              ];
            }];
            icon           = ./Icons/nix-packages.svg;
            definedAliases = [ "np" ];
          };

          "Nix Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "query";   value = "{searchTerms}"; }
              ];
            }];
            icon           = ./Icons/nix-options.svg;
            definedAliases = [ "no" ];
          };

          "NixOS Wiki" = {
            urls = [{
              template = "https://wiki.nixos.org/w/index.php";
              params   = [ { name = "search"; value = "{searchTerms}"; } ];
            }];
            icon           = ./Icons/nix-wiki.svg;
            definedAliases = [ "nw" ];
          };

          "MyNixOS" = {
            urls            = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
            icon            = ./Icons/mynixos.svg;
            definedAliases  = [ "mn" ];
          };

          "Arch Wiki" = {
            urls           = [{ template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; }];
            icon           = ./Icons/arch_wiki.svg;
            definedAliases = [ "aw" ];
          };

          youtube = {
            urls           = [{ template = "https://www.youtube.com/results?search_query={searchTerms}"; }];
            icon           = ./Icons/youtube.svg;
            definedAliases = [ "yt" ];
          };
        };
      };
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

    # desktop utils
    bluetui
    wiremix
    brightnessctl
    btop
    aria2
    qalculate-gtk
    gimp

    # Media
    zathura
    mpc
    rmpc
    mpv
    imv
    cava

    vesktop
    spotify
    opencode
    libreoffice
    thunderbird

    wev
    bitwarden-desktop
    #gnome keyring
    seahorse
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  imports = [
    ./home-modules/configSymlink.nix
    ./home-modules/theme.nix
    ./home-modules/neovim.nix
    ./home-modules/mpd.nix
    ./home-modules/terminal.nix
  ];
}
