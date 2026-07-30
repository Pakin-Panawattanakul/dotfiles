{ config, pkgs, ... }:
{
  imports = [
    ./modules/homeFile.nix
    ./modules/xdgConfig.nix
    ./modules/theme.nix
  ];

  home.username = "pakin";
  home.homeDirectory = "/home/pakin";
  home.stateVersion = "26.05";

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
      };
      autosuggestion = {
        enable = true;
        highlight = "fg=7";
      };
      syntaxHighlighting.enable = true;
      initContent = ''
        source /home/pakin/dotfiles/config/.zshrc
      '';
      envExtra = ''
        source /home/pakin/dotfiles/config/.zshenv
      '';
      profileExtra = ''
        source /home/pakin/dotfiles/config/.zprofile
      '';
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "Pakin Panawattanakul";
          email = "p.panawattanakul@gmail.com";
        };
        pull.rebase = true;
        init.defaultBranch = "main";
        submodule.recurse = true;
      };
      lfs.enable = true;
    };

    foot.enable = true;
  };

  home.packages = with pkgs; [
    # neovim
    neovim
    ripgrep
    fd
    nodejs
    rustc
    cargo
    gcc
    python3
    tree-sitter
    unzip
    gnumake
    #dev
    gdb
    jq

    rofi
    waybar
    wbg
    wl-clipboard
    grim
    slurp
    wlr-randr
    wdisplays

    eza
    zoxide
    fzf
    yazi
    starship
    lazygit
    fastfetch
    bat

    bluetui
    wiremix
    brightnessctl
    btop

    libreoffice
    thunderbird

    zathura
    mpc
    rmpc
    mpv
    imv
    cava

    vesktop
    spotify
    opencode
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
