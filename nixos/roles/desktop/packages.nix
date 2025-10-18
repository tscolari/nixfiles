{ pkgs, ... }:

let

  packages = import ../../../common/packages.nix { inherit pkgs; };
in
{
  environment = {
    systemPackages = [
      pkgs.unstable.displaylink
    ]
    ++ packages.gui;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
