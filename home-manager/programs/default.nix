{
  pkgs,
  ...
}:

{
  imports = [
    ./git.nix
    ./go.nix
    ./node.nix
    ./nvim
    ./tmux.nix
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.fzf;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
