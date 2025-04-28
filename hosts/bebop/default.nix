{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:

{
  imports = [
      ./custom.nix
      ./generated.nix
      ./vanta.nix
      ./wififix.nix
    ];

}
