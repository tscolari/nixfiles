{ config, pkgs, ... }:

let

in {

  home = {
    # Packages that should be installed to the user profile.
    packages = [
      pkgs.btop
      pkgs.consul
      pkgs.dapr-cli
      pkgs.delve
      pkgs.dig
      pkgs.docker-compose
      pkgs.file
      pkgs.hey
      pkgs.hub
      pkgs.hugo
      pkgs.iferr
      pkgs.impl
      pkgs.kind
      pkgs.kubectl
      pkgs.kubernetes
      pkgs.kubernetes-helm
      pkgs.minikube
      pkgs.mockgen
      pkgs.pgcli
      pkgs.python312Packages.pip
      pkgs.reftools
      pkgs.richgo
      pkgs.sysprof
      pkgs.terraform
      pkgs.unstable.buf
      pkgs.unstable.go
      pkgs.unstable.go-migrate
      pkgs.unstable.go-mockery
      pkgs.unstable.gofumpt
      pkgs.unstable.golangci-lint
      pkgs.unstable.golines
      pkgs.unstable.gomodifytags
      pkgs.unstable.gopls
      pkgs.unstable.gotests
      pkgs.unstable.gotestsum
      pkgs.unstable.gotools
      pkgs.unstable.govulncheck
      pkgs.unstable.protoc-gen-go
      pkgs.unstable.protoc-gen-go-grpc
    ];
  };
}
