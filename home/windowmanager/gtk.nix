{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {
  home = {
    packages = [
      unstable.ant-bloody-theme
      unstable.arc-icon-theme
      unstable.arc-theme
      unstable.flat-remix-gnome
      unstable.flat-remix-gtk
      unstable.flat-remix-icon-theme
      unstable.fluent-gtk-theme
      unstable.fluent-icon-theme
      unstable.graphite-gtk-theme
      unstable.numix-cursor-theme
      unstable.numix-gtk-theme
      unstable.numix-icon-theme
      unstable.papirus-icon-theme
      unstable.yaru-theme
    ];
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus";
      package = unstable.papirus-icon-theme;
    };

    cursorTheme = {
     name = "Numix-Cursor-Light";
     package = unstable.numix-cursor-theme;
      size = 35;
    };

    theme = {
      name = "Arc-Dark";
      package = unstable.arc-theme;
    };
  };
}
