{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./catppuccin.nix
    ./gnome.nix
    ./packages.nix
    ./xserver.nix
  ];

  # Sound
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome
    ];
  };

  services.flatpak = {
    enable = true;
    packages = [ "us.zoom.Zoom" ];
    update.auto.enable = false;
    uninstallUnmanaged = false;
  };

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gnome3;
}
