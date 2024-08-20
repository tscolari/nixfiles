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
      stateVersion = "24.05";

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
