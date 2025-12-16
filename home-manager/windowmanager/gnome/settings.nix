{ config, pkgs, ... }:

let

  accentColor = config.userData.accentColor;
  homeDir = config.userData.homeDir;
  iconTheme = config.userData.iconTheme;
  dashApps = config.userData.dashApps;

in
{

  gtk = {
    cursorTheme = {
      name = "Numix-Cursor";
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
      night-light-schedule-automatic = false;
      night-light-schedule-from = 0.01;
      night-light-schedule-to = 0.0;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 3600;
    };

    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
      dynamic-workspaces = true;
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    "org/gnome/desktop/notifications/application" = {
      "firefox/enable" = false;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
      accent-color = "${accentColor}";
      icon-theme = "${iconTheme}";
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
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "caps:ctrl_modifier"
      ];
    };

    "org/gnome/desktop/wm/preferences" = {
      action-double-click-titlebar = "toggle-maximize";
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [
        "Utilities"
        "YaST"
        "9e712e76-1fc1-4d87-967c-b11c354c30de"
        "bb8a26da-094e-48ec-9a8e-a287975d57f9"
        "44608531-532a-4d8d-b0b7-cae603cd2875"
      ];
    };

    "org/gnome/desktop/app-folders/folders/9e712e76-1fc1-4d87-967c-b11c354c30de" = {
      name = "Reading";
      apps = [
        "calibre-gui.desktop"
        "org.gnome.TextEditor.desktop"
        "calibre-ebook-viewer.desktop"
        "calibre-ebook-edit.desktop"
        "calibre-lrfviewer.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/bb8a26da-094e-48ec-9a8e-a287975d57f9" = {
      name = "Work/Dev";
      apps = [
        "nvim.desktop"
        "slack.desktop"
        "htop.desktop"
        "Zoom.desktop"
        "xterm.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/44608531-532a-4d8d-b0b7-cae603cd2875" = {
      name = "Messaging";
      apps = [
        "io.github.mimbrero.WhatsAppDesktop.desktop"
        "discord.desktop"
        "slack.desktop"
      ];
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      disable-extension-version-validation = true;
      favorite-apps = dashApps;
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
  };
}
