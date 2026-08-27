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
}
