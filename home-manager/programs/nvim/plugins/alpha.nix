{ config, lib, pkgs, ... }@args:

let

in {
  programs.nixvim.plugins = {
    alpha = {
      theme = "dashboard";
    };
  };
}
