{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.ollama ];

  launchd.user.agents.ollama = {
    serviceConfig = {
      ProgramArguments = [
        "${pkgs.master.ollama}/bin/ollama"
        "serve"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      EnvironmentVariables = {
        OLLAMA_CONTEXT_LENGTH = "131072";
        OLLAMA_KV_CACHE_TYPE = "q8_0";
        OLLAMA_FLASH_ATTENTION = "1";
      };
    };
  };
}
