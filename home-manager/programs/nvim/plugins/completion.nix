{ ... }@args:

{
  programs.nixvim = {
    plugins.cmp.settings = {
      autoEnableSources = true;

      # Snippet configuration
      snippet.expand = ''
        function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end
      '';

      sources = [
        { name = "copilot";  }
        { name = "nvim_lsp"; }
        { name = "nvim_lua"; }
        { name = "vsnip";    }
        { name = "buffer";   }
        { name = "calc";     }
        { name = "path";     }
      ];

      # Mapping configuration
      mapping = {
        "<C-y>" = {
          __raw = "cmp.mapping.confirm({ select = true })";
        };

        "<C-n>" = {
          __raw = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif vim.fn["vsnip#available"]() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };

        "<Up>" = {
          __raw = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif vim.fn["vsnip#available"]() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };

        "<C-p>" = {
          __raw = ''
            cmp.mapping(function()
              if cmp.visible() then
                cmp.select_prev_item()
              elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
              end
            end, { "i", "s" })
          '';
        };

        "<Down>" = {
          __raw = ''
            cmp.mapping(function()
              if cmp.visible() then
                cmp.select_prev_item()
              elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
              end
            end, { "i", "s" })
          '';
        };

        "<C-j>" = {
          __raw = ''
            cmp.mapping(function(fallback)
              if vim.fn['vsnip#available']() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), "")
              else
                fallback()
              end
            end, { 'i', 's' })
          '';
        };

        "<C-k>" = {
          __raw = ''
            cmp.mapping(function(fallback)
              if vim.fn['vsnip#available']() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), "")
              else
                fallback()
              end
            end, { 'i', 's' })
          '';
        };
      };

      # Window configuration
      window = {
        completion = {
          __raw = "cmp.config.window.bordered()";
        };
        documentation = {
          __raw = "cmp.config.window.bordered()";
        };
      };
    };
  };
}
