{ config, lib, pkgs, ... }@args:

let

  homeDir = config.userData.homeDir;

in {
  home = {
    file = {
      "${homeDir}/.config/zsh/p10k.zsh".source = ./files/p10k.zsh;
    };
  };
}
