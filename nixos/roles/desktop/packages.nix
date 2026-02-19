{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      flatpak-builder
      master.synology-drive-client
    ];
  };
}
