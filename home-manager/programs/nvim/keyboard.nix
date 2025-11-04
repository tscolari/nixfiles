{ ... }:

{
  programs.nixvim = {
    # globals.VM_leader = {
    #   default = "<space>v";
    #   visual = "<space>v";
    #   buffer = "z";
    # };

    extraConfigLua = ''
      -- Visual mode paste that preserves the register
      _G.restore_register = function()
        vim.fn.setreg('"', vim.b.restore_register)
        return ""
      end

      _G.visual_replace = function()
        vim.b.restore_register = vim.fn.getreg('"')
        return vim.api.nvim_replace_termcodes([[p@=v:lua.restore_register()<CR>]], true, true, true)
      end
    '';

    globals.clipboard = {
      name = "wl-clipboard";
      copy = {
        "+" = "wl-copy";
        "*" = "wl-copy";
      };
      paste = {
        "+" = "wl-paste --no-newline";
        "*" = "wl-paste --no-newline";
      };
      cache_enabled = 0;
    };

    keymaps = [
      # File explorer
      {
        mode = "n";
        key = "-";
        action = "<cmd>lua require('lir.float').init()<cr>";
        options.silent = true;
      }

      # Splits
      {
        mode = "n";
        key = "vv";
        action = "<C-w>v";
        options.silent = true;
      }
      {
        mode = "n";
        key = "ss";
        action = "<C-w>s";
        options.silent = true;
      }

      # Code navigation
      {
        mode = "n";
        key = "<leader>.";
        action = "<cmd>GoAlt<cr>";
      }
      {
        mode = "n";
        key = "\\";
        action = "<cmd>noh<return>";
      }

      # Close buffer
      {
        mode = "n";
        key = "<M-q>";
        action = "<cmd>Bdelete<cr>";
        options.silent = true;
      }

      # Diagnostics
      {
        mode = "n";
        key = "<M-p>";
        action = "<cmd>Lspsaga diagnostic_jump_prev<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<M-n>";
        action = "<cmd>Lspsaga diagnostic_jump_next<cr>";
        options.silent = true;
      }

      # Indent/un-indent
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }

      # Don't replace buffer when pasting on visual
      {
        mode = "v";
        key = "p";
        action = ''"_dP'';
      }

      # Save on enter
      {
        mode = "n";
        key = "<CR>";
        action = {
          __raw = ''
            function()
            if vim.api.nvim_eval([[&modified]]) ~= 1 or vim.api.nvim_eval([[&buftype]]) ~= "" then
              return nil
                end
                vim.schedule(function() vim.cmd("write") end)
                end
          '';
        };
        options.expr = true;
      }

      # Save without formatting
      {
        mode = "n";
        key = "<S-CR>";
        action = {
          __raw = ''
            function()
            if vim.api.nvim_eval([[&modified]]) ~= 1 or vim.api.nvim_eval([[&buftype]]) ~= "" then
              return nil
                end
                vim.schedule(function() vim.cmd("noautocmd write") end)
                end
          '';
        };
        options.expr = true;
      }

      # Copy to system clipboard
      {
        mode = "v";
        key = "Y";
        action = ''"+y'';
        options = {
          noremap = true;
          silent = true;
        };
      }

      # Visual mode paste that preserves the register
      {
        mode = "v";
        key = "p";
        action = "v:lua.visual_replace()";
        options = {
          noremap = true;
          silent = true;
          expr = true;
        };
      }

      # Fuzzy finding
      {
        mode = "n";
        key = "<C-p>";
        action = "<cmd>FZFFiles<cr>";
      }

      # Current file's path in command mode
      {
        mode = "c";
        key = "%%";
        action = {
          __raw = "[[expand('%:h').'/']]";
        };
        options.expr = true;
      }

      # Lspsaga scrolling - scroll down
      {
        mode = "n";
        key = "<C-f>";
        action = "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>";
        options.silent = true;
      }

      # Lspsaga scrolling - scroll up
      {
        mode = "n";
        key = "<C-b>";
        action = "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>";
        options.silent = true;
      }

      # Hover documentation
      {
        mode = "n";
        key = "K";
        action = "<cmd>Lspsaga hover_doc<cr>";
        options.silent = true;
      }

      # Testing
      {
        mode = "n";
        key = "]t";
        action = "<Plug>(ultest-next-fail)";
      }
      {
        mode = "n";
        key = "[t";
        action = "<Plug>(ultest-prev-fail)";
      }

      # Search
      {
        mode = "";
        key = "/";
        action = "<Plug>(incsearch-forward)";
        options.noremap = false;
      }
      {
        mode = "";
        key = "?";
        action = "<Plug>(incsearch-backward)";
        options.noremap = false;
      }
      {
        mode = "";
        key = "g/";
        action = "<Plug>(incsearch-stay)";
        options.noremap = false;
      }
      {
        mode = "";
        key = "n";
        action = "<Plug>(incsearch-nohl-n)";
        options.noremap = false;
      }
      {
        mode = "";
        key = "N";
        action = "<Plug>(incsearch-nohl-N)";
        options.noremap = false;
      }
      {
        mode = "";
        key = "*";
        action = "<Plug>(incsearch-nohl-*)";
        options.noremap = false;
      }
      {
        mode = "";
        key = "#";
        action = "<Plug>(incsearch-nohl-#)";
        options.noremap = false;
      }
      {
        mode = "";
        key = "g*";
        action = "<Plug>(incsearch-nohl-g*)";
        options.noremap = false;
      }
      {
        mode = "";
        key = "g#";
        action = "<Plug>(incsearch-nohl-g#)";
        options.noremap = false;
      }
    ];

    plugins.which-key.settings.spec = [
      # Go to mappings
      {
        __unkeyed-1 = "gD";
        __unkeyed-2.__raw = "vim.lsp.buf.declaration";
        desc = "Go to declaration";
      }
      {
        __unkeyed-1 = "gd";
        __unkeyed-2.__raw = "require('telescope.builtin').lsp_definitions";
        desc = "Go to definition";
      }
      {
        __unkeyed-1 = "gy";
        __unkeyed-2.__raw = "vim.lsp.buf.type_definition";
        desc = "Go to type";
      }
      {
        __unkeyed-1 = "gm";
        __unkeyed-2.__raw = "require('telescope.builtin').lsp_implementations";
        desc = "Find implementation";
      }
      {
        __unkeyed-1 = "gh";
        __unkeyed-2 = "<cmd>Lspsaga lsp_finder<cr>";
        desc = "Smart find references/implementation";
      }
      {
        __unkeyed-1 = "gr";
        __unkeyed-2.__raw = "require('telescope.builtin').lsp_references";
        desc = "Find references";
      }
      {
        __unkeyed-1 = "gK";
        __unkeyed-2 = "<cmd>Lspsaga signature_help<cr>";
        desc = "Show signature";
      }
      {
        __unkeyed-1 = "ga";
        __unkeyed-2 = "<Plug>(LiveEasyAlign)";
        desc = "EasyAlign";
        mode = "x";
      }

      # General group
      {
        __unkeyed-1 = "<leader> ";
        group = "general";
      }
      {
        __unkeyed-1 = "<leader> s";
        __unkeyed-2 = "<cmd>Alpha<cr>";
        desc = "Home Buffer";
      }
      {
        __unkeyed-1 = "<leader> c";
        __unkeyed-2.__raw = "require('telescope.builtin').commands";
        desc = "Search commands";
      }
      {
        __unkeyed-1 = "<leader> a";
        __unkeyed-2.__raw = "require('telescope.builtin').colorscheme";
        desc = "Search colorschemes";
      }
      {
        __unkeyed-1 = "<leader> h";
        __unkeyed-2.__raw = "require('telescope.builtin').help_tags";
        desc = "Help";
      }

      # Files group
      {
        __unkeyed-1 = "<leader>f";
        group = "files";
      }
      {
        __unkeyed-1 = "<leader>ff";
        __unkeyed-2.__raw = "require('telescope.builtin').find_files";
        desc = "File Search";
      }
      {
        __unkeyed-1 = "<leader>fo";
        __unkeyed-2.__raw = "require('telescope.builtin').buffers";
        desc = "Buffer Search";
      }
      {
        __unkeyed-1 = "<leader>fm";
        __unkeyed-2.__raw = "require('telescope.builtin').oldfiles";
        desc = "Recent Files";
      }
      {
        __unkeyed-1 = "<leader>f-";
        __unkeyed-2.__raw = ''
          function()
            require('telescope').extensions.file_browser.file_browser({ cwd = '%:h' })
          end
        '';
        desc = "File Browser";
      }
      {
        __unkeyed-1 = "<leader>f.";
        __unkeyed-2 = "<c-^>";
        desc = "Go to last buffer";
      }

      # Git group
      {
        __unkeyed-1 = "<leader>g";
        group = "git";
      }
      {
        __unkeyed-1 = "<leader>gs";
        __unkeyed-2 = "<cmd>Git<cr>";
        desc = "git status";
      }
      {
        __unkeyed-1 = "<leader>gb";
        __unkeyed-2 = "<cmd>Git blame<cr>";
        desc = "git blame";
      }
      {
        __unkeyed-1 = "<leader>gc";
        __unkeyed-2.__raw = "require('telescope.builtin').git_commits";
        desc = "git commits";
      }
      {
        __unkeyed-1 = "<leader>gk";
        __unkeyed-2.__raw = "require('telescope.builtin').git_bcommits";
        desc = "git commits (buffer)";
      }

      # Hunks group
      {
        __unkeyed-1 = "<leader>h";
        group = "hunks";
      }
      {
        __unkeyed-1 = "<leader>ht";
        __unkeyed-2.__raw = "require('vgit').toggle_live_guttter";
        desc = "Toggle live gutter";
      }
      {
        __unkeyed-1 = "<leader>hs";
        __unkeyed-2.__raw = "require('vgit').buffer_hunk_stage";
        desc = "Stage Hunk";
      }
      {
        __unkeyed-1 = "<leader>hp";
        __unkeyed-2.__raw = "require('vgit').buffer_hunk_preview";
        desc = "Preview Hunk";
      }
      {
        __unkeyed-1 = "<leader>hu";
        __unkeyed-2.__raw = "require('vgit').buffer_hunk_reset";
        desc = "Undo Hunk";
      }
      {
        __unkeyed-1 = "<leader>hR";
        __unkeyed-2.__raw = "require('vgit').buffer_unstage";
        desc = "Reset Buffer";
      }
      {
        __unkeyed-1 = "<leader>hl";
        __unkeyed-2.__raw = "require('vgit').buffer_blame_preview";
        desc = "Blame line";
      }
      {
        __unkeyed-1 = "<leader>hb";
        __unkeyed-2.__raw = "require('vgit').toggle_live_blame";
        desc = "Toggle live blame";
      }
      {
        __unkeyed-1 = "<leader>ha";
        __unkeyed-2.__raw = "require('vgit').toggle_authorship_code_lens";
        desc = "Toggle authors";
      }

      # Language server group
      {
        __unkeyed-1 = "<leader>l";
        group = "language-server";
      }
      {
        __unkeyed-1 = "<leader>la";
        __unkeyed-2 = "<cmd>Lspsaga code_action<cr>";
        desc = "Code Action";
      }
      {
        __unkeyed-1 = "<leader>l=";
        __unkeyed-2.__raw = "vim.lsp.buf.formatting_sync";
        desc = "Format";
      }
      {
        __unkeyed-1 = "<leader>lr";
        __unkeyed-2 = "<cmd>Lspsaga rename<cr>";
        desc = "Rename";
      }
      {
        __unkeyed-1 = "<leader>lk";
        __unkeyed-2 = "<cmd>Lspsaga hover_doc<cr>";
        desc = "Doc";
      }
      {
        __unkeyed-1 = "<leader>ls";
        __unkeyed-2.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
        desc = "Search Symbols";
      }
      {
        __unkeyed-1 = "<leader>ld";
        __unkeyed-2 = "<cmd>lua vim.diagnostic.setloclist()<cr>";
        desc = "Diagnostics";
      }
      {
        __unkeyed-1 = "<leader>lD";
        __unkeyed-2 = "<cmd>Trouble diagnostics<cr>";
        desc = "Workspace Diagnostics";
      }
      {
        __unkeyed-1 = "<leader>lt";
        __unkeyed-2 = "<cmd>Vista!!<cr>";
        desc = "Symbol tree";
      }

      # Buffer group
      {
        __unkeyed-1 = "<leader>b";
        group = "buffer";
      }
      {
        __unkeyed-1 = "<leader>bd";
        __unkeyed-2.__raw = ''
          function()
            require('bufdelete').bufdelete(0, true)
          end
        '';
        desc = "Delete Buffer";
      }
      {
        __unkeyed-1 = "<leader>bl";
        __unkeyed-2 = "<cmd>b#<cr>";
        desc = "Last buffer";
      }
      {
        __unkeyed-1 = "<leader>bn";
        __unkeyed-2 = "<cmd>bnext<cr>";
        desc = "Next buffer";
      }
      {
        __unkeyed-1 = "<leader>bp";
        __unkeyed-2 = "<cmd>bprevious<cr>";
        desc = "Previous buffer";
      }
      {
        __unkeyed-1 = "<leader>bs";
        __unkeyed-2.__raw = "require('telescope.builtin').buffers";
        desc = "Search buffers";
      }

      # Search group
      {
        __unkeyed-1 = "<leader>s";
        group = "search";
      }
      {
        __unkeyed-1 = "<leader>sg";
        __unkeyed-2 = "<cmd>Grepper<cr>";
        desc = "Find in directory (quickfix)";
      }
      {
        __unkeyed-1 = "<leader>sf";
        __unkeyed-2.__raw = "require('telescope.builtin').live_grep";
        desc = "Find in directory (live)";
      }
      {
        __unkeyed-1 = "<leader>sl";
        __unkeyed-2 = "<cmd>FZFLines<cr>";
        desc = "Find in open files";
      }
      {
        __unkeyed-1 = "<leader>sb";
        __unkeyed-2.__raw = "require('telescope.builtin').current_buffer_fuzzy_find";
        desc = "Find in buffer";
      }
      {
        __unkeyed-1 = "<leader>sp";
        __unkeyed-2.__raw = "require('spectre').open";
        desc = "Search & Replace";
      }

      # Debug group
      {
        __unkeyed-1 = "<leader>d";
        group = "debug";
      }
      {
        __unkeyed-1 = "<leader>du";
        __unkeyed-2.__raw = "require('dapui').toggle";
        desc = "Debug UI";
      }
      {
        __unkeyed-1 = "<leader>dt";
        __unkeyed-2.__raw = "require('dap-go').debug_test";
        desc = "Debug Test";
      }
      {
        __unkeyed-1 = "<leader>dlt";
        __unkeyed-2.__raw = "require('dap-go').debug_last_test";
        desc = "Debug Last Test";
      }
      {
        __unkeyed-1 = "<leader>dr";
        __unkeyed-2.__raw = "require('dap').restart";
        desc = "Restart";
      }
      {
        __unkeyed-1 = "<leader>dq";
        __unkeyed-2.__raw = "require('dap').close";
        desc = "Quit";
      }
      {
        __unkeyed-1 = "<leader>dd";
        __unkeyed-2 = "<cmd>GoDebug --file<cr>";
        desc = "Display File";
      }
      {
        __unkeyed-1 = "<leader>dc";
        __unkeyed-2.__raw = "require('dap').continue";
        desc = "Continue";
      }
      {
        __unkeyed-1 = "<leader>dn";
        __unkeyed-2.__raw = "require('dap').step_over";
        desc = "Next";
      }
      {
        __unkeyed-1 = "<leader>ds";
        __unkeyed-2.__raw = "require('dap').step_into";
        desc = "Step Into";
      }
      {
        __unkeyed-1 = "<leader>do";
        __unkeyed-2.__raw = "require('dap').step_out";
        desc = "Step Out";
      }
      {
        __unkeyed-1 = "<leader>db";
        __unkeyed-2.__raw = "require('dap').toggle_breakpoint";
        desc = "Toggle Breakpoint";
      }

      # Testing group
      {
        __unkeyed-1 = "<leader>t";
        group = "testing";
      }
      {
        __unkeyed-1 = "<leader>tt";
        __unkeyed-2 = "<cmd>TestNearest<cr>";
        desc = "Run Nearest";
      }
      {
        __unkeyed-1 = "<leader>tf";
        __unkeyed-2 = "<cmd>TestFile<cr>";
        desc = "Run File";
      }
      {
        __unkeyed-1 = "<leader>ts";
        __unkeyed-2 = "<cmd>TestSuite<cr>";
        desc = "Run Suite";
      }
      {
        __unkeyed-1 = "<leader>tg";
        __unkeyed-2 = "<cmd>TestVisit<cr>";
        desc = "Goto last ran test";
      }
      {
        __unkeyed-1 = "<leader>t.";
        __unkeyed-2 = "<cmd>TestLast<cr>";
        desc = "Run Last";
      }
    ];
  };
}
