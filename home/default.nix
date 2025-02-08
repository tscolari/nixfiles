{ config, lib, pkgs, ... }@args:

with lib;

let

  cfg = args.userData;

in {

  options = {
    userData = {
      username = mkOption {
        default = "username";
        type = with types; uniq str;
        description = "user's username";
      };

      fullName = mkOption {
        default = "Tiago Scolari";
        type = with types; uniq str;
        description = "full name for the user";
      };

      homeDir = mkOption {
        default = "/home/username";
        type = with types; uniq str;
        description = "user's username";
      };

      accentColor = mkOption {
        default = "blue";
        type = with types; uniq str;
        description = "Gnome's accent color";
      };

      backgroundImage = mkOption {
        default = "background-1.jpg";
        type = with types; uniq str;
        description = "Gnome's background";
      };

      zshTheme = mkOption {
        default = "sorin";
        type = with types; uniq str;
        description = "ZSH Prompt Theme";
      };

      kittyTheme = mkOption {
        default = "Afterglow";
        type = with types; uniq str;
        description = "Kitty Terminal Theme";
      };

      git = {};
    };
  };

  config.userData = cfg;

  imports =
    [
      ./shell
      ./programs
      ./windowmanager
      ./terminal
    ];

  config = {
    home = {
      username = cfg.username;
      homeDirectory = cfg.homeDir;

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      stateVersion = "24.11";

      # Files and remote configurations
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableZshIntegration = true;
      defaultCacheTtl = 1800;
      pinentryPackage = pkgs.pinentry-curses;
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
