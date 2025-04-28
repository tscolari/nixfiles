{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:

{
  imports = [
      ./generated.nix
      ./custom.nix
      ./wififix.nix
    ];

}
