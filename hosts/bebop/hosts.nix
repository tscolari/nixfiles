{ config, nixos-hardware, lib, pkgs, modulesPath, ... }:

{
networking.extraHosts =
  ''
  172.21.0.1 host.docker.internal
  127.0.0.1 localhost.local.diagrid.io
  127.0.0.1 admin.local.diagrid.io
  127.0.0.1 api.local.diagrid.io
  127.0.0.1 tunnels.api.local.diagrid.io
  127.0.0.1 admingrid.local.diagrid.io
  127.0.0.1 cloudgrid.local.diagrid.io
  127.0.0.1 cra.local.diagrid.io
  127.0.0.1 trust-pem.local.diagrid.io
  127.0.0.1 metrics.local.diagrid.io
  127.0.0.1 cra-metrics.local.diagrid.io
  127.0.0.1 logs.local.diagrid.io
  127.0.0.1 cra-logs.local.diagrid.io
  127.0.0.1 events.local.diagrid.io
  127.0.0.1 leafnode.events.local.diagrid.io
  127.0.0.1 client.events.local.diagrid.io
  127.0.0.1 mgmt-onebox-agent-onebox.api.local.diagrid.io
  127.0.0.1 http-prj4.api.local.diagrid.io
  127.0.0.1 grpc-prj4.api.local.diagrid.io
  '';
}
