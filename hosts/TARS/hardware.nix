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
    "i915"
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

  boot.kernelParams = [
    "mem_sleep_default=deep"
    "i915.enable_guc=3" # Enable GuC and HuC firmware loading
    "i915.enable_psr=0" # Disable Panel Self Refresh (causes artifacts)
    "i915.enable_fbc=0" # Disable framebuffer compression
    "i915.fastboot=0" # Disable fastboot to ensure clean init
  ];

  console.keyMap = "us";

  # Intel graphics support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # For Arrow Lake compute
    ];
  };
}
