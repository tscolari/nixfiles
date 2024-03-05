{ config, pkgs, ... }:

let

  homeDir = config.userData.homeDir;
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    # Files and remote configurations
    file = {
      # Neovim
      "${homeDir}/.config/nvim".source = builtins.fetchGit {
        url = "https://github.com/tscolari/nvim";
        submodules = true;
        shallow = true;
        ref = "main";
        rev = "7eefe7451a409bc1c4e33206797fa5f3b5d6fd0e";
      };
      "${homeDir}/.local/dotfiles/nvim/plugin/.empty".source = ../files/empty;
      "${homeDir}/.local/dotfiles/nvim/user/.empty".source = ../files/empty;
    };

    packages = [
      unstable.lua-language-server
    ];
  };

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
}
