{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      flatpak-builder
    ];
  };
}
