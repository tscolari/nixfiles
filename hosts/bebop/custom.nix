{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.kernelModules = ["kvm-intel"];
  hardware.enableAllFirmware = true;
}
