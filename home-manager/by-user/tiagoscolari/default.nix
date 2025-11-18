{
  config,
  ...
}:

let

  homeDir = config.userData.homeDir;

in
{
  home = {
    file = {
      # "${homeDir}/.config/zsh/p10k.zsh".source = ./files/p10k.zsh;
      "${homeDir}/.local/share/applications/work-firefox.desktop".source = ./files/work-firefox.desktop;
      "${homeDir}/.local/share/applications/personal-firefox.desktop".source =
        ./files/personal-firefox.desktop;
      "${homeDir}/.config/zsh/extended_path.zsh" = {
        text = ''
          #!/usr/bin/env zsh
          export PATH="$HOME/bin:$PATH"
        '';
      };
    };
  };
}
