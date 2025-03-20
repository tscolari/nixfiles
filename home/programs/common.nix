{ config, pkgs, ... }:

let

in {

  home = {
    packages = [
      pkgs.pandoc
      pkgs.unstable.obsidian
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.fzf;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
