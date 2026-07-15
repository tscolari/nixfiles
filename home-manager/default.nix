{
  lib,
  pkgs,
  config,
  ...
}@args:

with lib;

let

  cfg = config.userData;
  homenix = args.homenix;

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

  config = lib.mkMerge [
    {
      # Point nixvim at our nixpkgs source tree (not the fully-overlaid
      # `pkgs`) so it still builds against our nixpkgs revision, but without
      # inheriting our overlays - reusing `pkgs` directly causes everything
      # those overlays touch (and their reverse-dependents) to lose their
      # binary-cache match and rebuild from source. This also silences the
      # "nixpkgs.source default value has been affected by your flake input
      # follows" warning.
      programs.nixvim.nixpkgs.source = pkgs.path;

      programs.homenix = {
        enable = true;
        isNixOS = pkgs.stdenv.isLinux;

        hyprland = {
          presetMonitors = [
            homenix.lib.hyprlandMonitors.laptop-home
            homenix.lib.hyprlandMonitors.office
            homenix.lib.hyprlandMonitors.shed
          ];
        };

        firefox_profiles.enable = false;

        git = {
          name = cfg.fullName;
          email = "git@tscolari.me";
          githubUser = "tscolari";
        };

        gnome = {
          accentColor = cfg.accentColor;
          iconTheme = cfg.iconTheme;
          dashApps = cfg.dashApps;
        };
      };

      home = {
        username = cfg.username;
        homeDirectory = cfg.homeDir;
        stateVersion = "26.05";

        packages =
          with pkgs;
          [
            (lib.hiPrio master.claude-code)
          ]
          ++ lib.optionals (!pkgs.stdenv.isLinux) [
            darwin.libresolv
          ];
      };

      services.gpg-agent = {
        enable = false;
        enableSshSupport = false;
        enableZshIntegration = true;
        defaultCacheTtl = 7200;
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    }

    (lib.mkIf pkgs.stdenv.isLinux {
      services.gnome-keyring = {
        enable = true;
        components = [
          "pkcs11"
          "secrets"
          "ssh"
        ];
      };
    })
  ];
}
