{ config, pkgs, lib, ... }:

{
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    videoDrivers = [ "displaylink" "modesetting" ];

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:ctrl_modifier";
    };

    dpi = 192;
  };

  # Disable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
}
