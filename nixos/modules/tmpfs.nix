{ config, environment, ... }:

{
  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=1777" "nosuid" "nodev" "size=3G" ];
  };

  systemd.tmpfiles.rules = [
    "d /tmp 1777 root root 1d"
  ];
}
