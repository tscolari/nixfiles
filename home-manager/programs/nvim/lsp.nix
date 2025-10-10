{ config, lib, pkgs, ... }@args:

let

in {
  programs.nixvim = {
    # Copilot highlight color
    highlightOverride = {
      CmpItemKindCopilot = {
        fg = "#6CC644";
      };
    };

    plugins.lspkind.settings.symbol_map = {
      Copilot = "";
    };

    plugins.lsp = {
      preConfig = ''
        vim.lsp.config('*', {
            root_markers = { '.git/' },
        })

        vim.diagnostic.config({
          underline = true,
          virtual_text = {
            spacing = 4,
            format = function(diagnostic)
              -- Only show the first line with virtualtext.
              return string.gsub(diagnostic.message, '\n.*', "")
            end,
          },
          signs = true,
          update_in_insert = false,
        })
      '';

      capabilities = ''
        capabilities = vim.tbl_deep_extend("force", capabilities, require('cmp_nvim_lsp').default_capabilities())
        capabilities.textDocument.completion.completionItem.snippetSupport = true
      '';

      onAttach = ''
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- LSP Mappings
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

        -- Set some keybinds conditional on server capabilities
        if client.server_capabilities.documentFormattingProvider then
          vim.keymap.set("n", "ff", vim.lsp.buf.format, opts)
        elseif client.server_capabilities.documentRangeFormattingProvider then
          vim.keymap.set("n", "ff", vim.lsp.buf.format, opts)
        end

        -- Set autocommands conditional on server_capabilities
        if client.server_capabilities.document_highlight then
          vim.api.nvim_exec([[
            hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
            hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
            hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
            augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
          ]], false)
        else
          vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
              vim.diagnostic.open_float({
                focus = false,
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "cursor",
              })
            end
          })

          vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            callback = function()
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local win_config = vim.api.nvim_win_get_config(win)
                if win_config.relative ~= "" and vim.fn.win_gettype(win) == "popup" then
                  local buf = vim.api.nvim_win_get_buf(win)
                  local buf_name = vim.api.nvim_buf_get_name(buf)
                  if buf_name:match("diagnostic") or buf_name == "" then
                    vim.api.nvim_win_close(win, false)
                  end
                end
              end
            end
          })
          vim.opt.updatetime = 5
        end
      '';
    };

    lsp.servers = {
      dockerls = {
        enable   = true;
        settings = {
          cmd = [ "docker-language-server" "start" "--stdio" ];
        };
      };

      eslint.enable           = true;
      golangci_lint_ls.enable = true;

      gopls = {
        enable   = true;
        settings = {
          gopls = {
            gofumpt = true;
            semanticTokens = true;
            experimentalPostfixCompletions = true;
            analyses = {
              unusedparams = true;
              unusedwrite = true;
              shadow = true;
            };
            staticcheck = true;
          };
        };
      };

      lua_ls = {
        enable   = true;
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT";
              path = {
                __raw = "vim.split(package.path, ';')";
              };
            };
            diagnostics = {
              globals = [ "vim" ];
            };
            workspace = {
              library = {
                __raw = ''
                {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                }
                '';
              };
            };
          };
        };
      };

      nil_ls.enable        = true;
      postgres_lsp.enable  = true;
      ruby_lsp.enable      = true;

      rust_analyzer = {
        enable   = true;
        settings = {
          rust-analyzer = {
            assist = {
              importGranularity = "module";
              importPrefix = "by_self";
            };
            cargo = {
              loadOutDirsFromCheck = true;
            };
            procMacro = {
              enable = true;
            };
          };
        };
      };

      terraformls = {
        enable    = true;
        settings = {
          filetypes = [ "terraform" "tf" "tfvars" ];
        };
      };

      ts_ls.enable = true;
      vimls.enable = true;

      yamlls = {
        enable = true;
        settings = {
          yaml = {
            keyOrdering = false;
            schemas = {
              "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = "docker-compose.yml";
              "https://json.schemastore.org/chart.json" = "Chart.yaml";
            };
          };
        };
      };
    };
  };

}
