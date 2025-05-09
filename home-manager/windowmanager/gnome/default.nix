{ config, lib, pkgs, ... }@args:

let

  backgroundImage = config.userData.backgroundImage;
  homeDir = config.userData.homeDir;

in {
  imports = [
      ./settings.nix
      ./extensions.nix
      ./keybindings.nix
    ];

  home = {
    file = {
      "${homeDir}/.background.jpg".source = ../../files/${backgroundImage};
    };
  };

  gtk.enable = true;
}
