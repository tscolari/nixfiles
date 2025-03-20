{ config, pkgs, ... }:

with pkgs;
let

  # encorePkg = buildGo123Module rec {
  #   pname       = "encore";
  #   version     = "1.44.0";
  #   subPackages = [ "cli/cmd" ];
  #   vendorHash  = "sha256-gZUdjcauVA7TROphmLKcvfcV7BEoAI+9zVMn511D050=";
  #
  #   src = pkgs.fetchFromGitHub {
  #     owner  = "encoredev";
  #     repo   = "encore";
  #     rev    = "v${version}";
  #     sha256 = "6ZCwPlM7WfSevbySX/VmvhxQZ4LxdMN6lppZSB9gdwE=";
  #   };
  # };

in {
  home = {
    packages = [
      # encorePkg
    ];
  };
}
