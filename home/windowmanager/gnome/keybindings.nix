{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["terminate:ctrl_alt_bksp" "caps:ctrl_modifier"];
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
  };
}
