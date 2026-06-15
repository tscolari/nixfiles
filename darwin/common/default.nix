{
  pkgs,
  ...
}:

{
  environment = {
    shells = with pkgs; [ zsh ];
    variables = {
      EDITOR = "vim";
    };
    systemPackages = with pkgs; [
      vim
    ];
  };
}
