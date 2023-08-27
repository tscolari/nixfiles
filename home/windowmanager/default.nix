{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./gtk.nix
      ./gnome
    ];

}
