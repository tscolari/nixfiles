{ config, lib, pkgs, ... }@args:

{
  imports = [
    ./autocmds.nix
    ./dependencies.nix
    ./globals.nix
    ./keyboard.nix
    ./lsp.nix
    ./options.nix
    ./plugins
    ./spelling.nix
  ];


  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias  = true;
    vimAlias = true;

    performance = {
      byteCompileLua.enable  = true;
      byteCompileLua.plugins = false;
      combinePlugins.enable = false;
    };
  };
}
