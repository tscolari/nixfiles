{ config, lib, pkgs, ... }@args:

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
    ];

    plugins.which-key.settings.spec = [
      # Go to mappings
      {
        __unkeyed-1 = "gD";
        action.__raw = "vim.lsp.buf.declaration";
        desc = "Go to declaration";
      }
      {
        __unkeyed-1 = "gd";
        action.__raw = "require('telescope.builtin').lsp_definitions";
        desc = "Go to definition";
      }
      {
        __unkeyed-1 = "gy";
        action.__raw = "vim.lsp.buf.type_definition";
        desc = "Go to type";
      }
      {
        __unkeyed-1 = "gm";
        action.__raw = "require('telescope.builtin').lsp_implementations";
        desc = "Find implementation";
      }
      {
        __unkeyed-1 = "gh";
        action = "<cmd>Lspsaga lsp_finder<cr>";
        desc = "Smart find references/implementation";
      }
      {
        __unkeyed-1 = "gr";
        action.__raw = "require('telescope.builtin').lsp_references";
        desc = "Find references";
      }
      {
        __unkeyed-1 = "gK";
        action = "<cmd>Lspsaga signature_help<cr>";
        desc = "Show signature";
      }
      {
        __unkeyed-1 = "ga";
        action = "<Plug>(LiveEasyAlign)";
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
        action = "<cmd>Alpha<cr>";
        desc = "Home Buffer";
      }
      {
        __unkeyed-1 = "<leader> c";
        action.__raw = "require('telescope.builtin').commands";
        desc = "Search commands";
      }
      {
        __unkeyed-1 = "<leader> a";
        action.__raw = "require('telescope.builtin').colorscheme";
        desc = "Search colorschemes";
      }
      {
        __unkeyed-1 = "<leader> h";
        action.__raw = "require('telescope.builtin').help_tags";
        desc = "Help";
      }

      # Files group
      {
        __unkeyed-1 = "<leader>f";
        group = "files";
      }
      {
        __unkeyed-1 = "<leader>ff";
        action.__raw = "require('telescope.builtin').find_files";
        desc = "File Search";
      }
      {
        __unkeyed-1 = "<leader>fo";
        action.__raw = "require('telescope.builtin').buffers";
        desc = "Buffer Search";
      }
      {
        __unkeyed-1 = "<leader>fm";
        action.__raw = "require('telescope.builtin').oldfiles";
        desc = "Recent Files";
      }
      {
        __unkeyed-1 = "<leader>f-";
        action.__raw = ''
          function()
            require('telescope').extensions.file_browser.file_browser({ cwd = '%:h' })
          end
        '';
        desc = "File Browser";
      }
      {
        __unkeyed-1 = "<leader>f.";
        action = "<c-^>";
        desc = "Go to last buffer";
      }

      # Git group
      {
        __unkeyed-1 = "<leader>g";
        group = "git";
      }
      {
        __unkeyed-1 = "<leader>gs";
        action = "<cmd>Git<cr>";
        desc = "git status";
      }
      {
        __unkeyed-1 = "<leader>gb";
        action = "<cmd>Git blame<cr>";
        desc = "git blame";
      }
      {
        __unkeyed-1 = "<leader>gc";
        action.__raw = "require('telescope.builtin').git_commits";
        desc = "git commits";
      }
      {
        __unkeyed-1 = "<leader>gk";
        action.__raw = "require('telescope.builtin').git_bcommits";
        desc = "git commits (buffer)";
      }

      # Hunks group
      {
        __unkeyed-1 = "<leader>h";
        group = "hunks";
      }
      {
        __unkeyed-1 = "<leader>ht";
        action.__raw = "require('vgit').toggle_live_guttter";
        desc = "Toggle live gutter";
      }
      {
        __unkeyed-1 = "<leader>hs";
        action.__raw = "require('vgit').buffer_hunk_stage";
        desc = "Stage Hunk";
      }
      {
        __unkeyed-1 = "<leader>hp";
        action.__raw = "require('vgit').buffer_hunk_preview";
        desc = "Preview Hunk";
      }
      {
        __unkeyed-1 = "<leader>hu";
        action.__raw = "require('vgit').buffer_hunk_reset";
        desc = "Undo Hunk";
      }
      {
        __unkeyed-1 = "<leader>hR";
        action.__raw = "require('vgit').buffer_unstage";
        desc = "Reset Buffer";
      }
      {
        __unkeyed-1 = "<leader>hl";
        action.__raw = "require('vgit').buffer_blame_preview";
        desc = "Blame line";
      }
      {
        __unkeyed-1 = "<leader>hb";
        action.__raw = "require('vgit').toggle_live_blame";
        desc = "Toggle live blame";
      }
      {
        __unkeyed-1 = "<leader>ha";
        action.__raw = "require('vgit').toggle_authorship_code_lens";
        desc = "Toggle authors";
      }

      # Language server group
      {
        __unkeyed-1 = "<leader>l";
        group = "language-server";
      }
      {
        __unkeyed-1 = "<leader>la";
        action = "<cmd>Lspsaga code_action<cr>";
        desc = "Code Action";
      }
      {
        __unkeyed-1 = "<leader>l=";
        action.__raw = "vim.lsp.buf.formatting_sync";
        desc = "Format";
      }
      {
        __unkeyed-1 = "<leader>lr";
        action = "<cmd>Lspsaga rename<cr>";
        desc = "Rename";
      }
      {
        __unkeyed-1 = "<leader>lk";
        action = "<cmd>Lspsaga hover_doc<cr>";
        desc = "Doc";
      }
      {
        __unkeyed-1 = "<leader>ls";
        action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
        desc = "Search Symbols";
      }
      {
        __unkeyed-1 = "<leader>ld";
        action = "<cmd>lua vim.diagnostic.setloclist()<cr>";
        desc = "Diagnostics";
      }
      {
        __unkeyed-1 = "<leader>lD";
        action = "<cmd>Trouble diagnostics<cr>";
        desc = "Workspace Diagnostics";
      }
      {
        __unkeyed-1 = "<leader>lt";
        action = "<cmd>Vista!!<cr>";
        desc = "Symbol tree";
      }

      # Buffer group
      {
        __unkeyed-1 = "<leader>b";
        group = "buffer";
      }
      {
        __unkeyed-1 = "<leader>bd";
        action.__raw = ''
          function()
            require('bufdelete').bufdelete(0, true)
          end
        '';
        desc = "Delete Buffer";
      }
      {
        __unkeyed-1 = "<leader>bl";
        action = "<cmd>b#<cr>";
        desc = "Last buffer";
      }
      {
        __unkeyed-1 = "<leader>bn";
        action = "<cmd>bnext<cr>";
        desc = "Next buffer";
      }
      {
        __unkeyed-1 = "<leader>bp";
        action = "<cmd>bprevious<cr>";
        desc = "Previous buffer";
      }
      {
        __unkeyed-1 = "<leader>bs";
        action.__raw = "require('telescope.builtin').buffers";
        desc = "Search buffers";
      }

      # Search group
      {
        __unkeyed-1 = "<leader>s";
        group = "search";
      }
      {
        __unkeyed-1 = "<leader>sg";
        action = "<cmd>Grepper<cr>";
        desc = "Find in directory (quickfix)";
      }
      {
        __unkeyed-1 = "<leader>sf";
        action.__raw = "require('telescope.builtin').live_grep";
        desc = "Find in directory (live)";
      }
      {
        __unkeyed-1 = "<leader>sl";
        action = "<cmd>FZFLines<cr>";
        desc = "Find in open files";
      }
      {
        __unkeyed-1 = "<leader>sb";
        action.__raw = "require('telescope.builtin').current_buffer_fuzzy_find";
        desc = "Find in buffer";
      }
      {
        __unkeyed-1 = "<leader>sp";
        action.__raw = "require('spectre').open";
        desc = "Search & Replace";
      }

      # Debug group
      {
        __unkeyed-1 = "<leader>d";
        group = "debug";
      }
      {
        __unkeyed-1 = "<leader>dt";
        action = "<cmd>GoDebug --test<cr>";
        desc = "Debug Test";
      }
      {
        __unkeyed-1 = "<leader>dr";
        action = "<cmd>GoDebug --restart<cr>";
        desc = "Restart";
      }
      {
        __unkeyed-1 = "<leader>dq";
        action = "<cmd>GoDebug --stop<cr>";
        desc = "Quit";
      }
      {
        __unkeyed-1 = "<leader>dd";
        action = "<cmd>GoDebug --file<cr>";
        desc = "Display File";
      }
      {
        __unkeyed-1 = "<leader>dc";
        action.__raw = "require('dap').continue";
        desc = "Continue";
      }
      {
        __unkeyed-1 = "<leader>dn";
        action.__raw = "require('dap').step_over";
        desc = "Next";
      }
      {
        __unkeyed-1 = "<leader>ds";
        action.__raw = "require('dap').step_into";
        desc = "Step Into";
      }
      {
        __unkeyed-1 = "<leader>do";
        action.__raw = "require('dap').step_out";
        desc = "Step Out";
      }
      {
        __unkeyed-1 = "<leader>db";
        action.__raw = "require('dap').toggle_breakpoint";
        desc = "Toggle Breakpoint";
      }

      # Testing group
      {
        __unkeyed-1 = "<leader>t";
        group = "testing";
      }
      {
        __unkeyed-1 = "<leader>tt";
        action = "<cmd>TestNearest<cr>";
        desc = "Run Nearest";
      }
      {
        __unkeyed-1 = "<leader>tf";
        action = "<cmd>TestFile<cr>";
        desc = "Run File";
      }
      {
        __unkeyed-1 = "<leader>ts";
        action = "<cmd>TestSuite<cr>";
        desc = "Run Suite";
      }
      {
        __unkeyed-1 = "<leader>tg";
        action = "<cmd>TestVisit<cr>";
        desc = "Goto last ran test";
      }
      {
        __unkeyed-1 = "<leader>t.";
        action = "<cmd>TestLast<cr>";
        desc = "Run Last";
      }
    ];
  };
}
