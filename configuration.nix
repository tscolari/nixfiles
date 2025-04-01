# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, hostUsers,... }:

let

in {
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

  services.libinput = {
    # tap to click
    enable = true;
    touchpad.tapping = true;
  };

  services.flatpak.enable = true;

  programs.nix-ld.dev.enable = false;

  programs.zsh.enable = true;

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

  users.users = lib.mapAttrs (username: userData: {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = userData.fullName;
    home = userData.homeDir;
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" ];
  }) hostUsers;


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = lib.mapAttrs (username: userData: import ./home-manager {
      inherit pkgs lib config;
      userData = userData;
    }) hostUsers;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.extraOutputsToInstall = [ "dev" ];

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
