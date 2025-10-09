{ config, lib, pkgs, ... }@args:

{
  imports = [
    ./dependencies.nix
    ./plugins
    ./lsp.nix
  ];


  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias  = true;
    vimAlias = true;
  };

  # programs.neovim = {
  #   enable = true;
  #
  #   viAlias       = true;
  #   vimAlias      = true;
  #
  #   package = pkgs.unstable.neovim.unwrapped;
  # };
}
