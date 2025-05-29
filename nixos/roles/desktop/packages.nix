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
      flatpak-builder
      gimp
      gjs
      gnome-builder
      gnome-settings-daemon
      gnome-tweaks
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
      yubikey-manager-qt

      unstable.displaylink
      unstable.firefox
      unstable.obsidian
      unstable.spotify

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
