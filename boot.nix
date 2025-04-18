{ config, pkgs, lib, ... }:

{
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages             = with config.boot.kernelPackages; [
    evdi
  ];
}
