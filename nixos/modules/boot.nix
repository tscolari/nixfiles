{ config, pkgs, lib, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    evdi
  ];
}
