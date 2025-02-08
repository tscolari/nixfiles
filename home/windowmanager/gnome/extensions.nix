{ config, pkgs, ... }:

{

  home = {
    packages = [
    # Gnome extensions
      pkgs.gnomeExtensions.clipboard-indicator
      pkgs.gnomeExtensions.custom-hot-corners-extended
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.grand-theft-focus
      pkgs.gnomeExtensions.gsconnect
      pkgs.gnomeExtensions.night-theme-switcher
      pkgs.gnomeExtensions.screenshot-window-sizer
      pkgs.gnomeExtensions.tray-icons-reloaded
      pkgs.gnomeExtensions.user-themes
      pkgs.gnomeExtensions.vitals
      pkgs.gnomeExtensions.windownavigator
    ];
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enable-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
        "custom-hot-corners-extended@G-dH.github.com"
        "quick@web.search"
      ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      "dash-max-icon-size" = "48";
      "multi-monitor"      = true;
    };
  };
}
