{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  programs.foot.enable = true;

  home.packages = with pkgs; [
    zoxide
    eza
    fzf
    starship
    fastfetch
    bat
    ncdu
    tldr

    # dev program
    gcc
    gdb

    #lazygit
  ];

  programs.zsh = {
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

  programs = {
    opencode = {
      enable = false;
      settings = {
        autoupdate = false;
      };
      package = pkgs-unstable.opencode;
    };
  };

}
