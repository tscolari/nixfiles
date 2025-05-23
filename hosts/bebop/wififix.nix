{ config, lib, pkgs, ... }:
{
  systemd.user.services."wifi-resume" = {
    description = "Restart NetworkManager Wi-Fi after resume";
    wantedBy = [ "suspend.target" "hibernate.target" ];
    after = [ "suspend.target" "hibernate.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl restart NetworkManager.service";
    };
  };
}
