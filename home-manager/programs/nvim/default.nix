{ config, lib, pkgs, ... }@args:

{
  imports = [
    ./dependencies.nix
    ./lsp.nix
    ./options.nix
    ./plugins
  ];


  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias  = true;
    vimAlias = true;


    globals = {
      mapleader = " ";
      auto_save = false;
      extra_whitespace_ignored_filetypes = ["alpha"];

      # vsnip_snippet_dirs = {CONFIG_PATH .. '/snippets', CONFIG_PATH .. '/lua/user/snippets'}
    };
  };
}
