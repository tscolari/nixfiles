{ ... }@args:

{
  programs.nixvim= {
    plugins.neotest = {
      adapters = {
        go.enable = true;
        golang.enable = true;

      };
    };

    extraConfigLua = ''
      -- Set vim-test strategy to vimux if in tmux
      if os.getenv('TMUX') ~= "" then
        vim.g['test#strategy'] = 'vimux'
        vim.g['test#preserve_screen'] = 0
      end

      require('telescope').load_extension('dap')

      -- DAP signs
      vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = "", linehl = "", numhl = "" })
    '';
  };
}
