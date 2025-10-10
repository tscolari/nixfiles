{ config, lib, pkgs, ... }@args:

{
  programs.nixvim = {
    autoGroups = {
      "config#basic" = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = [ "BufNewFile" "BufEnter" ];
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
    ];
  };
}
