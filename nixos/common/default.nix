{ config, pkgs, lib, hostUsers,... }:

{
  environment = {
    systemPackages = with pkgs; [
      awscli2
      bat
      calibre
      cargo
      cmake
      concurrently
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
      google-cloud-sdk
      grpcurl
      gtop
      htop
      jq
      killall
      lm_sensors
      lsof
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
      screen
      shellcheck
      silver-searcher
      socat
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
