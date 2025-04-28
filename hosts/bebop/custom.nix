{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:
{
  boot.kernelModules = ["kvm-intel"];
  hardware.enableAllFirmware = true;
}
