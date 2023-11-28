# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {
  imports =
    [
      # Include the results of the hardware scan.
      # <nixos-hardware/dell/xps/13-9300>
      ./hardware-configuration.nix

      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bebop";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

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

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkbOptions = "caps:ctrl_modifier";

    # Disable automatic login for the user.
    displayManager.autoLogin.enable = false;
    displayManager.autoLogin.user = "tscolari";

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
    dpi = 192;

    # tap to click
    libinput = {
      enable = true;
      touchpad.tapping = true;
    };
  };

  services.flatpak.enable = true;

  # Gnome configurations
  services.gnome.gnome-browser-connector.enable = true;
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    epiphany
    geary
    tali
    iagno
    hitori
    atomix
    yelp
    gnome-contacts
    gnome-initial-setup
  ]);

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" "docker" ];
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
    firefox
    flatpak
    fzf
    gcc
    git
    git-crypt
    gnome.mutter
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
    pinentry
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

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
