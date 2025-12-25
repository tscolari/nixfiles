{
  lib,
  pkgs,
  config,
  ...
}:

with lib;

let

  cfg = config.userData;

in
{

  options.userData = {
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

    iconTheme = mkOption {
      default = "Papirus";
      type = with types; uniq str;
      description = "Gnome's icon theme";
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

    extraGroups = mkOption {
      default = [ ];
    };

    dashApps = mkOption {
      default = [
        "firefox.desktop"
        "kitty.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
  };

  config = {
    programs.homenix = {
      hyprland.enable = true;
      nvim.enable = true;
      packages.enable = true;
      terminals.enable = true;
      tmux.enable = true;
      zsh.enable = true;
      git = {
        enable = true;
        name = cfg.fullName;
        email = "git@tscolari.me";
        githubUser = "tscolari";
      };

      gnome = {
        enable = true;
        accentColor = cfg.accentColor;
        iconTheme = cfg.iconTheme;
        dashApps = cfg.dashApps;
      };
    };

    home = {
      username = cfg.username;
      homeDirectory = cfg.homeDir;
      stateVersion = "25.11";
    };

    services.gpg-agent = {
      enable = false;
      enableSshSupport = false;
      enableZshIntegration = true;
      defaultCacheTtl = 7200;
      pinentry.package = pkgs.pinentry-gnome3;
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    services.gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };
  };
}
