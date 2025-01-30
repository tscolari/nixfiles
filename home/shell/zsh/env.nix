{ config, pkgs, lib, userData, ... }:

{

  home = {
    sessionVariables = rec {
      PATH   = "$HOME/.local/bin:$PATH";
      EDITOR = "vim";
      VISUAL = "vim";

      GREP_COLOR = "1;33";

      GOPATH      = "$HOME/go:$GOPATH";
      GO111MODULE = "on";
      GOPRIVATE   = "github.com/hashicorp,github.com/tscolari";
    };
  };

  programs.zsh = {
    sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";

      NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
        pkgs.stdenv.cc.cc
      ];

      NIX_LD = builtins.readFile "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
    };
  };
}
