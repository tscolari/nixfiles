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
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.gsconnect
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
      pkgs.gnome.cheese
      pkgs.gaphor
      pkgs.gjs
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
      ];
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

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };

    "org/gnome/desktop/input-sources" = {
      xkb-options = ["terminate:ctrl_alt_bksp" "caps:ctrl_modifier"];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Yaru-blue-dark";
    };

    "org/gnome/shell/extensions/materialshell/theme" = {
      primary-color = "#125e48";
      panel-opacity = 90;
    };

    "org/gnome/desktop/wm/preferences" = {
      action-double-click-titlebar = "toggle-maximize";
      button-layout = "appmenu:minimize,maximize,close";
    };

    # San Francisco, New York and Sao Paulo
    "org/gnome/shell/world-clocks" = {
      locations = [
        "<(uint32 2, <('San Francisco', 'KOAK', true, [(0.65832848982162007, -2.133408063190589)], [(0.659296885757089, -2.1366218601153339)])>)>"
        "<(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>" 
        "<(uint32 2, <('São Paulo', 'SBMT', true, [(-0.41044326824509736, -0.8139052020289248)], [(-0.41073414481823473, -0.81361432545578749)])>)>"
      ];
    };
    "org/gnome/clocks" = {
      world-clocks = "[{'location': <(uint32 2, <('San Francisco', 'KOAK', true, [(0.65832848982162007, -2.133408063190589)], [(0.659296885757089, -2.1366218601153339)])>)>}, {'location': <(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>}, {'location': <(uint32 2, <('São Paulo', 'SBMT', true, [(-0.41044326824509736, -0.8139052020289248)], [(-0.41073414481823473, -0.81361432545578749)])>)>}]";
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };

    "org/gnome/mutter/keybindings" = {
      maximize           = "disabled";

      toggle-tiled-left  = ["<Control><Alt><Super>h" "<Super>h"];
      toggle-tiled-right = ["<Control><Alt><Super>l" "<Super>l"];
    };

    "org/gnome/desktop/wm/keybindings" = {
      minimize          = ["<Control><Alt><Super>Escape" "<Shift><Control>Escape"];
      close             = ["<Control>q" "<Alt>F4"];
      toggle-maximized  = ["<Super>Up" "<Control><Alt><Super>k"];
      toggle-fullscreen = ["<Control><Super>Up"];

      panel-run-dialog  = ["<Alt>F2" "<Super>Return"];

      switch-to-workspace-left  = ["<Control><Super>Left"];
      switch-to-workspace-right = ["<Control><Super>Right"];
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
        prev-entry = ["<Shift><Control><Alt>v"];
        next-entry = ["<Control><Alt>v"];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = ["Utilities" "YaST" "9e712e76-1fc1-4d87-967c-b11c354c30de" "bb8a26da-094e-48ec-9a8e-a287975d57f9" "44608531-532a-4d8d-b0b7-cae603cd2875"];
    };

    "org/gnome/desktop/app-folders/folders/9e712e76-1fc1-4d87-967c-b11c354c30de" = {
      name = "Reading";
      apps = ["calibre-gui.desktop" "org.gnome.TextEditor.desktop" "calibre-ebook-viewer.desktop" "calibre-ebook-edit.desktop" "calibre-lrfviewer.desktop"];
    };

    "org/gnome/desktop/app-folders/folders/bb8a26da-094e-48ec-9a8e-a287975d57f9" = {
      name = "Work/Dev";
      apps = ["nvim.desktop" "slack.desktop" "htop.desktop" "Zoom.desktop" "xterm.desktop"];
    };

    "org/gnome/desktop/app-folders/folders/44608531-532a-4d8d-b0b7-cae603cd2875" = {
      name = "Messaging";
      apps = ["io.github.mimbrero.WhatsAppDesktop.desktop" "skypeforlinux.desktop" "discord.desktop" "slack.desktop"];
    };

  };
}
