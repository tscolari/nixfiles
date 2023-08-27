{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./packages.nix
      ./gtk.nix
      ./gnome.nix
    ];

}
