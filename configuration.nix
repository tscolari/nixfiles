# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  lib,
  hostUsers,
  inputs,
  ...
}:

{
  system.stateVersion = "26.05";

  # Mask cups-browsed to prevent automatic printer discovery
  systemd.services.cups-browsed.enable = false;

  virtualisation.libvirtd.enable = true;
  virtualisation.containers.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
    dockerCompat = true;
  };

  # Power management (for better battery life)
  powerManagement.enable = true;
  services.thermald.enable = true;

  programs.zsh.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = lib.mkDefault pkgs.pinentry-curses;
  };

  users.users = lib.mapAttrs (username: userData: {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = userData.fullName;
    home = userData.homeDir;
    extraGroups = userData.extraGroups;
  }) hostUsers;

  home-manager = {
    extraSpecialArgs = {
      catppuccin = inputs.catppuccin;
      homenix = inputs.homenix;
    };

    users = lib.mapAttrs (
      username: userData:
      { ... }@args:
      {
        imports = [
          ./home-manager
          ./home-manager/by-user/${username} # Import here instead
          args.catppuccin.homeModules.catppuccin
        ];

        config.userData = userData; # Pass the userData directly as config
      }
    ) hostUsers;
  };

  security.doas = {
    enable = true;
    extraRules = [
      {
        users = lib.mapAttrsToList (username: userData: username) hostUsers;
        persist = true;
        keepEnv = true;
      }
    ];
  };

  environment.extraOutputsToInstall = [ "dev" ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    settings.auto-optimise-store = true;
    settings.trusted-users = [
      "root"
      "tiagoscolari"
      "tscolari"
    ];
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
    };
  };

  # Scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  environment.etc."sane.d/airscan.conf".text = ''
    [devices]
    EPSON_ET_2860 = http://192.168.5.24:80/WDP/SCAN, WSD

    [options]
    discovery = enable
  '';

  # List services that you want to enable:
  services = {
    fwupd.enable = true;
    cron.enable = true;

    system-config-printer.enable = true;
    printing = {
      enable = true;
      startWhenNeeded = true;
      drivers = [
        pkgs.gutenprint
        pkgs.gutenprintBin
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    libinput = {
      enable = true;
      touchpad.tapping = true;
    };
  };
}
