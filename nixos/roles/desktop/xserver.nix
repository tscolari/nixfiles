{
  ...
}:

{
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    videoDrivers = [
      "modesetting"
    ];

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:ctrl_modifier";
    };

    dpi = 192;
  };

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  # Disable automatic login for the user.
  services.displayManager.autoLogin.enable = false;

  systemd.services.dlm.wantedBy = [ "multi-user.target" ];
}
