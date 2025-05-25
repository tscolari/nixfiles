{ config, pkgs, environment, services, hardware, ... }:

{
  users.users.ai = {
    isNormalUser = true;
    description = "AI User";
    createHome = false;
    group = "users";
    home = "/home/ai";
    shell = pkgs.zsh;

    packages = with pkgs; [
      unstable.claude-code
      unstable.aider-chat
      nodejs
      yarn
    ];
  };

  environment.etc."profile.d/ai-umask.sh".text = ''
    if [ "$USER" = "ai" ]; then
      umask 002
    fi
  '';

  systemd = {
    services.mount-ai-workspace = {
      description = "Mount bindfs GOPATH for ai";
      wantedBy = [ "multi-user.target" ];
      after = [ "local-fs.target" ];
      path = with pkgs; [ bash bindfs coreutils ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;

        ExecStartPre = [
          "${pkgs.coreutils}/bin/mkdir -p /srv/ai-go"
          "${pkgs.coreutils}/bin/mkdir -p /home/ai/go"
          "${pkgs.coreutils}/bin/chown ai:users /srv/ai-go"
          "${pkgs.coreutils}/bin/chown ai:users /home/ai/go"
        ];

        ExecStart = ''
          ${pkgs.bindfs}/bin/bindfs \
          --force-user=ai \
          --force-group=users \
          --perms=u=rwX:g=rwX:o= \
          /srv/ai-go /home/ai/go
          '';
      };
    };

    tmpfiles.rules = [
      "d /home/ai 0770 ai users -"
      "d /srv/ai-go 0770 ai users -"
    ];
  };

  security = {
    sudo.extraRules = [
      {
        users = [ "ai" ];
        commands = [];
      }
    ];

    pam.loginLimits = [
      { domain = "ai"; type = "hard"; item = "nproc"; value = "1000"; }
      { domain = "ai"; type = "hard"; item = "nofile"; value = "2048"; }
      { domain = "ai"; type = "hard"; item = "as"; value = "2097152000"; } # 2GB address space in bytes
    ];
  };

}
