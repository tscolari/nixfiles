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

  # /games auto-unlock.
  #
  # generated.nix lists /games in the initrd LUKS set, which makes it prompt
  # for a second passphrase at boot. Instead, unlock it *after* the root is
  # mounted, using a keyfile that lives on the encrypted root (so it is itself
  # protected by the root passphrase). Re-declare the initrd LUKS set with
  # mkForce to keep only the root device.
  boot.initrd.luks.devices = lib.mkForce {
    "luks-9e4b1375-4a3b-4f3d-9dd1-e6e9316b8d56".device =
      "/dev/disk/by-uuid/9e4b1375-4a3b-4f3d-9dd1-e6e9316b8d56";
  };

  environment.etc.crypttab.text = ''
    luks-55d31dfc-fdf2-48b7-8fd7-2904808c9211 /dev/disk/by-uuid/55d31dfc-fdf2-48b7-8fd7-2904808c9211 /etc/luks-keys/games.key luks,nofail
  '';

  # Don't block boot if /games can't be unlocked/mounted.
  fileSystems."/games".options = [ "nofail" ];

  console.keyMap = "us";
}
