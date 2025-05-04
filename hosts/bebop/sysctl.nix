{ config, pkgs, lib, ...}:

{
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 80;
  };
}
