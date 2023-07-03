{ config, pkgs, ... }:

let

  homeDir = "/home/tscolari";

in {

  imports =
    [
      ./packages.nix
      ./gnome.nix
      ./alacritty.nix
      ./zsh.nix
      ./git.nix
      ./tmux.nix
    ];

  home = {
    username = "tscolari";
    homeDirectory = homeDir;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";

    # Files and remote configurations
    file = {
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

    sessionVariables = rec {
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

    package = pkgs.neovim.unwrapped;

    extraPackages = [
      pkgs.rnix-lsp
      pkgs.terraform-ls
      pkgs.nodePackages.eslint
      pkgs.lua-language-server
    ];
  };
}
