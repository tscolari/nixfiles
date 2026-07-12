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
  services.ollama = {
    enable = true;
    # pkgs.ollama is bumped to 0.31.1 via the overlay in flake.nix
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "65536";
    };
  };
}
