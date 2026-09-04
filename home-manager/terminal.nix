{ config, pkgs, ... }:

{
  programs.foot.enable = true;

  home.packages = with pkgs; [
    eza
    zoxide
    fzf
    starship
    lazygit
    fastfetch
    bat
    ncdu
    tldr

    # dev program
    gcc
    gdb
    opencode

    # yazi and dependency
    yazi
    ffmpeg
    p7zip
    poppler
    resvg
    imagemagick
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
      source /home/pakin/nixos-dotfiles/config/.zshrc
    '';
    envExtra = ''
      source /home/pakin/nixos-dotfiles/config/.zshenv
    '';
    profileExtra = ''
      source /home/pakin/nixos-dotfiles/config/.zprofile
    '';
  };

  programs.tmux = {
    enable = true;
    #prefix = "C-a";
    baseIndex = 1;
    mouse = true;
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      resurrect
      continuum
    ];

    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config updated"

      set-option -g allow-rename off
      set -as terminal-features ",foot:RGB,rxvt-unicode-256color:clipboard"
      set -g pane-base-index 1
      set -s set-clipboard external

      # ---------- Status Bar ----------
      set -g status-style "bg=black,fg=default,bold"
      set -g status-position top
      set -g status-justify absolute-centre
      set -g message-style "bg=black,fg=blue,bold"
      set -g message-command-style "bg=blue,fg=black,bold"
      set -g window-status-format " #I:#W "
      set -g window-status-style "fg=white,bg=black"
      set -g window-status-current-format " #I:#W "
      set -g window-status-current-style "fg=blue,bg=black,bold"
      set -g status-left "#S "
      set -g status-left-style "bg=black,fg=default"
      set -g status-right "#(TZ='Asia/Bangkok' date +%%H:%%M)"
      set -g status-right-style "bg=black,fg=default,bold"
      set -g mode-style "bg=blue,fg=black,bold"

      # ---------- Key Bind ----------
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      set -g @vim_navigator_mapping_left "C-Left"
      set -g @vim_navigator_mapping_right "C-Right"
      set -g @vim_navigator_mapping_up "C-Up"
      set -g @vim_navigator_mapping_down "C-Down"
      set -g @vim_navigator_mapping_prev ""
      set -g @continuum-restore 'on'
      run-shell ${pkgs.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux
      run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
      '';
  };
}
