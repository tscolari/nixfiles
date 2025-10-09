{ config, lib, pkgs, ... }@args:

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

in {

  programs.nixvim.plugins.treesitter = {
    grammarPackages = grammarPackages;
  };
}
