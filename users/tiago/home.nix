{ config, pkgs, ... }:

let

  inherit (import <home-manager/nixos> {}) home-manager;

  homeDir = "/home/tscolari";

in {

  imports =
    [
      ./zsh.nix
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
      pkgs.zsh-prezto
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
          "org.gnome.Console.desktop"
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
      "${homeDir}/.local/dotfiles/nvim/user".source = ./files/nvim;

      # Zsh
      "${homeDir}/.zsh.local".source = ./files/zsh;
      "${homeDir}/.zshrc".source = ./files/zsh/zshrc;
      "${homeDir}/.zpreztorc".source = ./files/zsh/zpreztorc;
      "${homeDir}/.zprezto".source = builtins.fetchGit {
        url = "https://github.com/sorin-ionescu/prezto";
        submodules = true;
        shallow = true;
        ref = "master";
      };

      # Tmux
      "${homeDir}/.tmux.conf".source = ./files/tmux.conf;
      "${homeDir}/.tmux/plugins/tpm".source = builtins.fetchGit {
        url = "https://github.com/tmux-plugins/tpm";
        submodules = true;
        shallow = true;
        ref = "master";
      };

      # Git
      "${homeDir}/.gitconfig".source = ./files/gitconfig;

      # Alacritty
      "${homeDir}/.config/alacritty".source = ./files/alacritty;

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

    # TMUX
    programs.tmux = {
      enable = true;
    };

    # GIT
    programs.git = {
      enable = true;
    };

    # FZF
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # NEOVIM
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraPackages = [
        pkgs.rnix-lsp
        pkgs.terraform-ls
        pkgs.nodePackages.eslint
        # pkgs.lua-language-server # unstable only
        pkgs.sumneko-lua-language-server # 22.11
      ];
    };
  };
}
