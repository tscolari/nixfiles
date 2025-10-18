{ pkgs, ... }:

let

  packages = import ../../common/packages.nix { inherit pkgs; };

in
{
  home.packages = packages.common ++ packages.gui;
}
