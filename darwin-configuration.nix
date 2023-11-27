{ config, pkgs, lib, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {

  imports =
    [
      <home-manager/nix-darwin>
    ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
    ];

  nixpkgs.config.allowUnfree = true;

  users.users.tscolari = {
    shell = pkgs.zsh;
    description = "Tiago Scolari";
    home = "/Users/tscolari";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.tscolari = import ./home/darwin.nix {
      inherit pkgs lib config;
      userData = {
        username = "tscolari";
        fullName = "Tiago Scolari";
        homeDir  = "/Users/tscolari";

        git = {
          githubUser = "tscolari";
          email = "git@tscolari.me";
        };
      };
    };
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  system.stateVersion = 4;
}
