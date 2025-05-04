# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, hostUsers,... }:

let

in {
  system.stateVersion              = "24.11";
  virtualisation.libvirtd.enable   = true;
  virtualisation.containers.enable = true;
  virtualisation.podman.enable     = true;
  virtualisation.docker.enable     = true;

  # Power management (for better battery life)
  powerManagement.enable   = true;
  services.thermald.enable = true;

  programs.nix-ld.enable = false;
  programs.nix-ld.dev.enable = false;
  programs.zsh.enable = true;

  users.users = lib.mapAttrs (username: userData: {
    isNormalUser = true;
    shell        = pkgs.zsh;
    description  = userData.fullName;
    home         = userData.homeDir;
    extraGroups  = userData.extraGroups;
  }) hostUsers;

  home-manager = {
    users = lib.mapAttrs (username: userData: import ./home-manager {
      inherit pkgs lib config;
      userData = userData;
    }) hostUsers;
  };

  environment.extraOutputsToInstall = [ "dev" ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store   = true;
    gc = {
      automatic = true;
      dates     = "daily";
      options   = "--delete-older-than 10d";
    };
  };

  # List services that you want to enable:
  services = {
    fwupd.enable    = true;
    cron.enable     = true;
    flatpak.enable  = true;
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
  };
}
