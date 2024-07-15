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
      };
      "${homeDir}/.local/dotfiles/nvim/plugin/.empty".source = ../files/empty;
      "${homeDir}/.local/dotfiles/nvim/user/.empty".source = ../files/empty;
    };

    packages = [
      pkgs.nerdfonts
      pkgs.texliveFull
      pkgs.zathura
      unstable.lua-language-server
    ];
  };

  programs.neovim = {
    enable = true;

    viAlias       = true;
    vimAlias      = true;

    package = unstable.neovim.unwrapped;

    extraPackages = [
      unstable.terraform-ls
      unstable.nodePackages.eslint
      unstable.lua-language-server
    ];
  };
}
