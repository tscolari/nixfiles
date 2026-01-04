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
    enable = lib.mkForce true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    configPackages = [ ]; # Clear any conflicting configs
    config = {
      common = {
        default = [ "gtk" ];
      };
      hyprland = {
        default = [ "hyprland" ];
        # Only use Hyprland portal for things it handles well
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
        "org.freedesktop.impl.portal.GlobalShortcuts" = [ "hyprland" ];
        # Explicitly route printing to GTK
        "org.freedesktop.impl.portal.Print" = [ "gtk" ];
      };
    };
  };

  services.flatpak = {
    enable = true;
    packages = [ "us.zoom.Zoom" ];
    update.auto.enable = false;
    uninstallUnmanaged = false;
  };

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gnome3;
}
