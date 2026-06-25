{ inputs, pkgs, ... }:

{
  age.secrets.access-tokens = {
    file = ../../secrets/access-tokens.age;
    path = "/run/agenix/access-tokens";
    owner = "tscolari";
    group = "root";
    mode = "0400";
  };

  age.identityPaths = [ "/var/lib/agenix/key.txt" ];

  nix.extraOptions = ''
    !include /run/agenix/access-tokens
  '';

  environment.systemPackages = [ inputs.agenix.packages.${pkgs.system}.default ];
}
