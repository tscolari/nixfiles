{ config, pkgs, lib, ...}:

{
  imports =
    [
      ./gnome.nix
      ./packages.nix
      ./xserver.nix
    ];

  # Sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
  };
}
