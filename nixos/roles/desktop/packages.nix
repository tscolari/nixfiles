{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      _1password-gui
      blanket
      blueprint-compiler
      bluez
      calibre
      cameractrls-gtk4
      chromium
      discord
      dolphin
      unstable.firefox
      flatpak-builder
      gjs
      gimp
      gnome-builder
      gnome-settings-daemon
      gnome-tweaks
      xdg-desktop-portal
      xdg-desktop-portal-gnome
      grpcui
      inkscape-with-extensions
      pandoc
      pavucontrol
      pinta
      polari
      shortwave
      slack
      spotify
      steam
      transmission_4
      trilium-desktop
      unstable.displaylink
      unstable.obsidian
      wofi
      xclip

      ant-bloody-theme
      arc-icon-theme
      arc-theme
      flat-remix-gnome
      flat-remix-gtk
      flat-remix-icon-theme
      fluent-gtk-theme
      fluent-icon-theme
      graphite-gtk-theme
      numix-cursor-theme
      numix-gtk-theme
      numix-icon-theme
      papirus-icon-theme
      yaru-theme
      reversal-icon-theme
      zafiro-icons
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
