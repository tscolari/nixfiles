# nixfiles
My nix configurations

# how to install

link the files to /etc/nixos:

```
configuration.nix           -> nixfiles/configuration.nix
hardware-configuration.nix  -> nixfiles/machines/dellxps-hardware-configuration.nix
users                       -> nixfiles/users
```


# Darwin / Macos

After installing nix on macos.

1. Ensure channels home-manager, unstable and darwin are configured

```
> nix-channel --list
darwin https://github.com/LnL7/nix-darwin/archive/master.tar.gz
home-manager https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz
nixos-unstable https://nixos.org/channels/nixpkgs-unstable
```

2. Clone/link this repo to ~/.nixpkgs

3. Rebuild
