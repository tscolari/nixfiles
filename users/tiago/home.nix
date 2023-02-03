{ config, pkgs, ... }:

let

  inherit (import <home-manager/nixos> {}) home-manager;

  homeDir = "/home/tscolari";

in {

  home-manager.users.tscolari = {

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.homeDirectory = homeDir;
    home.username = "tscolari";

    # Packages that should be installed to the user profile.

    home.packages = [
      pkgs._1password
      pkgs.awscli2
      pkgs.bat
      pkgs.cmake
      pkgs.consul
      pkgs.ctags
      pkgs.curl
      pkgs.direnv
      pkgs.fasd
      pkgs.fd
      pkgs.firefox
      pkgs.fzf
      pkgs.gcc
      pkgs.git
      pkgs.git-crypt
      pkgs.gnumake
      pkgs.gnupg
      pkgs.go
      pkgs.gomplate
      pkgs.gopls
      pkgs.grpcurl
      pkgs.gnupg
      pkgs.htop
      pkgs.jq
      pkgs.nodePackages.npm
      pkgs.nodejs
      pkgs.nomad
      pkgs.openssl
      pkgs.pinentry
      pkgs.postgresql
      pkgs.procps
      pkgs.pstree
      pkgs.python3
      pkgs.ripgrep
      pkgs.ruby
      pkgs.rustc
      pkgs.cargo
      pkgs.shellcheck
      pkgs.silver-searcher
      pkgs.ssh-copy-id
      pkgs.terraform
      pkgs.tig
      pkgs.tmate
      pkgs.tmux
      pkgs.tree
      pkgs.tree-sitter
      pkgs.unzip
      pkgs.watch
      pkgs.yarn
      pkgs.zsh
    # Main packages
     # pkgs.git-duet
     # pkgs.jsonpp
     # pkgs.pyenv

    # Desktop packages
      pkgs._1password-gui
      pkgs.alacritty
      pkgs.arc-theme
      pkgs.chromium
      pkgs.flat-remix-gnome
      pkgs.flat-remix-gtk
      pkgs.flat-remix-icon-theme
      pkgs.gnome.gnome-tweaks
      pkgs.numix-gtk-theme
      pkgs.numix-icon-theme
      pkgs.numix-cursor-theme
      pkgs.papirus-icon-theme
      pkgs.xclip
     # pkgs.gnome.extension-manager
     # pkgs.slack
     # pkgs.zoom-us

    # Gnome extensions
      pkgs.gnomeExtensions.clipboard-indicator
      pkgs.gnomeExtensions.dash-to-panel
      pkgs.gnomeExtensions.openweather
      pkgs.gnomeExtensions.screenshot-window-sizer
      pkgs.gnomeExtensions.sound-output-device-chooser
      pkgs.gnomeExtensions.tray-icons-reloaded
      pkgs.gnomeExtensions.user-themes
      pkgs.gnomeExtensions.windownavigator
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
        size = 55;
      };

      theme = {
        name = "Flat-Remix-Cyan-Darkest-fullPanel";
        package = pkgs.numix-gtk-theme;
      };
    };

    dconf.settings = {

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
        ];
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "Flat-Remix-Cyan-Darkest-fullPanel";
      };

      "org/gnome/desktop/interface" = {
        "color-scheme" = "default";
        "cursor-size" = 55;
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
        url = "git@github.com:tscolari/nvim";
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
        pkgs.sumneko-lua-language-server
      ];
    };
  };
}
