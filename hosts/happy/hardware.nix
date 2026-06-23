{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Ryzen 5 5600X (Zen 3)
  boot.kernelModules = [ "kvm-amd" ];
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableAllFirmware = true;

  # Radeon RX 5600 XT (Navi 10, RDNA1) — load amdgpu early for KMS.
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = lib.mkForce [ "amdgpu" ];

  # Mesa RADV (Vulkan) + radeonsi (OpenGL/VAAPI) come from the default
  # graphics stack; enable32Bit is required for Steam / 32-bit games.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  console.keyMap = "us";
}
