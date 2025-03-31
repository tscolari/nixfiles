{ config, pkgs, ... }:

{
  home = {
    packages = [
      pkgs.ant-bloody-theme
      pkgs.arc-icon-theme
      pkgs.arc-theme
      pkgs.flat-remix-gnome
      pkgs.flat-remix-gtk
      pkgs.flat-remix-icon-theme
      pkgs.fluent-gtk-theme
      pkgs.fluent-icon-theme
      pkgs.graphite-gtk-theme
      pkgs.numix-cursor-theme
      pkgs.numix-gtk-theme
      pkgs.numix-icon-theme
      pkgs.papirus-icon-theme
      pkgs.yaru-theme
      pkgs.reversal-icon-theme
      pkgs.zafiro-icons
    ];
  };

  gtk = {
    enable = true;

    cursorTheme = {
     name = "Numix-Cursor";
     package = pkgs.numix-cursor-theme;
      size = 35;
    };

    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  };
}
