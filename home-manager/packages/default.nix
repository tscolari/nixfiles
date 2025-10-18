{ pkgs, ... }:

let

  packages = import ../../common/packages.nix { inherit pkgs; };

in
{
  # These packages are to be included on non-nixos setup only.
  home.packages = [
    pkgs.vimPlugins.catppuccin-nvim
  ]
  ++ packages.common
  ++ packages.gui
  ++ packages.gnome;
}
