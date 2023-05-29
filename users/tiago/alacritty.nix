{ config, pkgs, ... }:

let

  inherit (import <home-manager/nixos> {}) home-manager;

in {

  home-manager.users.tscolari = {
    programs.alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        tabspaces = 8;
        draw_bold_text_with_bright_colors = true;
        font = {
          size = 12.0;
          offset.x = 0;
          offset.y = 0;
        };

        colors = {
          # Default colors
          primary = {
            background = "0x1d1f21";
            foreground = "0xc5c8c6";
          };

          # Normal colors
          normal = {
            black =   "0x282a2e";
            red =     "0xa54242";
            green =   "0x8c9440";
            yellow =  "0xde935f";
            blue =    "0x5f819d";
            magenta = "0x85678f";
            cyan =    "0x5e8d87";
            white =   "0x707880";
          };

          # Bright colors
          bright = {
            black =   "0x373b41";
            red =     "0xcc6666";
            green =   "0xb5bd68";
            yellow =  "0xf0c674";
            blue =    "0x81a2be";
            magenta = "0xb294bb";
            cyan =    "0x8abeb7";
            white =   "0xc5c8c6";
          };
        };

        visual_bell = {
          animation = "EaseOutExpo";
          duration  = 0;
        };

        mouse = {
          double_click = {
            threshold = 300;
          };
          triple_click = {
            threshold = 300;
          };
          hide_when_typing = false;
        };

        selection = {
          semantic_escape_chars = ",│`|:\"' ()[]{}<>";
        };

        live_config_reload = true;
      };
    };
  };
}
