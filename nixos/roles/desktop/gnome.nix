{ config, pkgs, lib, ... }:

{
  # Gnome configurations
  services.gnome.gnome-browser-connector.enable = true;
  services.gnome.core-utilities.enable = true;
  programs.dconf.enable = true;
  environment.gnome.excludePackages = (with pkgs.unstable; [
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

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
