{ pkgs, ... }:

let

  grammarPackages = with pkgs.vim-plugins.vimPlugins.nvim-treesitter.builtGrammars; [
    c
    c_sharp
    cmake
    comment
    cpp
    css
    dart
    dockerfile
    elixir
    elm
    erlang
    go
    godot_resource
    gomod
    gowork
    graphql
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
    latex
    llvm
    lua
    make
    markdown
    ninja
    nix
    python
    ql
    query
    regex
    rst
    ruby
    rust
    scheme
    scss
    sql
    teal
    todotxt
    toml
    tsx
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

    treesitter-refactor.settings = {
      highlightDefinitions = {
        enable = true;
      };
      smartRename = {
        enable = true;
        keymaps = {
          smart_rename = "grr";
        };
      };
      navigation = {
        enable = true;
        keymaps = {
          goto_definition = "gnd";
          list_definitions = "gnD";
          list_definitions_toc = "gO";
          goto_next_usage = "<a-*>";
          goto_previous_usage = "<a-#>";
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
