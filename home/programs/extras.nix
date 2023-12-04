{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    # Packages that should be installed to the user profile.
    # These are packages that are either not work related or not macos compliant.
    packages = [
    # Coding
      pkgs.kubernetes
      pkgs.sysprof

    # Misc
      pkgs.shortwave
      pkgs._1password-gui
      pkgs.chromium
      pkgs.spotify
      pkgs.transmission

    # Game
      pkgs.steam

    # Video
      pkgs.skypeforlinux
    ];
  };
}
