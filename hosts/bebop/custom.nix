{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = ["kvm-intel"];
  hardware.enableAllFirmware = true;
}
