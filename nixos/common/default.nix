{
  pkgs,
  ...
}:

{
  imports = [
    ./appimage.nix
    ./packages.nix
  ];

  environment = {
    shells = with pkgs; [ zsh ];
    variables = {
      EDITOR = "vim";
    };
  };
}
