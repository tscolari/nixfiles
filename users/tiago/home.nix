{ config, pkgs, ... }:

let

  inherit (import <home-manager/nixos> {}) home-manager;

  homeDir = "/home/tscolari";

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  imports =
    [
      ./alacritty.nix
      ./zsh.nix
      ./git.nix
      ./tmux.nix
    ];

  home-manager.users.tscolari = {

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.homeDirectory = homeDir;
    home.username = "tscolari";

    # Packages that should be installed to the user profile.

    home.packages = [
     # pkgs.git-duet
     # pkgs.jsonpp
     # pkgs.pyenv

    # Desktop packages
      pkgs._1password-gui
      pkgs.alacritty
      pkgs.arc-icon-theme
      pkgs.arc-theme
      pkgs.chromium
      pkgs.flat-remix-gnome
      pkgs.flat-remix-gtk
      pkgs.flat-remix-icon-theme
      pkgs.gnome.gnome-tweaks
      pkgs.numix-cursor-theme
      pkgs.numix-gtk-theme
      pkgs.numix-icon-theme
      pkgs.papirus-icon-theme
      pkgs.steam
      pkgs.transmission
      pkgs.xclip
      pkgs.yaru-theme
      pkgs.slack
      pkgs.zoom-us
     # pkgs.gnome.extension-manager

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

    # Gnome apps
      pkgs.shortwave
    ];

    # Gnome
    gtk = {
      enable = true;

      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
       name = "Numix-Cursor-Light";
       package = pkgs.numix-cursor-theme;
        size = 35;
      };

      theme = {
        name = "Arc-Dark";
        package = pkgs.arc-theme;
      };
    };

    dconf.settings = {

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;

        favorite-apps = [
          "firefox.desktop"
          "Alacritty.desktop"
          "org.gnome.Calendar.desktop"
          "org.gnome.Nautilus.desktop"
        ];


        enable-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "trayIconsReloaded@selfmade.pl"
          "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
          "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
          "clipboard-indicator@tudmotu.com"
          "openweather-extension@jenslody.de"
          "dash-to-dock@micxgx.gmail.com"
          "sound-output-device-chooser@kgshank.net"
          "custom-hot-corners-extended@G-dH.github.com"
          "Vitals@CoreCoding.com"
          "stocks@infinicode.de"
          "nightthemeswitcher@romainvigier.fr"
        ];
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "Yaru-blue-dark";
      };

     "org/gnome/shell/extensions/clipboard-indicator" = {
       prev-entry = "['<Shift><Super>v']";
       next-entry = "['<Shift><Control><Super>v']";
     };

      "org/gnome/desktop/interface" = {
        "color-scheme" = "default";
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file://${homeDir}/.background.jpg";
        picture-uri-dark = "file://${homeDir}/.background.jpg";
        picture-options = "zoom";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "file://${homeDir}/.background.jpg";
        picture-options = "zoom";
      };

      "org/gnome/desktop/wm/preferences" = {
        action-double-click-titlebar = "toggle-maximize";
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = "true";
      };

      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left  = "['<Control><Alt><Super>h']";
        toggle-tiled-right = "['<Control><Alt><Super>l']";
        maximize           = "['<Control><Alt><Super>k']";
      };
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "22.11";

    # Files and remote configurations
    home.file = {
      # Neovim
      "${homeDir}/.config/nvim".source = builtins.fetchGit {
        # url = "git@github.com:tscolari/nvim";
        url = "https://github.com/tscolari/nvim";
        submodules = true;
        shallow = true;
        ref = "main";
      };
      "${homeDir}/.local/dotfiles/nvim/plugin/.empty".source = ./files/empty;
      "${homeDir}/.local/dotfiles/nvim/user/.empty".source = ./files/empty;

      # Zsh
      "${homeDir}/.config/zsh/config.zsh".source = ./files/zsh/config.zsh;

      # Misc
      "${homeDir}/.background.jpg".source = ./files/background.jpg;
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 1800;
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # FZF
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.direnv = {
      enable = true;
    };

    # NEOVIM
    programs.neovim = {
      enable = true;

      viAlias       = true;
      vimAlias      = true;

      package = unstable.neovim.unwrapped;

      extraPackages = [
        unstable.rnix-lsp
        unstable.terraform-ls
        unstable.nodePackages.eslint
        unstable.lua-language-server
      ];
    };
  };

  environment.sessionVariables = rec {
    PATH   = "$HOME/.local/bin:$GOPATH/bin:$PATH";
    EDITOR = "vim";
    VISUAL = "vim";

    GREP_COLOR = "1;33";

    GIT_DUET_GLOBAL        = "true";
    GIT_DUET_ROTATE_AUTHOR = "1";

    GOPATH      = "$HOME/go";
    GO111MODULE = "on";
    GOPRIVATE   = "github.com/hashicorp";
  };

}
