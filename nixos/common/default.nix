{ config, pkgs, lib, hostUsers,... }:

{
  environment = {
    systemPackages = with pkgs; [
      awscli2
      bat
      calibre
      cargo
      cmake
      consul
      curl
      direnv
      distrobox
      docker
      fasd
      fd
      flatpak
      gcc
      gh
      git
      git-crypt
      glibc
      gnumake
      gnupg
      grpcurl
      gtop
      htop
      jq
      killall
      lm_sensors
      lua
      mutter
      networkmanagerapplet
      nil
      nodePackages.npm
      nodejs
      nomad
      openssl
      openvpn
      pciutils
      pinentry
      pmutils
      podman
      postgresql
      procps
      pstree
      python3
      ripgrep
      ruby
      rustc
      shellcheck
      silver-searcher
      ssh-copy-id
      terraform
      tig
      tmate
      tmux
      tree
      tree-sitter
      unstable.fzf
      unstable.neovim
      unstable.universal-ctags
      unzip
      vanta-agent
      vim
      watch
      wget
      yarn
      zsh
    ];

    shells = with pkgs; [ zsh ];
    variables = {
      EDITOR = "vim";
    };
  };
}
