{ config, pkgs, lib, ...}:

{
  services.vanta-agent = {
    enable = true;
  };
}
