{
  pkgs,
  lib,
  hostUsers,
  inputs,
  ...
}:

{
  system.stateVersion = 6;

  system.primaryUser = lib.head (lib.mapAttrsToList (username: _: username) hostUsers);

  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users = lib.mapAttrs (username: userData: {
    shell = pkgs.zsh;
    description = userData.fullName;
    home = userData.homeDir;
  }) hostUsers;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";

    sharedModules = [
      inputs.homenix.homeModules.default
    ];

    extraSpecialArgs = {
      catppuccin = inputs.catppuccin;
      homenix = inputs.homenix;
    };

    users = lib.mapAttrs (
      username: userData:
      { ... }@args:
      {
        imports = [
          ../home-manager
          (../home-manager/by-user + "/${username}")
          args.catppuccin.homeModules.catppuccin
        ];

        config.userData = userData;
      }
    ) hostUsers;
  };

  environment.extraOutputsToInstall = [ "dev" ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    settings.auto-optimise-store = true;
    settings.trusted-users = [
      "root"
      "tscolari"
    ];
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 10d";
    };
  };
}
