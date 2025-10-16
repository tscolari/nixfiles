{ pkgs, ... }:

let

  grammarPackages = with pkgs.vim-plugins.vimPlugins.nvim-treesitter.builtGrammars; [
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
    vim
    vue
    yaml
  ];

in
{

  # programs.nixvim = {
  #   extraConfigLua = ''
  #     require('nvim-ts-autotag').setup()
  #   '';
  # };

  programs.nixvim.plugins = {
    treesitter = {
      grammarPackages = grammarPackages;

      settings = {
        sync_install = false;
        auto_install = false;

        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };

        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "gnn";
            node_incremental = "grn";
            scope_incremental = "grc";
            node_decremental = "grm";
          };
        };

        playground = {
          enable = true;
          disable = [ ];
          updatetime = 25;
          persist_queries = false;
        };

        autotag = {
          enable = true;
        };
      };
    };

    treesitter-refactor = {
      highlightDefinitions = {
        enable = true;
      };
      smartRename = {
        enable = true;
        keymaps = {
          smartRename = "grr";
        };
      };
      navigation = {
        enable = true;
        keymaps = {
          gotoDefinition = "gnd";
          listDefinitions = "gnD";
          listDefinitionsToc = "gO";
          gotoNextUsage = "<a-*>";
          gotoPreviousUsage = "<a-#>";
        };
      };
    };

    treesitter-textobjects = {
      select = {
        enable = true;
        keymaps = {
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
        };
      };

      move = {
        enable = true;
        setJumps = true;
        gotoNextStart = {
          "]m" = "@function.outer";
          "]]" = "@class.outer";
        };
        gotoNextEnd = {
          "]M" = "@function.outer";
          "][" = "@class.outer";
        };
        gotoPreviousStart = {
          "[m" = "@function.outer";
          "[[" = "@class.outer";
        };
        gotoPreviousEnd = {
          "[M" = "@function.outer";
          "[]" = "@class.outer";
        };
      };
    };
  };
}
