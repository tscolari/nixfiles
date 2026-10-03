{
  ...
}:

{
  services.ollama = {
    enable = true;
    # pkgs.ollama comes from nixos-unstable via the overlay in flake.nix
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "65536";
    };
  };
}
