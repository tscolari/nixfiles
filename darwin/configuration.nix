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

  documentation.enable = false;
  documentation.doc.enable = false;

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

  # Determinate Nix manages the installation itself; nix-darwin must keep its
  # hands off. Note this disables the whole `nix.*` option tree -- actual Nix
  # settings live in ./modules/nix.nix.
  nix.enable = false;
}
