{ pkgs, ... }:
{

  boot.initrd.luks.devices."luks-f5ee542d-4566-494d-8b57-54af183e42f6".device =
    "/dev/disk/by-uuid/f5ee542d-4566-494d-8b57-54af183e42f6";

  boot.kernelModules = [
    # "amdgpu"
    "atkbd"
    "i8042"
    "kvm-amd"
  ];

  boot.initrd.kernelModules = [
    "atkbd"
    "i8042"
  ];

  boot.initrd.availableKernelModules = [
    # "admgpu"
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "atkbd"
    "i8042"
  ];

  boot.extraModprobeConfig = ''
    options i8042 reset=1 nomux=1 poll=1
  '';

  boot.extraModulePackages = [ ];

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # AMD graphics and CPU support
  # services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  console.keyMap = "us";
}
