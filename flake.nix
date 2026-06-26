{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    homenix = {
      url = "git+ssh://git@codeberg.org/tscolari/homenix?ref=26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    catppuccin.url = "github:catppuccin/nix/release-26.05";

    nix-ld = {
      url = "github:Mic92/nix-ld/2.0.6";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      catppuccin,
      home-manager,
      homenix,
      nix-darwin,
      nix-ld,
      nixos-hardware,
      nixpkgs,
      nixpkgs-master,
      nixpkgs-unstable,
      ...
    }@inputs:

    let
      linuxSystem = "x86_64-linux";
      darwinSystem = "aarch64-darwin";

      lib = nixpkgs.lib;

      mkOverlayUnstable = system: final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
          config.nvidia.acceptLicense = true;
        };
      };

      mkOverlayMaster = system: final: prev: {
        master = import nixpkgs-master {
          inherit system;
          config.allowUnfree = true;
          config.nvidia.acceptLicense = true;
        };
      };

      # Base common modules used by all NixOS systems
      baseModules = [
        ./configuration.nix
        ./nixos/common
        ./nixos/modules

        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        inputs.nix-flatpak.nixosModules.nix-flatpak
        nix-ld.nixosModules.nix-ld
        inputs.agenix.nixosModules.default

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
              (mkOverlayUnstable linuxSystem)
              (mkOverlayMaster linuxSystem)
              homenix.overlays.default

              # Hack to get around intel-ocl 403 url
              (final: prev: {
                intel-ocl = prev.runCommand "intel-ocl-stub" { } "mkdir -p $out";
              })

              (final: prev: {
                hyprland = final.unstable.hyprland;
                xdg-desktop-portal-hyprland = final.unstable.xdg-desktop-portal-hyprland;
                hyprlock = final.unstable.hyprlock;
                hypridle = final.unstable.hypridle;
                hyprsunset = final.unstable.hyprsunset;
              })
            ];
          }
        )
      ];

      # Base modules used by all Darwin systems
      darwinBaseModules = [
        ./darwin/configuration.nix
        ./darwin/common
        ./darwin/modules

        home-manager.darwinModules.home-manager
        inputs.agenix.darwinModules.default

        {
          nix.registry.nixos.flake = inputs.self;
          environment.etc."nix/inputs/nixpkgs".source = nixpkgs-unstable.outPath;
          nix.nixPath = [ "nixpkgs=${nixpkgs-unstable.outPath}" ];
        }

        (
          { config, pkgs, ... }:
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.allowUnsupportedSystem = true;
            nixpkgs.overlays = [
              (mkOverlayMaster darwinSystem)
              # darwin pkgs is already nixpkgs-unstable; expose it as pkgs.unstable
              # so any code using `with pkgs; unstable.x` continues to work
              (final: prev: { unstable = final; })
              homenix.overlays.default

              # ghostty is Linux-only; stub both attrs so home-manager's
              # programs.ghostty module default and homenix terminfo checks
              # don't pull in an unsupported package on darwin
              (final: prev: {
                ghostty = prev.runCommand "ghostty-stub" { } "mkdir -p $out";
                ghostty-bin = prev.runCommand "ghostty-bin-stub" { } "mkdir -p $out";
              })
            ];
          }
        )
      ];

      pkgs = import nixpkgs {
        system = linuxSystem;
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

      # Function to create a NixOS system configuration
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
          system = linuxSystem;
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

      # Function to create a nix-darwin system configuration
      mkDarwinSystem =
        {
          hostName,
          users ? [ ],
          extraModules ? [ ],
        }:
        nix-darwin.lib.darwinSystem {
          system = darwinSystem;
          specialArgs = {
            inherit inputs;
            hostUsers = lib.attrsets.genAttrs users (
              name:
              let
                u = usersConfig.available-users.${name};
              in
              u
              // {
                homeDir = "/Users/${u.username}";
                extraGroups = [ ];
              }
            );
          };
          modules =
            darwinBaseModules
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
          ];
          extraModules = [
            ./nixos/roles/desktop
            ./nixos/modules/ai.nix
          ];
        };
        happy = mkSystem {
          hostName = "happy";
          users = [
            "tscolari"
          ];
          hardwareModules = [
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-gpu-amd
          ];
          extraModules = [
            ./nixos/roles/desktop
          ];
        };
      };

      darwinConfigurations = {
        cowboy = mkDarwinSystem {
          hostName = "cowboy";
          users = [
            "tscolari"
          ];
        };
      };
    };
}
