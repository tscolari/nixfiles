# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, nixos-hardware, pkgs, unstable, home-manager, lib, ... }:

let

  # unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      <home-manager/nixos>
      <nix-ld/modules/nix-ld.nix>

      ./ergodox.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = ["kvm-intel"];
  virtualisation.libvirtd.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    evdi
  ];

  networking.hostName = "bebop";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  services.automatic-timezoned.enable = true;

  services.tailscale = {
    enable = false;
    useRoutingFeatures = "client";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

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
  environment.gnome.excludePackages = (with unstable; [
    gnome-photos
    gnome-tour
  ]) ++ (with unstable; [
    gnome-music
    tali
    iagno
    hitori
    atomix
    gnome-contacts
    gnome-initial-setup
  ]) ++ (with unstable; [
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    unstable.displaylink

    dolphin
    wofi

    awscli2
    bat
    calibre
    cargo
    cmake
    consul
    ctags
    curl
    direnv
    fasd
    fd
    flatpak
    unstable.fzf
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
    unstable.neovim
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

  virtualisation.docker.enable = true;

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

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
