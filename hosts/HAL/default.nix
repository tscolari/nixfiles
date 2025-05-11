{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:

{
  imports = [
      ./generated.nix
      ./hardware.nix
      ./networking.nix
    ];

}
