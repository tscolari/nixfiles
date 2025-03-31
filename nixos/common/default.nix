{ config, pkgs, lib, hostUsers,... }:

{
  environment = {
    systemPackages = with pkgs; [
      curl
      docker
      git
      vim
      wget
      zsh
      glibc
      geoclue2
      networkmanagerapplet
      awscli2
      bat
      calibre
      cargo
      cmake
      consul
      pkgs.unstable.universal-ctags
      curl
      direnv
      fasd
      fd
      flatpak
      pkgs.unstable.fzf
      gcc
      git
      git-crypt
      mutter
      gnumake
      gnupg
      grpcurl
      gtop
      htop
      jq
      killall
      lm_sensors
      lua
      pkgs.unstable.neovim
      nodePackages.npm
      nodejs
      nomad
      openssl
      openvpn
      pciutils
      pinentry
      pmutils
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
      unzip
      watch
      yarn
      zsh
    ];

    shells = with pkgs; [ zsh ];
    variables = {
      EDITOR = "vim";
    };
  };
}
