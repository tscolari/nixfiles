# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, hostUsers,... }:

let

in {
  system.stateVersion = "24.11";
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  powerManagement.enable = true;

  programs.nix-ld.dev.enable = false;
  programs.zsh.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
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

  environment.extraOutputsToInstall = [ "dev" ];

  # Experimental features
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # List services that you want to enable:
  services = {
    fwupd.enable    = true;
    cron.enable     = true;
    flatpak.enable  = true;
    # Enable CUPS to print documents.
    printing.enable = true;

    avahi = {
      enable            = true;
      nssmdns4          = true;
      openFirewall      = true;
    };

    libinput = {
      enable            = true;
      touchpad.tapping  = true;
    };

    pipewire = {
      enable            = true;
      alsa.enable       = true;
      alsa.support32Bit = true;
      pulse.enable      = true;
    };
  };
}
