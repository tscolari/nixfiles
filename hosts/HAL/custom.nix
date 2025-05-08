{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:
{

  # AMD graphics and CPU support
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  console.keyMap = "us";

  boot.kernelModules = [ "kvm-amd" "amdgpu" ];
}
