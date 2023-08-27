{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./common.nix
      ./extensions.nix
      ./keybindings.nix
    ];

}
