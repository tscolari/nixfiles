{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    # Packages that should be installed to the user profile.
    # These are packages that are either not work related or not macos compliant.
    packages = [
      pkgs.slack
      pkgs.discord
      pkgs.zoom-us
    ];
  };
}
