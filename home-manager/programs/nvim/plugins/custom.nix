{ pkgs, ... }:

let

  buildPlugin =
    args:
    pkgs.vimUtils.buildVimPlugin {
      pname = args.pname;
      version = args.rev;
      src = pkgs.fetchFromGitHub {
        owner = args.owner;
        repo = args.repo;
        rev = args.rev;
        hash = args.hash;
      };
      dependencies = args.dependencies or [ ];

    };

in
{

  join-vim = buildPlugin {
    pname = "join.vim";
    owner = "sk1418";
    repo = "Join";
    rev = "main"; # Pin to commit hash later
    hash = ""; # Fill after first build
  };

  lir-git-status-nvim = buildPlugin {
    pname = "lir-git-status.nvim";
    owner = "tamago324";
    repo = "lir-git-status.nvim";
    rev = "4d574f6a9e6d7ce3fe6cccb87a601fb72fb0404d";
    hash = "sha256-o6rxSF7MTKBRs0bXB8fO6tmIPqFDmOU5r5sKPjSd+KI=";
    dependencies = with pkgs.vimPlugins; [
      plenary-nvim
      lir-nvim
    ];
  };

  goalt-nvim = buildPlugin {
    pname = "goalt.nvim";
    owner = "tscolari";
    repo = "goalt.nvim";
    rev = "v0.0.1";
    hash = "sha256-g4fvKswD2Sr3Zuy1Znku1NInDXF2sO6P7PXGecBDDdk=";
  };
}
