{ ... }:

{
  programs.nixvim = {
    autoGroups = {
      "config#basic" = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = [
          "BufNewFile"
          "BufEnter"
        ];
        group = "config#basic";
        callback = {
          __raw = ''
            function()
              vim.opt_local.formatoptions:remove('o')
            end
          '';
        };
        desc = "Don't format when adding lines with o/O";
      }

      {
        event = "FocusGained";
        group = "config#basic";
        command = "checktime";
        desc = "Reload file on focus";
      }

      {
        event = "FileType";
        pattern = [ "yaml" ];
        desc = "Disable diagnostics for YAML files (can't handle Helm templates)";
        callback = {
          __raw = ''
            function(args)
              -- Disable diagnostics in the buffer
              vim.diagnostic.disable(args.buf)

              -- Disable CursorHold diagnostic popup (like Lspsaga hover diagnostics)
              vim.api.nvim_clear_autocmds({
                  event = "CursorHold",
                  buffer = args.buf,
                  })

            -- Safely clear Lspsaga autocommands if group exists
              local ok, group_autocmds = pcall(vim.api.nvim_get_autocmds, { group = "LspsagaAutocmds" })
              if ok and group_autocmds and #group_autocmds > 0 then
                vim.api.nvim_clear_autocmds({
                    group = "LspsagaAutocmds",
                    buffer = args.buf,
                })
              end
            end
          '';
        };
      }

    ];
  };
}
