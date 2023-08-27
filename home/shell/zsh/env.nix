{ config, pkgs, userData, ... }:

{

  home = {
    sessionVariables = rec {
      PATH   = "$HOME/.local/bin:$GOPATH/bin:$PATH";
      EDITOR = "vim";
      VISUAL = "vim";

      GREP_COLOR = "1;33";

      GOPATH      = "$HOME/go";
      GO111MODULE = "on";
      GOPRIVATE   = "github.com/hashicorp";
    };
  };

  programs.zsh = {
    sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
  };
}
