{ config, lib, pkgs, ... }@args:

{
  imports = [
      ./coding.nix
      ./common.nix
      ./comms.nix
      ./extras.nix
      ./git.nix
      ./vim.nix
      ./tmux.nix
    ];

}
