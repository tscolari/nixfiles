{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {
  home = {
    packages = [
      unstable.kitty-themes
      pkgs.pixcat
    ];
  };

  programs.kitty = {
    enable = true;
    package = unstable.kitty;
    themeFile = "Afterglow";
    settings = {

      # Visual
      font_size = "12";
      font_family = "FiraCode Nerd Font Mono";
      window_padding_width = 5;

      # Alerts
      enable_audio_bell = false;
      visual_bell_duration = "0.1";
      window_alert_on_bell = true;
    };

    keybindings = {
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "cmd+c"  = "copy_to_clipboard";
    };
  };

}
