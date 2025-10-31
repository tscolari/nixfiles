{ ... }:

{
  imports = [
    ./generated.nix
    ./hardware.nix
    ./networking.nix
  ];

  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;
}
