{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
      ./hosts.nix
      ./vanta.nix
      ./paths.nix
    ];

}
