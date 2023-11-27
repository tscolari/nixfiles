{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    packages = [
      pkgs.consul
      pkgs.delve
      unstable.go
      unstable.gofumpt
      unstable.golangci-lint
      unstable.golines
      unstable.gomodifytags
      unstable.gotests
      unstable.gotestsum
      unstable.gotools
      unstable.govulncheck
      pkgs.iferr
      pkgs.impl
      pkgs.kind
      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.minikube
      pkgs.mockgen
      pkgs.reftools
      pkgs.richgo
      pkgs.terraform
      pkgs.vault
      pkgs.waypoint
    ];
  };
}
