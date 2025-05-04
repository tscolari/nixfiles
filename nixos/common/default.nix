{ config, pkgs, lib, hostUsers,... }:

{
  imports = [
    ./packages.nix
  ];

  environment = {
    shells = with pkgs; [ zsh ];
    variables = {
      EDITOR = "vim";
    };
  };
}
