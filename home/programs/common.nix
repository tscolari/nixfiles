{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    # Packages that should be installed to the user profile.
    packages = [
     # pkgs.git-duet
     # pkgs.jsonpp
     # pkgs.pyenv

     # Coding
      pkgs.consul
      pkgs.delve
      pkgs.go
      pkgs.gofumpt
      pkgs.golangci-lint
      pkgs.golines
      pkgs.gomodifytags
      pkgs.gotests
      pkgs.gotestsum
      pkgs.gotools
      pkgs.govulncheck
      pkgs.iferr
      pkgs.impl
      pkgs.kind
      pkgs.kubectl
      pkgs.kubernetes
      pkgs.minikube
      pkgs.mockgen
      pkgs.reftools
      pkgs.richgo
      pkgs.terraform
      pkgs.sysprof
      pkgs.vault
      pkgs.waypoint
      pkgs.xclip

    # Misc
      pkgs.shortwave
      pkgs._1password-gui
      pkgs.chromium
      pkgs.spotify
      pkgs.transmission

    # Game
      pkgs.steam

    # Chat
      pkgs.slack
      pkgs.discord

    # Video
      pkgs.zoom-us
      pkgs.skypeforlinux
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
  };
}
