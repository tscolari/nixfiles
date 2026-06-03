{
  pkgs,
  ...
}:

{
  environment = {
    systemPackages = with pkgs; [
      fcitx5
      system-config-printer
      vim
    ];
  };
}
