{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    # Packages that should be installed to the user profile.
      packages = [
       # pkgs.git-duet
       # pkgs.jsonpp
       # pkgs.pyenv

      # Misc
        pkgs.shortwave
        pkgs._1password-gui
        pkgs.chromium
        pkgs.spotify
        pkgs.transmission

      # Game
        pkgs.steam

      # Code
        pkgs.xclip
        unstable.alacritty

      # Chat
        pkgs.slack
        pkgs.discord

      # Video
        pkgs.zoom-us
        pkgs.skypeforlinux

      # Gnome extensions
        pkgs.gnomeExtensions.clipboard-indicator
        pkgs.gnomeExtensions.dash-to-panel
        pkgs.gnomeExtensions.openweather
        pkgs.gnomeExtensions.screenshot-window-sizer
        pkgs.gnomeExtensions.sound-output-device-chooser
        pkgs.gnomeExtensions.tray-icons-reloaded
        pkgs.gnomeExtensions.user-themes
        pkgs.gnomeExtensions.windownavigator
        pkgs.gnomeExtensions.custom-hot-corners-extended
        pkgs.gnomeExtensions.vitals
        pkgs.gnomeExtensions.stocks-extension
        pkgs.gnomeExtensions.night-theme-switcher
        pkgs.gnomeExtensions.material-shell

      # Gtk themes / icons
        pkgs.flat-remix-gnome
        pkgs.flat-remix-gtk
        pkgs.flat-remix-icon-theme
        pkgs.numix-cursor-theme
        pkgs.numix-gtk-theme
        pkgs.numix-icon-theme
        pkgs.papirus-icon-theme
        pkgs.arc-icon-theme
        pkgs.arc-theme
        pkgs.yaru-theme

      # Gnome apps
        pkgs.gnome.gnome-tweaks
      ];
  };

  # FZF
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
  };
}
