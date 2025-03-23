# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let


in {
  imports =
    [
      # Include the results of the hardware scan.
      ./boot.nix
      ./networking.nix
      ./localization.nix
      ./hardware-configuration.nix
      ./ergodox.nix
    ];

  system.stateVersion = "24.11";
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  services.fwupd.enable = true;

  services.cron = {
    enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  powerManagement.enable = true;

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    videoDrivers = [ "displaylink" "modesetting" ];

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:ctrl_modifier";
    };

    dpi = 192;
  };

  services.libinput = {
    # tap to click
    enable = true;
    touchpad.tapping = true;
  };

  # Disable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "tscolari";

  services.flatpak.enable = true;

  programs.nix-ld.dev.enable = false;

  programs.zsh.enable = true;

  # Gnome configurations
  services.gnome.gnome-browser-connector.enable = true;
  services.gnome.core-utilities.enable = true;
  programs.dconf.enable = true;
  environment.gnome.excludePackages = (with pkgs.unstable; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.unstable; [
    gnome-music
    tali
    iagno
    hitori
    atomix
    gnome-contacts
    gnome-initial-setup
  ]) ++ (with pkgs.unstable; [
    epiphany
    geary
    yelp
  ]);

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nixpkgs.overlays = [
    (self: super: {
     fcitx-engines = pkgs.fcitx5;
     })
  ];

  users.users.tscolari = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Tiago Scolari";
    extraGroups = [ "networkmanager" "geoclue" "wheel" "docker" "plugdev" ];
  };

  users.users.work = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Tiago Work";
    extraGroups = [ "networkmanager" "geoclue" "wheel" "docker" "plugdev" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.tscolari = import ./home {
      inherit pkgs lib config;
      userData = {
        username = "tscolari";
        fullName = "Tiago Scolari";
        homeDir  = "/home/tscolari";

        backgroundImage = "background-1.jpg";
        accentColor     = "green";
        zshTheme        = "sorin";
        kittyTheme      = "Afterglow";
        iconTheme       = "Zafiro-icons-Dark";

        git = {
          githubUser = "tscolari";
          email = "git@tscolari.me";
        };
      };
    };

    users.work = import ./home {
      inherit pkgs lib config;
      userData = {
        username = "work";
        fullName = "Tiago Work";
        homeDir  = "/home/work";

        backgroundImage = "background-2.jpg";
        accentColor     = "red";
        zshTheme        = "powerlevel10k";
        kittyTheme      = "Jackie_Brown";
        iconTheme       = "Zafiro-icons-Dark";

        git = {
          githubUser = "tscolari";
          email = "git@tscolari.me";
        };
      };
    };
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.extraOutputsToInstall = [ "dev" ];
  environment.systemPackages = with pkgs; [
    curl
    docker
    git
    vim
    wget
    zsh
    glibc

    gnome-settings-daemon
    geoclue2
    networkmanagerapplet
    pkgs.unstable.displaylink

    dolphin
    wofi

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
    # insync
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

  environment.shells = with pkgs; [ zsh ];
  environment.variables = {
    EDITOR = "vim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto-optimise the store
  nix.settings.auto-optimise-store = true;

  # Garbage collection settings
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
