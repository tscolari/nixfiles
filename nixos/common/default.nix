{ config, pkgs, lib, hostUsers,... }:

{
  imports = [
    ./appimage.nix
    ./packages.nix
  ];

  environment = {
    shells = with pkgs; [ zsh ];
    variables = {
      EDITOR = "vim";
    };
  };
}
