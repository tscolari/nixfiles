{ config, lib, pkgs, ... }:

let

  homeDir = config.home.homeDirectory;

in {

  home = {
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
      "${homeDir}/.local/dotfiles/nvim/plugin/.empty".source = ../files/empty;
      "${homeDir}/.local/dotfiles/nvim/user/.empty".source = ../files/empty;
    };
  };

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
