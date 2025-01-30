{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    packages = [
      pkgs.pandoc
      unstable.obsidian
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = unstable.fzf;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
