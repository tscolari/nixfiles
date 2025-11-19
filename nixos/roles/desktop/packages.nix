{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      chromium
      flatpak-builder
      inkscape-with-extensions
      slack
      steam
      unstable.displaylink
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
