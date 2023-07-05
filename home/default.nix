{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.userData;

in {

  imports =
    [
      ./common/packages.nix
      ./common/vim.nix
      ./common/gnome.nix
      ./common/alacritty.nix
      ./common/zsh.nix
      ./common/git.nix
      ./common/tmux.nix
    ];

  options = {
    userData = {
      username = mkOption {
        default = "tscolari";
        type = types.str;
        description = "user's username";
      };

      homeDir = mkOption {
        default = "/home/tscolari";
        type = types.str;
        description = "user's username";
      };
    };
  };

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
      stateVersion = "23.05";

      # Files and remote configurations
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 1800;
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
