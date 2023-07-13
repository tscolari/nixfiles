{ config, pkgs, ... }:

let

  homeDir = config.userData.homeDir;

in {

  home = {
    file = {
      "${homeDir}/.background.jpg".source = ../files/background.jpg;
    };

    packages = [
    # Gnome extensions
      pkgs.gnomeExtensions.clipboard-indicator
      pkgs.gnomeExtensions.custom-hot-corners-extended
      pkgs.gnomeExtensions.dash-to-panel
      pkgs.gnomeExtensions.night-theme-switcher
      pkgs.gnomeExtensions.screenshot-window-sizer
      pkgs.gnomeExtensions.stocks-extension
      pkgs.gnomeExtensions.tray-icons-reloaded
      pkgs.gnomeExtensions.user-themes
      pkgs.gnomeExtensions.vitals
      pkgs.gnomeExtensions.windownavigator

    # Gtk themes / icons
      pkgs.ant-bloody-theme
      pkgs.arc-icon-theme
      pkgs.arc-theme
      pkgs.flat-remix-gnome
      pkgs.flat-remix-gtk
      pkgs.flat-remix-icon-theme
      pkgs.fluent-gtk-theme
      pkgs.fluent-icon-theme
      pkgs.graphite-gtk-theme
      pkgs.numix-cursor-theme
      pkgs.numix-gtk-theme
      pkgs.numix-icon-theme
      pkgs.papirus-icon-theme
      pkgs.yaru-theme

    # Misc
      pkgs.gnome.gnome-tweaks
    ];
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
     name = "Numix-Cursor-Light";
     package = pkgs.numix-cursor-theme;
      size = 35;
    };

    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;

      favorite-apps = [
        "firefox.desktop"
        "Alacritty.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Nautilus.desktop"
      ];


      enable-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
        "custom-hot-corners-extended@G-dH.github.com"
        "quick@web.search"
        "nightthemeswitcher@romainvigier.fr"
        # "material-shell@papyelgringo"
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Yaru-blue-dark";
    };

   "org/gnome/shell/extensions/clipboard-indicator" = {
     prev-entry = "['<Shift><Super>v']";
     next-entry = "['<Shift><Control><Super>v']";
   };

    "org/gnome/desktop/interface" = {
      color-scheme       = "prefer-dark";
      enable-hot-corners = true;
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file://${homeDir}/.background.jpg";
      picture-uri-dark = "file://${homeDir}/.background.jpg";
      picture-options = "zoom";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${homeDir}/.background.jpg";
      picture-options = "zoom";
    };

    "org/gnome/desktop/wm/preferences" = {
      action-double-click-titlebar = "toggle-maximize";
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    # San Francisco, New York and Sao Paulo
    "org/gnome/shell/world-clocks" = {
      locations = "[<(uint32 2, <('San Francisco', 'KOAK', true, [(0.65832848982162007, -2.133408063190589)], [(0.659296885757089, -2.1366218601153339)])>)>, <(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>, <(uint32 2, <('São Paulo', 'SBMT', true, [(-0.41044326824509736, -0.8139052020289248)], [(-0.41073414481823473, -0.81361432545578749)])>)>]";
    };
    "org/gnome/clocks" = {
      world-clocks = "[{'location': <(uint32 2, <('San Francisco', 'KOAK', true, [(0.65832848982162007, -2.133408063190589)], [(0.659296885757089, -2.1366218601153339)])>)>}, {'location': <(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>}, {'location': <(uint32 2, <('São Paulo', 'SBMT', true, [(-0.41044326824509736, -0.8139052020289248)], [(-0.41073414481823473, -0.81361432545578749)])>)>}]";
    };

    "org/gnome/mutter/keybindings" = {
      maximize           = "disabled";

      toggle-tiled-left  = ["<Control><Alt><Super>h" "<Super>h" "<Super>Left"];
      toggle-tiled-right = ["<Control><Alt><Super>l" "<Super>l" "<Super>Right"];
    };

    "org/gnome/desktop/wm/keybindings" = {
      minimize          = ["<Super>Down"];
      close             = ["<Control>q" "<Alt>F4"];
      toggle-maximized  = ["<Super>Up" "<Control><Alt><Super>k"];
      toggle-fullscreen = ["<Control><Super>Up"];

      switch-to-workspace-left  = ["<Control><Super>Left"];
      switch-to-workspace-right = ["<Control><Super>Right"];
    };

    "org/gnome/shell/extensions/materialshell/theme" = {
      primary-color = "#125e48";
      panel-opacity = 90;
    };

    "org/gnome/shell/extensions/materialshell/tweaks" = {
      cycle-through-windows = true;
      cycle-through-workspaces = true;
    };
  };
}
