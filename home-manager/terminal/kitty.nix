{ config, pkgs, ... }:

let

  theme = config.userData.kittyTheme;

in
{
  home = {
    packages = [
      pkgs.unstable.kitty-themes
      pkgs.pixcat
    ];
  };

  programs.kitty = {
    enable = true;
    package = pkgs.unstable.kitty;
    themeFile = "${theme}";
    settings = {

      # Visual
      font_size = "12";
      font_family = "FiraCode Nerd Font Mono";
      window_padding_width = 2;

      # Alerts
      enable_audio_bell = false;
      visual_bell_duration = "0.1";
      window_alert_on_bell = true;
    };

    keybindings = {
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "cmd+c" = "copy_to_clipboard";
    };
  };

}
