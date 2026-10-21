{ lib, ... }:

{
  console.keyMap = "us";

  # VMware Tools integration: clipboard, dynamic resolution, host/guest
  # time sync. headless = false keeps clipboard sharing while the VM runs
  # in Fusion's own window.
  virtualisation.vmware.guest = {
    enable = true;
    headless = false;
  };

  # Rosetta-backed x86_64 support, instead of the slow QEMU user-mode path.
  # `emulatedSystems` makes nixpkgs auto-register "x86_64-linux" in
  # boot.binfmt.registrations with the correct magic/mask and a QEMU
  # interpreter at `mkDefault` priority; overriding just `interpreter` below
  # swaps QEMU for Rosetta without touching the magic/mask nixpkgs already
  # gets right.
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
  boot.binfmt.registrations.x86_64-linux = {
    interpreter = "/run/rosetta/rosetta";
    fixBinary = true;
  };

  # VERIFY FIRST BOOT: this is the Apple Virtualization.framework convention
  # (same tag UTM/Lima/Tart use) — Fusion's Apple Silicon Linux backend runs
  # on that framework too, but this tag/path is unconfirmed against Fusion's
  # own docs. If `/run/rosetta/rosetta` doesn't appear after boot, check
  # Fusion's VM settings for a Rosetta toggle and `mount | grep -i virtiofs`
  # in the guest to find the actual tag, then update `device` below.
  fileSystems."/run/rosetta" = {
    device = "rosetta";
    fsType = "virtiofs";
    options = [
      "ro"
      "nofail"
    ];
  };
}
