{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    # Packages that should be installed to the user profile.
    packages = [
     # pkgs.git-duet
     # pkgs.jsonpp
     # pkgs.pyenv

    # Misc
      pkgs.shortwave
      pkgs._1password-gui
      pkgs.chromium
      pkgs.spotify
      pkgs.transmission

    # Game
      pkgs.steam

    # Chat
      pkgs.slack
      pkgs.discord

    # Video
      pkgs.zoom-us
      pkgs.skypeforlinux
    ];
  };
}
