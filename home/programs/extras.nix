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
      pkgs._1password-gui
      pkgs.blanket
      pkgs.chromium
      pkgs.firefox
      pkgs.gnome.polari
      pkgs.shortwave
      pkgs.spotify
      pkgs.transmission
      pkgs.trilium-desktop

    # Game
      pkgs.steam

    # Video
      pkgs.skypeforlinux
    ];

  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
