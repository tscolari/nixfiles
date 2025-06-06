{ config, lib, pkgs, ... }@args:

{
  imports = [
    ./flatpak.nix
    ./git.nix
    ./go.nix
    ./tmux.nix
    ./vim.nix
    ];

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
