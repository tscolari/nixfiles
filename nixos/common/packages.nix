{
  pkgs,
  ...
}:

{
  environment = {
    systemPackages = with pkgs; [
      docker
      docker-compose
      fcitx5
      system-config-printer
      vim
    ];
  };
}
