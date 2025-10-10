{ config, lib, pkgs, ... }@args:

let

  customPlugins = import ./custom.nix { inherit pkgs; };

in {

  imports = [
    ./completion.nix
    ./treesitter.nix
    ./ui.nix
  ];

  programs.nixvim = {

    plugins = {
      alpha.enable = true;
      avante.enable = true;
      cmp.enable = true;
      cmp-buffer.enable = true;
      cmp-calc.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-path.enable = true;
      cmp-vsnip.enable = true;
      comment.enable = true;
      conform-nvim.enable = true;
      copilot-cmp.enable = true;
      copilot-lua.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      dap.enable = true;
      diffview.enable = true;
      friendly-snippets.enable = true;
      fugitive.enable = true;
      indent-blankline.enable = true;
      lir.enable = true;
      lsp-format.enable = true;
      lspconfig.enable = true;
      lsp-signature.enable = true;
      lspkind.enable = true;
      lspsaga.enable = true;
      lualine.enable = true;
      neoscroll.enable = true;
      neotest.enable = true;
      notify.enable = true;
      nvim-autopairs.enable = true;
      nvim-bqf.enable = true;
      rainbow-delimiters.enable = true;
      repeat.enable = true;
      sleuth.enable = true;
      spectre.enable = true;
      telescope.enable = true;
      telescope.extensions.file-browser.enable = true;
      telescope.extensions.fzf-native.enable = true;
      tmux-navigator.enable = true;
      treesitter.enable = true;
      treesitter-textobjects.enable = true;
      trouble.enable = true;
      ts-autotag.enable = true;
      ts-context-commentstring.enable = true;
      undotree.enable = true;
      vim-bbye.enable = true;
      vim-surround.enable = true;
      vim-test.enable = true;
      vimux.enable = true;
      visual-multi.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
    };

    extraPlugins = with pkgs.vim-plugins.vimPlugins; [

      asyncrun-vim
      catppuccin-nvim
      fzf-vim
      lsp-colors-nvim
      mason-lspconfig-nvim
      mason-nvim
      mkdir-nvim
      neotest-go
      neotest-jest
      nvim-nio
      nvim-treesitter-endwise
      plenary-nvim
      popup-nvim
      splitjoin-vim
      telescope-dap-nvim
      telescope-github-nvim
      telescope-nvim
      vim-abolish
      vim-easy-align
      vim-eunuch
      vim-exchange
      vim-fetch
      vim-grepper
      vim-markdown
      vim-move
      vim-qf
      vim-rhubarb
      vim-swap
      vim-test
      vim-trailing-whitespace
      vim-unimpaired
      vim-vsnip
      vim-vsnip-integ
      vista-vim

      # customPlugins.join-vim
      customPlugins.lir-git-status-nvim
      customPlugins.goalt-nvim
      # nvim-neotest-neotest-vim-test

      pkgs.vim-plugins.vimExtraPlugins.guihua-lua
      pkgs.vim-plugins.vimExtraPlugins.vgit-nvim
    ];
  };

}
