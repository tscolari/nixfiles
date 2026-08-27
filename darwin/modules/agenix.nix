{ inputs, pkgs, ... }:

{
  age.secrets.access-tokens = {
    file = ../../secrets/access-tokens.age;
    path = "/run/agenix/access-tokens";
    owner = "tscolari";
    group = "wheel";
    mode = "0400";
  };

  age.identityPaths = [ "/var/lib/agenix/key.txt" ];

  # The access-tokens secret is pulled into Nix's config by ./nix.nix.

  environment.systemPackages = [ inputs.agenix.packages.${pkgs.system}.default ];
}
