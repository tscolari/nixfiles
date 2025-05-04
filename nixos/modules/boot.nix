{ config, pkgs, lib, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [
    "br_netfilter"
    "ip_tables"
    "iptable_nat"
    "nf_conntrack"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    evdi
  ];
}
