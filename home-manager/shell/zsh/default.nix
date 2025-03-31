{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./common.nix
      ./env.nix
      ./prezto.nix
      ./aliases.nix
    ];

}

