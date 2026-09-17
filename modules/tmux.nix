{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    #prefix = "C-a";
    baseIndex = 1;
    #mouse = true;
    terminal = "screen-256color";
    keyMode = "vi";
    aggressiveResize = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      resurrect
      continuum
    ];

    extraConfigBeforePlugins = ''
      set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
      set -g @vim_navigator_mapping_right "C-Right C-l"
      set -g @vim_navigator_mapping_up "C-Up C-k"
      set -g @vim_navigator_mapping_down "C-Down C-j"
      set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding
      set -g @continuum-restore 'on'
    '';

    extraConfig = ''
      # Address vim mode switching delay (http://superuser.com/a/252717/65504)
      set -s escape-time 0

      # Increase scrollback buffer size from 2000 to 50000 lines
      set -g history-limit 50000

      # Increase tmux messages display duration from 750ms to 4s
      set -g display-time 4000

      # Emacs key bindings in tmux command prompt (prefix + :) are better than
      # vi keys, even for vim users
      set -g status-keys emacs

      # Focus events enabled for terminals that support them
      set -g focus-events on

      # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
      set -g status-interval 5

      unbind r
      # tmux path change to /etc/tmux.conf since i use nix-options instead of home-manager
      bind r source-file /etc/tmux.conf \; display-message "Config updated"

      set-option -g allow-rename on
      set -as terminal-features ",foot:RGB,rxvt-unicode-256color:clipboard"
      #set -g pane-base-index 1 # set by nix
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
      # Easier and faster switching between next/prev window
      bind C-p previous-window
      bind C-n next-window
    '';
  };
}
