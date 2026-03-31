{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      flatpak-builder
      unstable.synology-drive-client
    ];
  };
}
