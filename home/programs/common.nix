{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {
    packages = [
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
  };
}
