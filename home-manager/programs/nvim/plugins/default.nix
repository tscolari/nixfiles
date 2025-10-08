{ config, lib, pkgs, ... }@args:

let

  customPlugins = import ./custom.nix { inherit pkgs; };

in {

  programs.neovim = {
    plugins = with pkgs.vim-plugins.vimPlugins; [

      alpha-nvim
      asyncrun-vim
      avante-nvim
      catppuccin-nvim
      cmp-buffer
      cmp-calc
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp-vsnip
      comment-nvim
      conform-nvim
      copilot-cmp
      copilot-lua
      diffview-nvim
      friendly-snippets
      fzf-vim
      indent-blankline-nvim
      lir-nvim
      lsp-colors-nvim
      lsp-format-nvim
      lsp_signature-nvim
      lspkind-nvim
      lspsaga-nvim
      lualine-nvim
      mason-lspconfig-nvim
      mason-nvim
      mkdir-nvim
      neoscroll-nvim
      neotest
      neotest-go
      neotest-jest
      nvim-autopairs
      nvim-bqf
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-lspconfig
      nvim-nio
      nvim-notify
      nvim-spectre
      nvim-treesitter-endwise
      nvim-treesitter-textobjects
      nvim-ts-autotag
      nvim-ts-context-commentstring
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      rainbow-delimiters-nvim
      splitjoin-vim
      telescope-dap-nvim
      telescope-file-browser-nvim
      telescope-fzf-native-nvim
      telescope-github-nvim
      telescope-nvim
      trouble-nvim
      undotree
      vim-abolish
      vim-bbye
      vim-easy-align
      vim-eunuch
      vim-exchange
      vim-fetch
      vim-fugitive
      vim-grepper
      vim-markdown
      vim-move
      vim-qf
      vim-repeat
      vim-rhubarb
      vim-sleuth
      vim-surround
      vim-swap
      vim-test
      vim-tmux-navigator
      vim-trailing-whitespace
      vim-unimpaired
      vim-visual-multi
      vim-vsnip
      vim-vsnip-integ
      vimux
      vista-vim
      which-key-nvim

      # customPlugins.join-vim
      customPlugins.lir-git-status-nvim
      customPlugins.goalt-nvim
      # nvim-neotest-neotest-vim-test

      pkgs.vim-plugins.vimExtraPlugins.guihua-lua
      pkgs.vim-plugins.vimExtraPlugins.vgit-nvim

      (nvim-treesitter.withPlugins (plugins: with plugins; [
          c
          c_sharp
          clojure
          cmake
          comment
          cpp
          css
          d
          dart
          dockerfile
          dot
          elixir
          elm
          erlang
          fennel
          fish
          fortran
          go
          godot_resource
          gomod
          gowork
          graphql
          hack
          haskell
          hcl
          vimdoc
          html
          http
          java
          javascript
          jsdoc
          json
          json5
          jsonc
          kotlin
          latex
          llvm
          lua
          make
          markdown
          ninja
          nix
          pascal
          perl
          php
          python
          ql
          query
          r
          regex
          rst
          ruby
          rust
          scala
          scheme
          scss
          sql
          svelte
          swift
          teal
          todotxt
          toml
          tsx
          turtle
          typescript
          # verilog
          vim
          vue
          yaml
      ]))
    ];
  };

}
