{ config, lib, pkgs, ... }@args:

{
  imports = [
    ./dependencies.nix
    ./plugins
  ];

}
