{ pkgs, ... }:

{

  programs.nixvim.extraPackages = with pkgs.vim-plugins; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    texliveFull
    zathura
  ];

}
