{ config, ... }:
{
  programs.nixvim = {
    globals = {
      "incsearch#auto_nohlsearch" = 0;

      vsnip_snippet_dirs = [
        "${config.xdg.configHome}/snippets"
        "${config.xdg.configHome}/lua/user/snippets"
      ];

      # Blankline
      indent_blankline_char = "▏";
      indent_blankline_filetype_exclude = [
        "help"
        "terminal"
        "dashboard"
        "nofile"
      ];
      indent_blankline_buftype_exclude = [ "terminal" ];
      indent_blankline_show_trailing_blankline_indent = false;
      indent_blankline_show_first_indent_level = false;

      # Grepper
      grepper = {
        tools = [
          "rg"
          "git"
        ];
        simple_prompt = 0;
        prompt_mapping_tool = "<F10>";
        prompt_mapping_dir = "<F11>";
        prompt_mapping_side = "<F12>";
      };
    };
  };
}
