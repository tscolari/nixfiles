{ config, pkgs, ... }:

{

  home = {
    packages = with pkgs.gnomeExtensions; [
      auto-power-profile
      clipboard-indicator
      custom-hot-corners-extended
      dash-to-dock
      grand-theft-focus
      gsconnect
      night-theme-switcher
      screenshot-window-sizer
      tray-icons-reloaded
      user-themes
      vitals
      window-state-manager
      windownavigator
    ];
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enable-extensions = [
        "auto-power-profile@dmy3k.github.io"
        "clipboard-indicator@tudmotu.com"
        "custom-hot-corners-extended@G-dH.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "grand-theft-focus@zalckos.github.com"
        "quick@web.search"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
      ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      "dash-max-icon-size" = "48";
      "multi-monitor"      = true;
    };

    "org/gnome/shell/extensions/trayIconsReloaded" = {
      tray-margin-left        = 0;
      tray-margin-right       = 0;
      icon-margin-horizontal  = 0;
      icon-padding-horizontal = 2;
      icon-padding-vertical   = 2;
      icons-limit             = 6;
    };

    "org/gnome/shell/extensions/auto-power-profile" = {
      ac        = "performance";
      bat       = "balanced";
      lapmode   = false;
      threshold = 35;
    };
  };
}
