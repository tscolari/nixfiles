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
      ./programs/coding.nix
      ./programs/common.nix
      ./programs/comms.nix
      ./programs/git.nix
      ./programs/tmux.nix
      ./programs/vim.nix
      ./shell
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
      stateVersion = "23.11";

      # Files and remote configurations
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
