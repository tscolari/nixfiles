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
      pkgs.docker-compose
      pkgs.file
      unstable.go
      unstable.go-migrate
      unstable.go-mockery
      unstable.gofumpt
      unstable.golangci-lint
      unstable.golines
      unstable.gomodifytags
      unstable.gotests
      unstable.gotestsum
      unstable.gotools
      unstable.govulncheck
      pkgs.grpcui
      pkgs.hugo
      pkgs.iferr
      pkgs.impl
      pkgs.kind
      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.minikube
      pkgs.mockgen
      pkgs.pgcli
      unstable.protoc-gen-go
      unstable.protoc-gen-go-grpc
      pkgs.reftools
      pkgs.richgo
      pkgs.terraform
      pkgs.xclip
    ];
  };
}
