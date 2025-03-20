# /etc/nixos/flake.nix
{
  inputs = {
    nixpkgs.url          = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url   = "github:NixOS/nixpkgs/master";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vimfiles = {
      url = "github:tscolari/nvim";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , nixpkgs-master
    , home-manager
    , nixos-hardware
    , nix-ld
    , vimfiles
    , ...
    }@inputs:

    let
      system = "x86_64-linux";

      genericModules = [
        ./configuration.nix

        nixos-hardware.nixosModules.lenovo-thinkpad-t14
        nixos-hardware.nixosModules.common-cpu-intel

        nix-ld.nixosModules.nix-ld

        home-manager.nixosModules.home-manager

        {
          # This fixes things that don't use Flakes, but do want to use NixPkgs.
          nix.registry.nixos.flake = inputs.self;
          environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
          nix.nixPath = [ "nixpkgs=${nixpkgs.outPath}" ];
        }

        {
          nix.registry.nixos.flake = inputs.self;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit vimfiles; };
        }

        # Make sure you add Overlays here
        ({ config, pkgs, ... }:
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays =
              [
                overlay-unstable
                overlay-master
                overlay-vimfiles
              ];
          }
        )
      ];

      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
          config.nvidia.acceptLicense = true;
        };
      };

      # nixpkgs-master
      overlay-master = final: prev: {
        master = import nixpkgs-master {
          inherit system;
          config.allowUnfree = true;
          config.nvidia.acceptLicense = true;
        };
      };

      overlay-vimfiles = final: prev: {
        master = import vimfiles;
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          # make unstable packages available via overlay
          (final: prev: {
            unstable = nixpkgs-unstable.legacyPackages.${prev.system};
          })
        ];
      };

  in {

    nixosConfigurations.bebop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system  = "x86_64-linux";
      modules = genericModules;
    };
  };
}
