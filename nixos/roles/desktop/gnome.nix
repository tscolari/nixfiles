{ config, pkgs, lib, ... }:

{
  # Gnome configurations
  services = {
    gnome.gnome-browser-connector.enable = true;
    gnome.core-utilities.enable = true;
    gvfs.enable = true;
  };

  programs.dconf.enable = true;

  environment = {
    gnome.excludePackages = (with pkgs.unstable; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.unstable; [
      gnome-music
      tali
      iagno
      hitori
      atomix
      gnome-contacts
      gnome-initial-setup
    ]) ++ (with pkgs.unstable; [
      geary
      yelp
    ]);

    systemPackages = with pkgs; [
      gnome-builder
      gnome-settings-daemon
      gnome-tweaks
      pinentry-gnome3
      gnome.gvfs

      # Themes
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


  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
