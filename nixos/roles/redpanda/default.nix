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
    description = "Distrobox Ubuntu Container";
    wantedBy = [ "multi-user.target" ];
    after = [ "podman.service" ];
    requires = [ "podman.service" ];

    path = with pkgs; [
      distrobox
      podman
      glibc
      coreutils
      util-linux
      shadow
      gawk
      gnugrep
      gnused
      findutils
      procps
      bash
    ];

    serviceConfig = {
      Type = "forking";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.distrobox}/bin/distrobox-enter --name ubuntu-root -- true";
      ExecStop = "${pkgs.distrobox}/bin/distrobox stop ubuntu-root -Y || true";
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
