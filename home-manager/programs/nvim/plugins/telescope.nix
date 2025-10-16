{ ... }:
{
  programs.nixvim.plugins.telescope = {
    settings = {
      defaults = {
        mappings = {
          i = {
            "<C-n>" = {
              __raw = "require('telescope.actions').cycle_history_next";
            };
            "<C-p>" = {
              __raw = "require('telescope.actions').cycle_history_prev";
            };
            "<C-j>" = {
              __raw = "require('telescope.actions').move_selection_next";
            };
            "<C-k>" = {
              __raw = "require('telescope.actions').move_selection_previous";
            };
            "<M-q>" = {
              __raw = "require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist";
            };
            "<C-q>" = {
              __raw = "require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist";
            };
            "<Esc>" = {
              __raw = "require('telescope.actions').close";
            };
          };
        };

        vimgrep_arguments = [
          "rg"
          "--color=never"
          "--no-heading"
          "--with-filename"
          "--line-number"
          "--column"
          "--smart-case"
        ];

        selection_caret = "  ";
        entry_prefix = "  ";
        initial_mode = "insert";
        winblend = 10;
      };
    };

    extensions = {
      fzf-native = {
        settings = {
          fuzzy = true;
          override_generic_sorter = false;
          override_file_sorter = true;
          case_mode = "smart_case";
        };
      };

      file-browser = {
        enable = true;
        settings = {
          theme = "ivy";
          mappings = {
            i = { };
            n = { };
          };
        };
      };
    };
  };
}
