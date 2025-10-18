{
  pkgs,
  ...
}:

let

  packages = import ../../common/packages.nix { inherit pkgs; };

in
{
  environment = {
    systemPackages = packages.common ++ packages.go;
  };
}
