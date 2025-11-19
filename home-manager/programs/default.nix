{
  pkgs,
  ...
}:

let

  gcloud = pkgs.google-cloud-sdk.withExtraComponents [
    pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ];

in
{
  imports = [
    ./git.nix
    ./go.nix
    ./node.nix
    ./nvim
    ./tmux.nix
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.fzf;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  home = {
    packages = with pkgs; [
      awscli2
      bat
      calibre
      cargo
      cloudflared
      cilium-cli
      cmake
      concurrently
      curl
      devenv
      dig
      direnv
      distrobox
      fasd
      fd
      gcc
      gh
      git
      git-crypt
      glibc
      gnumake
      gnupg
      gcloud
      grpcurl
      gtop
      helmfile
      htop
      hub
      jq
      jwt-cli
      killall
      kind
      kubectl
      kubectx
      kubernetes
      libsecret
      lsof
      lua
      lyrebird
      mockgen
      mutter
      mariadb.client
      networkmanagerapplet
      nil
      nix-index
      nodePackages.npm
      nodejs
      openssl
      openvpn
      p11-kit
      pciutils
      pgcli
      pmutils
      podman
      postgresql
      procps
      protobuf
      pstree
      pulumi
      pulumiPackages.pulumi-go
      python3
      redpanda-client
      ripgrep
      (lib.hiPrio ruby)
      rustc
      screen
      shellcheck
      silver-searcher
      socat
      ssh-copy-id
      sysprof
      terraform
      tig
      tmate
      tmux
      tree
      tree-sitter
      unzip
      watch
      wget
      wl-clipboard
      yarn
      zsh
      unstable.buf
      unstable.fly
      master.claude-code
      unstable.fzf
      unstable.delve
      unstable.go
      unstable.go-migrate
      unstable.go-mockery
      unstable.gofumpt
      unstable.golangci-lint
      unstable.golines
      unstable.gomodifytags
      unstable.gopls
      unstable.gotests
      unstable.gotestsum
      unstable.gotools
      unstable.govulncheck
      unstable.protoc-gen-go
      unstable.protoc-gen-go-grpc
      unstable.universal-ctags
      unstable.yq

      # UI
      _1password-gui
      blanket
      calcurse
      calibre
      cameractrls-gtk4
      discord
      flatpak
      gimp
      gjs
      graphviz
      grpcui
      pandoc
      pavucontrol
      polari
      pdfarranger
      shortwave
      transmission_4

      unstable.firefox
      unstable.obsidian
      unstable.spotify
    ];
  };
}
