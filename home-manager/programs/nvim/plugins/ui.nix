{ config, lib, pkgs, ... }@args:

{
  programs.nixvim = {
    colorscheme = "catppuccin-mocha";

    globals = {
      lualine_theme = "catppuccin-mocha";
      config_colorscheme = "catppuccin-mocha";
    };

    plugins.alpha = {
      theme = "dashboard";
    };
  };
}
