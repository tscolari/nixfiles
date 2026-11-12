{ ... }:

# This host runs Determinate Nix, which owns /etc/nix/nix.conf and rewrites it on
# upgrade. That forces `nix.enable = false`, which in turn makes every `nix.*`
# option in nix-darwin a silent no-op -- so settings have to go here instead.
# Determinate's nix.conf ends with `!include nix.custom.conf`, which is ours.

{
  environment.etc."nix/nix.custom.conf".text = ''
    trusted-users = root @admin tscolari
    auto-optimise-store = true

    # Redundant under Determinate Nix (it enables both by default), kept explicit
    # so the intent survives a move back to upstream Nix.
    experimental-features = nix-command flakes

    # GitHub token, so flake input fetches are not rate limited as anonymous.
    # Provided by ./agenix.nix; `!include` is a no-op if the secret is missing,
    # which keeps activation working before agenix has run.
    !include /run/agenix/access-tokens
  '';

  # Determinate's automatic GC only trims ~1GB at a time and keeps every profile
  # generation, and it holds the GC lock while it runs. It is off; the daily job
  # below replaces it.
  environment.etc."determinate/config.json".text = builtins.toJSON {
    garbageCollector.strategy = "disabled";
  };

  # `nix.gc` is one of the no-op `nix.*` options, so the job is declared by hand.
  # It drops profile generations older than 2 days (the current one is always
  # kept) and then deletes every store path no longer reachable from a root.
  # launchd runs a missed StartCalendarInterval on the next wake.
  launchd.daemons.nix-gc.serviceConfig = {
    ProgramArguments = [
      "/nix/var/nix/profiles/default/bin/nix-collect-garbage"
      "--delete-older-than"
      "2d"
    ];
    StartCalendarInterval = [
      {
        Hour = 12;
        Minute = 0;
      }
    ];
    StandardOutPath = "/var/log/nix-gc.log";
    StandardErrorPath = "/var/log/nix-gc.log";
    LowPriorityIO = true;
    ProcessType = "Background";
  };
}
