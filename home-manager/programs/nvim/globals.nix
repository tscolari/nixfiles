{ config, ... }:

{
  programs.nixvim = {
    globals = {
      # Disable some in built plugins completely
      loaded_netrwPlugin = 1;
      loaded_2html_plugin = 1;
      loaded_getscriptPlugin = 1;
      loaded_logipat = 1;
      loaded_rrhelper = 1;
      loaded_vimballPlugin = 1;

      mapleader = " ";
      auto_save = false;
      extra_whitespace_ignored_filetypes = [ "alpha" ];
      do_filetype_lua = 1;
      "incsearch#auto_nohlsearch" = 0;

      vsnip_snippet_dirs = [
        "${config.xdg.configHome}/snippets"
        "${config.xdg.configHome}/lua/user/snippets"
      ];
    };
  };
}
