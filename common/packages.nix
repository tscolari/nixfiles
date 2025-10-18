{ pkgs, ... }:

let

  gcloud = pkgs.google-cloud-sdk.withExtraComponents [
    pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ];

in
{
  go = with pkgs; [
    mockgen
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
  ];

  common = with pkgs; [
    # ============================================================================
    # CORE PROGRAMMING LANGUAGES & RUNTIMES
    # ============================================================================
    bash
    zsh
    delve
    nodejs
    nodePackages.npm
    yarn
    python3
    (hiPrio ruby)
    lua
    cargo
    rustc

    # ============================================================================
    # BUILD & COMPILATION TOOLS
    # ============================================================================
    gcc
    glibc
    cmake
    gnumake
    tree-sitter

    # ============================================================================
    # VERSION CONTROL
    # ============================================================================
    git
    git-crypt
    gh
    hub
    tig

    # ============================================================================
    # CODE QUALITY & LINTING
    # ============================================================================
    shellcheck
    nil

    # ============================================================================
    # CONTAINERS & ORCHESTRATION
    # ============================================================================
    docker
    docker-compose
    podman
    kubernetes
    kubectl
    kubectx
    kind
    minikube
    helmfile
    cilium-cli

    (wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-diff
      ];
    })

    # ============================================================================
    # CLOUD PLATFORMS & SERVICES
    # ============================================================================
    awscli2
    gcloud
    cloudflared
    unstable.fly

    # ============================================================================
    # INFRASTRUCTURE AS CODE
    # ============================================================================
    terraform
    pulumi
    pulumiPackages.pulumi-go

    # ============================================================================
    # SERVICE MESH & MICROSERVICES
    # ============================================================================
    dapr-cli
    diagridcli

    # ============================================================================
    # DATABASES & DATA TOOLS
    # ============================================================================
    postgresql
    mysql-client
    pgcli
    redpanda-client

    # ============================================================================
    # NETWORKING TOOLS
    # ============================================================================
    curl
    wget
    dig
    socat
    grpcurl
    openvpn

    # ============================================================================
    # SECURITY & SECRETS MANAGEMENT
    # ============================================================================
    gnupg
    openssl
    libsecret
    p11-kit
    ssh-copy-id

    # ============================================================================
    # FILE & TEXT PROCESSING
    # ============================================================================
    bat
    fd
    ripgrep
    silver-searcher
    jq
    unstable.yq
    tree
    unzip
    unstable.fzf

    # ============================================================================
    # SYSTEM MONITORING & PROCESS MANAGEMENT
    # ============================================================================
    htop
    gtop
    lsof
    procps
    pstree
    killall
    lm_sensors
    sysprof
    watch
    pmutils
    pciutils

    # ============================================================================
    # TERMINAL MULTIPLEXERS & SESSION MANAGEMENT
    # ============================================================================
    tmux
    screen
    tmate
    concurrently

    # ============================================================================
    # EDITORS & DEVELOPMENT ENVIRONMENT
    # ============================================================================
    unstable.neovim
    unstable.universal-ctags
    direnv

    # ============================================================================
    # PROTOCOL BUFFERS & API TOOLS
    # ============================================================================
    protobuf
    unstable.protoc-gen-go
    unstable.protoc-gen-go-grpc
    unstable.buf
    jwt-cli

    # ============================================================================
    # NAVIGATION & PRODUCTIVITY
    # ============================================================================
    fasd
    nix-index

    # ============================================================================
    # SPECIALIZED UTILITIES & MISCELLANEOUS
    # ============================================================================
    calibre
    master.claude-code
    distrobox
    helium
    lyrebird
    mutter
    networkmanagerapplet
  ];

  gui = with pkgs; [
    # ============================================================================
    # WEB BROWSERS
    # ============================================================================
    chromium
    unstable.firefox

    # ============================================================================
    # PRODUCTIVITY & PASSWORD MANAGEMENT
    # ============================================================================
    _1password-gui # Password manager and secure vault

    # ============================================================================
    # WRITING & DOCUMENT TOOLS
    # ============================================================================
    apostrophe # Distraction-free Markdown editor for GNOME
    pandoc # Universal document converter
    blueprint-compiler # GTK UI markup language compiler

    # ============================================================================
    # NOTE-TAKING & KNOWLEDGE MANAGEMENT
    # ============================================================================
    trilium-desktop # Hierarchical note-taking with rich features
    unstable.obsidian # Markdown-based knowledge base and note-taking
    calcurse # Terminal-based calendar and scheduling

    # ============================================================================
    # GRAPHICS & IMAGE EDITING
    # ============================================================================
    gimp # Advanced photo editing and manipulation
    pinta # Simple image editor (Paint.NET alternative)
    inkscape-with-extensions # Vector graphics editor
    graphviz # Graph visualization and diagram creation

    # ============================================================================
    # E-BOOKS & READING
    # ============================================================================
    calibre # E-book library management and conversion

    # ============================================================================
    # AUDIO & MULTIMEDIA
    # ============================================================================
    blanket # Ambient sound and noise generator
    pavucontrol # PulseAudio volume control GUI
    shortwave # Internet radio player for GNOME
    unstable.spotify # Music streaming service

    # ============================================================================
    # COMMUNICATION
    # ============================================================================
    discord # Voice, video, and text chat platform
    slack # Team collaboration and messaging
    polari # IRC client for GNOME

    # ============================================================================
    # SYSTEM & HARDWARE CONTROL
    # ============================================================================
    bluez # Bluetooth protocol stack
    cameractrls-gtk4 # Webcam settings and control GUI

    # ============================================================================
    # WAYLAND UTILITIES
    # ============================================================================
    wl-clipboard # Wayland clipboard utilities
    wofi # Wayland-native application launcher

    # ============================================================================
    # DEVELOPMENT TOOLS
    # ============================================================================
    flatpak # Application sandboxing and distribution
    flatpak-builder # Tool for building Flatpak applications
    grpcui # Interactive web UI for gRPC services
    gjs # JavaScript bindings for GNOME apps

    # ============================================================================
    # GAMING & ENTERTAINMENT
    # ============================================================================
    steam # Gaming platform and store

    # ============================================================================
    # FILE SHARING & DOWNLOADS
    # ============================================================================
    transmission_4 # BitTorrent client
  ];

  gnome = with pkgs; [
    gnome-builder
    gnome-settings-daemon
    gnome-tweaks
    pinentry-gnome3
    gnome.gvfs

    # Themes
    arc-icon-theme
    arc-theme
    flat-remix-icon-theme
    fluent-icon-theme
    (pkgs.graphite-gtk-theme.override {
      colorVariants = [
        "light"
        "dark"
      ];
      themeVariants = [
        "default"
        "purple"
        "blue"
        "red"
      ];
      sizeVariants = [ "standard" ];
      tweaks = [ "rimless" ];
    })
    numix-cursor-theme
    numix-icon-theme
    papirus-icon-theme
    reversal-icon-theme
    zafiro-icons
  ];
}
