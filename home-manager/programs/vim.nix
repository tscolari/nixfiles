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
      "${homeDir}/bin/nvim".source = pkgs.writeShellScript "nvim" ''
        exec /run/current-system/sw/bin/nvim "$@"
      '';
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

    package = pkgs.neovim.unwrapped;

    plugins = with pkgs.unstable.vimPlugins; [

      avante-nvim

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

    extraPackages = with pkgs.unstable; [
      golangci-lint
      gopls
      lua-language-server
      nil
      nodePackages.eslint
      nodePackages.typescript-language-server
      postgres-lsp
      ruby-lsp
      terraform-ls
      vim-language-server
      yaml-language-server
    ];
  };
}
