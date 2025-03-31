{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./coding.nix
      ./common.nix
      ./git.nix
      ./go.nix
      ./vim.nix
      ./tmux.nix
    ];

}
