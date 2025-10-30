{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./catppuccin.nix
    ./gnome.nix
    ./packages.nix
    ./xserver.nix
  ];

  # Sound
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
  };

  services.flatpak = {
    enable = true;
    packages = [ "us.zoom.Zoom" ];
    update.auto.enable = false;
    uninstallUnmanaged = false;
  };

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gnome3;

  # Fixes for suspend/hibernate + DisplayLink
  systemd.services."pre-sleep".wantedBy = lib.mkForce [ ];

  # Override the default powerDownCommands
  powerManagement.powerDownCommands = lib.mkForce ''
    # Check if DisplayLink pipes exist
    if [ -p /tmp/PmMessagesPort_in ] && [ -f /tmp/PmMessagesPort_out ]; then
      # Flush any bytes in pipe
      while read -n 1 -t 1 SUSPEND_RESULT < /tmp/PmMessagesPort_out; do : ; done;

      # Send suspend signal
      echo "S" > /tmp/PmMessagesPort_in

      # Wait with timeout for response
      if read -n 1 -t 10 SUSPEND_RESULT < /tmp/PmMessagesPort_out; then
        echo "DisplayLinkManager suspended successfully"
      else
        echo "DisplayLinkManager suspend timed out, continuing anyway"
      fi
    fi
  '';

  systemd.services."displaylink-resume" = {
    description = "Reset DisplayLink after resume";
    wantedBy = [
      "suspend.target"
      "hibernate.target"
    ];
    after = [
      "suspend.target"
      "hibernate.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl restart dlm.service";
    };
  };
}
