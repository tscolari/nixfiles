{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.ollama ];

  launchd.user.agents.ollama = {
    serviceConfig = {
      ProgramArguments = [
        "${pkgs.ollama}/bin/ollama"
        "serve"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      EnvironmentVariables = {
        OLLAMA_CONTEXT_LENGTH = "65536";
      };
    };
  };
}
