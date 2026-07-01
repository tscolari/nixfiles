{
  pkgs,
  ...
}:

{
  imports = [
    ./generated.nix
    ./hardware.nix
    ./gaming.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          leftmeta = "leftalt";
          leftalt = "leftmeta";
        };
      };
    };
  };
}
