{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./packages.nix
      ./git.nix
      ./vim.nix
      ./tmux.nix
    ];

}
