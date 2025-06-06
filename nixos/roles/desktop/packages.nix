{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      _1password-gui
      apostrophe
      blanket
      blueprint-compiler
      bluez
      calibre
      cameractrls-gtk4
      chromium
      discord
      flatpak-builder
      flatpak
      gimp
      gjs
      graphviz
      grpcui
      inkscape-with-extensions
      pandoc
      pavucontrol
      pinta
      polari
      shortwave
      slack
      steam
      transmission_4
      trilium-desktop
      wl-clipboard
      wofi

      unstable.displaylink
      unstable.firefox
      unstable.obsidian
      unstable.spotify
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
