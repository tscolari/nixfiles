{
  config,
  ...
}:

let

  theme = config.userData.zshTheme;

in
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
        # "ssh"
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
      prompt.theme = "${theme}";
      tmux.autoStartLocal = true;

      ssh = {
        identities = [ ]; # Don't load identities - let GNOME Keyring handle it
      };
    };
  };
}
