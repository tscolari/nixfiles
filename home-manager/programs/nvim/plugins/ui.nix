{ ... }:

{
  programs.nixvim = {
    colorscheme = "catppuccin-frappe";

    globals = {
      lualine_theme = "catppuccin-frappe";
      config_colorscheme = "catppuccin-frappe";
    };

    extraConfigLua = ''
      -- Setup lir git status
      require('lir.git_status').setup {}

      -- Visual mode settings for lir
      function _G.LirSettings()
        vim.api.nvim_buf_set_keymap(0, 'x', 'J', ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
            { noremap = true, silent = true })
      end
    '';

    plugins = {
      alpha = {
        theme = "startify";
      };

      lualine.settings = {
        options = {
          theme = {
            __raw = "vim.g.lualine_theme";
          };

          section_separators = {
            left = "";
            right = "";
          };
          component_separators = {
            left = "";
            right = "";
          };
        };

        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];
          lualine_c = [
            "filetype"
            {
              __unkeyed-1 = "filename";
              file_status = true;
              path = 1;
            }
          ];
          lualine_x = [
            {
              __unkeyed-1 = "diagnostics";
              sources = [ "nvim_diagnostic" ];
            }
            "encoding"
            "fileformat"
          ];
          lualine_y = [ "progress" ];
        };

        inactive_sections = {
          lualine_a = [ ];
          lualine_b = [ ];
          lualine_c = [
            {
              __unkeyed-1 = "filename";
              file_status = true;
              path = 1;
            }
          ];
          lualine_x = [ "location" ];
          lualine_y = [ ];
          lualine_z = [ ];
        };
      };

      web-devicons.settings = {
        override = {
          lir_folder_icon = {
            icon = "";
            color = "#7ebae4";
            name = "LirFolderNode";
          };
        };
      };

      lir = {
        settings = {
          show_hidden_files = true;
          devicons = {
            enable = true;
          };
          mappings = {
            "<cr>" = {
              __raw = "require('lir.actions').edit";
            };
            "<C-s>" = {
              __raw = "require('lir.actions').split";
            };
            "<C-v>" = {
              __raw = "require('lir.actions').vsplit";
            };
            "<C-t>" = {
              __raw = "require('lir.actions').tabedit";
            };
            "-" = {
              __raw = "require('lir.actions').up";
            };
            "q" = {
              __raw = "require('lir.actions').quit";
            };
            "<Esc>" = {
              __raw = "require('lir.actions').quit";
            };
            "K" = {
              __raw = "require('lir.actions').mkdir";
            };
            "N" = {
              __raw = "require('lir.actions').newfile";
            };
            "R" = {
              __raw = "require('lir.actions').rename";
            };
            "@" = {
              __raw = "require('lir.actions').cd";
            };
            "Y" = {
              __raw = "require('lir.actions').yank_path";
            };
            "." = {
              __raw = "require('lir.actions').toggle_show_hidden";
            };
            "D" = {
              __raw = "require('lir.actions').delete";
            };
            "J" = {
              __raw = ''
                function()
                require('lir.mark.actions').toggle_mark()
                vim.cmd('normal! j')
                end
              '';
            };
            "C" = {
              __raw = "require('lir.clipboard.actions').copy";
            };
            "X" = {
              __raw = "require('lir.clipboard.actions').cut";
            };
            "P" = {
              __raw = "require('lir.clipboard.actions').paste";
            };
          };
          float = {
            winblend = 15;
          };
          hide_cursor = true;
        };
      };
    };

    autoCmd = [
      {
        event = "Filetype";
        pattern = [ "lir" ];
        callback = {
          __raw = "LirSettings";
        };
      }
    ];
  };
}
