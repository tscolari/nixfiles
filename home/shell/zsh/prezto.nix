{ config, pkgs, userData, ... }:

{
  programs.zsh = {
    prezto = {
      enable = true;

      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "ssh"
        "fasd"
        "completion"
        "ruby"
        "rails"
        "git"
        "history-substring-search"
        "prompt"
        "syntax-highlighting"
      ];

      editor.keymap = "emacs";
      prompt.theme = "sorin";
      tmux.autoStartLocal = true;
    };
  };
}
