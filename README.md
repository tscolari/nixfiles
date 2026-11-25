# nixfiles

My Nix configurations for NixOS laptops/desktops and macOS (via nix-darwin).

It's public for consultation,
and I would not expect people to be actively using this: **I push and force push, and make breaking changes without warnings**.

Check my [homenix](https://github.com/tscolari/homenix) flake for the actual home-manager configuration and packages that this uses.
`Homenix` is where the fun things are; this repo is mostly the system glue around it.

## Hosts

| Host     | Platform                  | Notes                                          |
|----------|---------------------------|------------------------------------------------|
| `bebop`  | NixOS, x86_64-linux       | ThinkPad T14, Hyprland                         |
| `happy`  | NixOS, x86_64-linux       | AMD CPU/GPU desktop, Hyprland, gaming          |
| `cowboy` | macOS, aarch64-darwin     | nix-darwin on top of Determinate Nix, Amethyst |

## Layout

```
flake.nix              # inputs, overlays, mkSystem / mkDarwinSystem, host list
users.nix              # user definitions shared by all hosts
configuration.nix      # base NixOS configuration
nixos/
  common/              # applied to every NixOS host
  modules/             # boot, networking, keyboard, agenix, ai (ollama), ...
  roles/desktop/       # GNOME, xserver, catppuccin, desktop packages
darwin/
  configuration.nix    # base nix-darwin configuration
  common/              # applied to every darwin host
  modules/             # agenix, ollama (launchd agent), nix.custom.conf
home-manager/          # home-manager entrypoint + per-user overrides (by-user/)
hosts/<name>/          # host-specific config and hardware
secrets/               # agenix-encrypted secrets and their recipients
```

Overlays expose `pkgs.unstable` (nixos-unstable) and `pkgs.master` (nixpkgs master)
on both platforms, plus the `homenix` overlay.

## Installation

### NixOS

Either clone the repo into `/etc/nixos`, or link `/etc/nixos` to where this repository is cloned, then:

```sh
sudo nixos-rebuild switch --flake .#<host>
```

### macOS

1. Install [Determinate Nix](https://determinate.systems/nix-installer/).
   nix-darwin is configured with `nix.enable = false` so it doesn't fight Determinate over
   `/etc/nix/nix.conf`; Nix settings are written to `/etc/nix/nix.custom.conf` instead
   (see `darwin/modules/nix.nix`).
2. Clone the repo and bootstrap nix-darwin:

   ```sh
   sudo nix run nix-darwin -- switch --flake .#<host>
   ```

3. Afterwards:

   ```sh
   sudo darwin-rebuild switch --flake .#<host>
   ```

## Secrets

Secrets are managed with [agenix](https://github.com/ryantm/agenix).
Each host has its own age identity at `/var/lib/agenix/key.txt`:

```sh
sudo age-keygen -o /var/lib/agenix/key.txt
sudo age-keygen -y /var/lib/agenix/key.txt   # public key to add to secrets/secrets.nix
```

Add the public key to `secrets/secrets.nix`, then re-key from a machine that can already decrypt:

```sh
cd secrets && agenix -r
```

Currently the only secret is `access-tokens`, a GitHub token included into Nix's config so
flake input fetches aren't rate limited.

## Adding a host

1. Create `hosts/<name>/default.nix` (for NixOS, add `generated.nix` from `nixos-generate-config`).
2. Add it to `nixosConfigurations` (`mkSystem`) or `darwinConfigurations` (`mkDarwinSystem`) in `flake.nix`.
3. Add its age key to `secrets/secrets.nix` and re-key.
