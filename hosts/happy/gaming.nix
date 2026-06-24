{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };

  # gamemode optimises CPU/GPU governor while a game is running.
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud # in-game performance overlay
    protonup-qt # manage Proton-GE versions
    wowup-cf
    protontricks
  ];
}
