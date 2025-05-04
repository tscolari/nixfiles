{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./git.nix
      ./go.nix
      ./vim.nix
      ./tmux.nix
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
