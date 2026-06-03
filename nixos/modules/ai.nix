{
  config,
  pkgs,
  environment,
  services,
  hardware,
  lib,
  ...
}:

{
  # users.users.ai = {
  #   isNormalUser = true;
  #   description = "AI User";
  #   createHome = false;
  #   group = "users";
  #   home = "/home/ai";
  #   shell = pkgs.zsh;
  #
  #   packages = with pkgs; [
  #     # unstable.aider-chat
  #     nodejs
  #     yarn
  #   ];
  # };
  #
  # environment.etc."profile.d/ai-umask.sh".text = ''
  #   if [ "$USER" = "ai" ]; then
  #     umask 002
  #   fi
  # '';
  #
  # systemd = {
  #   services.mount-ai-workspace = {
  #     description = "Mount bindfs GOPATH for ai";
  #     wantedBy = [ "multi-user.target" ];
  #     after = [ "local-fs.target" ];
  #     path = with pkgs; [
  #       bash
  #       bindfs
  #       coreutils
  #     ];
  #     serviceConfig = {
  #       Type = "oneshot";
  #       RemainAfterExit = true;
  #
  #       ExecStartPre = [
  #         "${pkgs.coreutils}/bin/mkdir -p /srv/ai-go"
  #         "${pkgs.coreutils}/bin/mkdir -p /home/ai/go"
  #         "${pkgs.coreutils}/bin/chown ai:users /srv/ai-go"
  #         "${pkgs.coreutils}/bin/chown ai:users /home/ai/go"
  #       ];
  #
  #       ExecStart = ''
  #         ${pkgs.bindfs}/bin/bindfs \
  #         --force-user=ai \
  #         --force-group=users \
  #         --perms=u=rwX:g=rwX:o= \
  #         /srv/ai-go /home/ai/go
  #       '';
  #     };
  #   };
  #
  #   tmpfiles.rules = [
  #     "d /home/ai 0770 ai users -"
  #     "d /srv/ai-go 0770 ai users -"
  #   ];
  # };

  # services.ollama = {
  #   enable = true;
  #   acceleration = false; # CPU only - no GPU
  #   host = "127.0.0.1";
  #   port = 11434;
  #   home = "/var/lib/ollama";
  #   package = pkgs.ollama;
  # };
  #
  # systemd.services.ollama = {
  #   wants = [ "network-online.target" ];
  #   after = [ "network-online.target" ];
  # };
  #
  # systemd.services.ollama-pull-qwen = {
  #   description = "Pull qwen2.5-coder:14b model for Ollama";
  #   wantedBy = [ "multi-user.target" ];
  #   wants = [ "network-online.target" ];
  #   after = [ "network-online.target" "ollama.service" ];
  #   requires = [ "ollama.service" ];
  #   path = with pkgs; [ ollama curl ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     ExecStart = "${pkgs.ollama}/bin/ollama pull qwen2.5-coder:14b";
  #   };
  # };

  security = {
    sudo.extraRules = [
      {
        users = [ "ai" ];
        commands = [ ];
      }
    ];

    pam.loginLimits = [
      {
        domain = "ai";
        type = "hard";
        item = "nproc";
        value = "1000";
      }
      {
        domain = "ai";
        type = "hard";
        item = "nofile";
        value = "2048";
      }
      {
        domain = "ai";
        type = "hard";
        item = "as";
        value = "2097152000";
      } # 2GB address space in bytes
    ];
  };

}
