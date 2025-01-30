{ config, pkgs, ... }:

let

  homeDir = config.userData.homeDir;
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  home = {

    # Files and remote configurations
    file = {
      # Neovim
      "${homeDir}/.config/nvim".source = builtins.fetchGit {
        url = "https://github.com/tscolari/nvim";
        submodules = true;
        shallow = true;
        ref = "main";
      };
      "${homeDir}/.local/dotfiles/nvim/plugin/.empty".source = ../files/empty;
      "${homeDir}/.local/dotfiles/nvim/user/.empty".source = ../files/empty;
      "${homeDir}/.local/share/nvim/.empty".source = ../files/empty;
      "${homeDir}/.cache/.empty".source = ../files/empty;
    };

    packages = [
      pkgs.nerdfonts
      pkgs.texliveFull
      pkgs.zathura
      unstable.lua-language-server
    ];
  };

  programs.neovim = {
    enable = true;

    viAlias       = true;
    vimAlias      = true;

    package = unstable.neovim.unwrapped;

    plugins = with pkgs.vimPlugins; [
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
      unstable.terraform-ls
      unstable.nodePackages.eslint
      unstable.lua-language-server
      unstable.nodePackages.typescript-language-server
      unstable.gopls
      unstable.golangci-lint
      unstable.vim-language-server
      unstable.yaml-language-server
      unstable.postgres-lsp
      unstable.ruby-lsp
    ];
  };
}
