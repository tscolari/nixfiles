{ config, pkgs, ... }:

{

  programs.tmux = {
    enable = true;

    # mouse     = true;
    baseIndex = 1;
    clock24   = true;
    keyMode   = "vi";
    prefix    = "C-Space";
    terminal  = "screen-256color";

    plugins = with pkgs; [
      tmuxPlugins.copycat
      tmuxPlugins.pain-control
      tmuxPlugins.prefix-highlight
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
    ];

    extraConfig = "
      set-option -g status-bg colour235 #base02
      set-option -g status-fg colour136 #yellow

      set -g status-justify centre # center align window list
      set -g status-left-length 70
      set -g status-right-length 70
      set -g status-justify centre
      set -g status-bg colour234
      set -g status-left '#[default]┃ #[fg=green,bright]#h #[default]┃ #[fg=blue]#S #I:#P #[default]┃ '
      set -g status-right '#[default]┃ #[fg=red,dim] #[default]┃ #[fg=white]%l:%M:%S %p #[default]┃ #[fg=blue]%a %Y-%m-%d #[default]┃'

      bind r source-file ~/.tmux.conf
      bind-key C-Space last-window

      set -g mouse on
      setw -g mouse on
    ";
  };
}
