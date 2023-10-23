{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./alacritty.nix
      ./kitty.nix
    ];

}
