{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./generated.nix
    ./hardware.nix
    ./gaming.nix
  ];

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          leftmeta = "leftalt";
          leftalt = "leftmeta";
        };
      };
    };
  };
}
