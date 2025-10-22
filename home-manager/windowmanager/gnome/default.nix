{
  config,
  ...
}@args:

let

  backgroundImage = config.userData.backgroundImage;
  homeDir = config.userData.homeDir;

in
{
  imports = [
    ./settings.nix
    ./extensions.nix
    ./keybindings.nix
  ];

  home = {
    file = {
      "${homeDir}/.background.jpg".source = ../../files/${backgroundImage};
    };
  };

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

  gtk.enable = true;
}
