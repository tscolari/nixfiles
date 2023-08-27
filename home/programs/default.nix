{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./common.nix
      ./git.nix
      ./vim.nix
      ./tmux.nix
    ];

}
