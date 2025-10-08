{ pkgs, ... }@args:

{

  home = {
    packages = with pkgs [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      texliveFull
      zathura
      unstable.lua-language-server
      docker-language-server

      unstable.docker-language-server
      unstable.golangci-lint
      unstable.gopls
      unstable.lua-language-server
      unstable.nil
      unstable.nodePackages.eslint
      unstable.nodePackages.typescript-language-server
      unstable.postgres-lsp
      unstable.ruby-lsp
      unstable.terraform-ls
      unstable.vim-language-server
      unstable.yaml-language-server
    ];
  };

}
