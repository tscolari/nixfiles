{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    # Packages that should be installed to the user profile.
    packages = [
      unstable.buf
      pkgs.btop
      pkgs.consul
      pkgs.dapr-cli
      pkgs.delve
      unstable.go
      unstable.go-mockery
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
      unstable.protoc-gen-go
      pkgs.reftools
      pkgs.richgo
      pkgs.terraform
      pkgs.vault
      pkgs.waypoint
    ];
  };
}
