{ config, lib, pkgs, modulesPath, ... }:

{
  system.activationScripts.binBash = {
    text = ''
      mkdir -p /bin
      ln -sf ${pkgs.bash}/bin/bash /bin/bash
    '';
  };
}
