{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    distrobox
    podman
    clamav
  ];

  systemd.services.distrobox-ubuntu = {
    description = "Distrobox Ubuntu";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network-online.target"
      "podman.socket"
    ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "forking";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.distrobox}/bin/distrobox-enter --name ubuntu -- true";
      ExecStop = "${pkgs.distrobox}/bin/distrobox stop ubuntu-work";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };

  services.clamav = {
    daemon = {
      enable = true;
    };

    updater = {
      enable = true;
      interval = "hourly";
      frequency = 12;
    };

    scanner = {
      enable = true;
      interval = "*-*-* 09:30:00";
    };
  };
}
