{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.kernelModules = [
    "atkbd"
    "i8042"
    "kvm-intel"
  ];

  boot.initrd.kernelModules = [
    "atkbd"
    "i8042"
  ];

  boot.initrd.availableKernelModules = [
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

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableAllFirmware = true;

  powerManagement.cpuFreqGovernor = "powersave";

  boot.kernelParams = [ "mem_sleep_default=deep" ];

  console.keyMap = "us";
}
