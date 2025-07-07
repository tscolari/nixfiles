{ config, environment, ... }:

{
  systemd.tmpfiles.rules = [
    "d /tmp 1777 root root 1d"
  ];
}
