{ config, environment, ... }:

{
  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=1777" "nosuid" "nodev" "size=2G" ];
  };

  systemd.tmpfiles.rules = [
    # Remove files in /tmp not accessed in the last 5 days
    "d /tmp 1777 root root 2d"
  ];
}
