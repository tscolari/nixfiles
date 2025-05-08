{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:

{
  imports = [
      ./custom.nix
      ./generated.nix
      ./hosts.nix
      ./vanta.nix
      ./wififix.nix
    ];

}
