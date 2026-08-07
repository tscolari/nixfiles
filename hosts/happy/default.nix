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

  services.ollama = {
    environmentVariables = {
      OLLAMA_VULKAN = "1";
    };
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
  ];
}
