{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:

{
  imports = [
      ./custom.nix
      ./generated.nix
      ./hardware.nix
      ./hosts.nix
      ./networking.nix
      ./vanta.nix
    ];

}
