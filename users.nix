{
  available-users = {
    tscolari = {
      username = "tscolari";
      fullName = "Tiago Scolari";
      homeDir  = "/home/tscolari";

      backgroundImage = "background-1.jpg";
      accentColor     = "green";
      zshTheme        = "sorin";
      kittyTheme      = "Afterglow";
      iconTheme       = "Zafiro-icons-Dark";

      extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" ];

      git = {
        githubUser = "tscolari";
        email = "git@tscolari.me";
      };
    };

    work = {
      username = "work";
      fullName = "Tiago Work";
      homeDir  = "/home/work";

      backgroundImage = "background-3.jpg";
      accentColor     = "red";
      zshTheme        = "powerlevel10k";
      kittyTheme      = "ayu_mirage";
      iconTheme       = "Zafiro-icons-Dark";

      extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" ];

      dashApps = [
          "firefox.desktop"
          "kitty.desktop"
          "slack.desktop"
          "obsidian.desktop"
          "org.gnome.Calendar.desktop"
          "org.gnome.Nautilus.desktop"
      ];

      git = {
        githubUser = "tscolari";
        email = "git@tscolari.me";
      };
    };
  };
}
