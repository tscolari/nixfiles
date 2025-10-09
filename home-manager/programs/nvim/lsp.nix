{ config, lib, pkgs, ... }@args:

let

in {

  programs.nixvim.lsp = {
    servers = {
      dockerls.enable         = true;
      eslint.enable           = true;
      golangci_lint_ls.enable = true;
      gopls.enable            = true;
      lua_ls.enable           = true;
      nil_ls.enable           = true;
      postgres_lsp.enable     = true;
      ruby_lsp.enable         = true;
      terraformls.enable      = true;
      ts_ls.enable            = true;
      vimls.enable            = true;
      yamlls.enable           = true;
    };
  };

}
