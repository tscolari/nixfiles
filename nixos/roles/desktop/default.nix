{ config, pkgs, lib, ...}:

{
  imports =
    [
      ./gnome.nix
      ./packages.nix
      ./xserver.nix
    ];
}
