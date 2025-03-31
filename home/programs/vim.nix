{ config, pkgs, vimfiles, ... }@args:

let

  homeDir = config.userData.homeDir;

in {

  home = {

    # Files and remote configurations
    file = {
      # Neovim
      "${homeDir}/.config/nvim".source = vimfiles;
      "${homeDir}/.local/dotfiles/nvim/plugin/.empty".source = ../files/empty;
      "${homeDir}/.local/dotfiles/nvim/user/.empty".source = ../files/empty;
      "${homeDir}/.local/share/nvim/.empty".source = ../files/empty;
      "${homeDir}/.cache/.empty".source = ../files/empty;
    };

    packages = [
      pkgs.nerdfonts
      pkgs.texliveFull
      pkgs.zathura
      pkgs.unstable.lua-language-server
    ];
  };

  programs.neovim = {
    enable = true;

    viAlias       = true;
    vimAlias      = true;

    package = pkgs.unstable.neovim.unwrapped;

    plugins = with pkgs.vimPlugins; [
      pkgs.unstable.vimPlugins.avante-nvim
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
          verilog
          vim
          vue
          yaml
      ]))
    ];

    extraPackages = [
      pkgs.terraform-ls
      pkgs.nodePackages.eslint
      pkgs.lua-language-server
      pkgs.nodePackages.typescript-language-server
      pkgs.gopls
      pkgs.golangci-lint
      pkgs.vim-language-server
      pkgs.yaml-language-server
      pkgs.postgres-lsp
      pkgs.ruby-lsp
    ];
  };
}
