{
  config,
  pkgs,
  ...
}:

let

  homeDir = config.userData.homeDir;
  firefoxBin = "${pkgs.unstable.firefox}/bin/firefox";

in
{
  home = {
    file = {
      # "${homeDir}/.config/zsh/p10k.zsh".source = ./files/p10k.zsh;
      "${homeDir}/.local/share/applications/work-firefox.desktop".text = ''
        [Desktop Entry]
        Actions=new-private-window;new-window;profile-manager-window
        Categories=Network;WebBrowser
        Exec=${firefoxBin} -P "work" --no-remote %U
        GenericName=Web Browser
        Icon=firefox
        MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;x-scheme-handler/http;x-scheme-handler/https
        Name=Work Firefox
        StartupNotify=true
        StartupWMClass=Work Firefox
        Terminal=false
        Type=Application
        Version=1.4
        X-Desktop-File-Install-Version=0.27

        [Desktop Action new-private-window]
        Exec=${firefoxBin} -P "work" --no-remote --private-window %U
        Name=New Private Window

        [Desktop Action new-window]
        Exec=${firefoxBin} -P "work" --no-remote --new-window %U
        Name=New Window

        [Desktop Action profile-manager-window]
        Exec=${firefoxBin} -P "work" --no-remote --ProfileManager
        Name=Profile Manager
      '';
      "${homeDir}/.local/share/applications/personal-firefox.desktop".text = ''
        [Desktop Entry]
        Actions=new-private-window;new-window;profile-manager-window
        Categories=Network;WebBrowser
        Exec=${firefoxBin} -P "personal" --no-remote %U
        GenericName=Web Browser
        Icon=firefox-nightly
        MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;x-scheme-handler/http;x-scheme-handler/https
        Name=Personal Firefox
        StartupNotify=true
        StartupWMClass=PersonalFirefox
        Terminal=false
        Type=Application
        Version=1.4
        X-Desktop-File-Install-Version=0.27

        [Desktop Action new-private-window]
        Exec=${firefoxBin} -P "personal" --no-remote --private-window %U
        Name=New Private Window

        [Desktop Action new-window]
        Exec=${firefoxBin} -P "personal" --no-remote --new-window %U
        Name=New Window

        [Desktop Action profile-manager-window]
        Exec=${firefoxBin} -P "Personal" --no-remote --ProfileManager
        Name=Profile Manager
      '';
      "${homeDir}/.config/zsh/extended_path.zsh" = {
        text = ''
          #!/usr/bin/env zsh
          export PATH="$HOME/bin:$PATH"
        '';
      };
    };
  };
}
