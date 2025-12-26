{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    tscolari-pkgs.url = "github:tscolari/nixpkgs";

    homenix = {
      url = "github:tscolari/homenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    catppuccin.url = "github:catppuccin/nix/release-25.05";

    nix-ld = {
      url = "github:Mic92/nix-ld/2.0.6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      catppuccin,
      home-manager,
      homenix,
      nix-ld,
      nixos-hardware,
      nixpkgs,
      nixpkgs-master,
      nixpkgs-unstable,
      tscolari-pkgs,
      ...
    }@inputs:

    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      # Base common modules used by all systems
      baseModules = [
        ./configuration.nix
        ./nixos/common
        ./nixos/modules

        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        inputs.nix-flatpak.nixosModules.nix-flatpak
        nix-ld.nixosModules.nix-ld

        {
          # This fixes things that don't use Flakes, but do want to use NixPkgs.
          nix.registry.nixos.flake = inputs.self;
          environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
          nix.nixPath = [ "nixpkgs=${nixpkgs.outPath}" ];
        }

        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.backupFileExtension = "backup";

          home-manager.sharedModules = [
            homenix.homeModules.default
          ];
        }

        # Make sure you add Overlays here
        (
          { config, pkgs, ... }:
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [
              overlay-unstable
              overlay-master
              overlay-local
              homenix.overlays.default
              tscolari-pkgs.overlays.default
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

      overlay-local = final: prev: {
        teleport_14 = prev.callPackage ./packages/teleport-14.nix { };
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

      # All available user configurations.
      usersConfig = import ./users.nix;

      # Function to create a system configuration
      mkSystem =
        {
          hostName,
          users ? [ ],
          hardwareModules ? [ ],
          extraModules ? [ ],
        }:
        lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            hostUsers = lib.attrsets.genAttrs users (name: usersConfig.available-users.${name});
          };
          system = "x86_64-linux";
          modules =
            baseModules
            ++ hardwareModules
            ++ extraModules
            ++ [
              (./hosts + "/${hostName}")
              {
                networking.hostName = hostName;
              }
            ];
        };

    in
    {

      nixosConfigurations = {
        bebop = mkSystem {
          hostName = "bebop";
          users = [
            "tscolari"
          ];
          hardwareModules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t14
            nixos-hardware.nixosModules.common-cpu-intel
            tscolari-pkgs.nixosModules.default
          ];
          extraModules = [
            ./nixos/roles/desktop
            ./nixos/modules/ai.nix
          ];
        };
      };
    };
}
