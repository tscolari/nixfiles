{ config, lib, pkgs, ... }@args:

{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      auto_save = false;
      extra_whitespace_ignored_filetypes = ["alpha"];
      do_filetype_lua = 1;

      # vsnip_snippet_dirs = {CONFIG_PATH .. '/snippets', CONFIG_PATH .. '/lua/user/snippets'}
    };
  };
}
