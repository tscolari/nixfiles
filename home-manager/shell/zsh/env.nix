{
  pkgs,
  lib,
  ...
}:

{

  home = {
    sessionVariables = rec {
      PATH = "$HOME/.local/bin:$PATH";
      VISUAL = "vim";

      GREP_COLOR = "1;33";

      GOPATH = "$HOME/go:$GOPATH";
      GO111MODULE = "on";
      GOPRIVATE = "github.com/redpanda-data,github.com/tscolari";
    };
  };

  programs.zsh = {
    sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";

      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";

      NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
        pkgs.stdenv.cc.cc
      ];

      NIX_LD = builtins.readFile "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
    };
  };
}
