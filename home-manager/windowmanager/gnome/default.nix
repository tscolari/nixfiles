{
  pkgs,
  config,
  ...
}:

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

    packages = with pkgs; [
      desktop-file-utils
      gnome-builder
      gnome-settings-daemon
      gnome-tweaks
      pinentry-gnome3
      gnome.gvfs
      arc-icon-theme
      arc-theme
      flat-remix-icon-theme
      fluent-icon-theme
      (pkgs.graphite-gtk-theme.override {
        colorVariants = [
          "light"
          "dark"
        ];
        themeVariants = [
          "default"
          "purple"
          "blue"
          "red"
        ];
        sizeVariants = [ "standard" ];
        tweaks = [ "rimless" ];
      })
      numix-cursor-theme
      numix-icon-theme
      papirus-icon-theme
      reversal-icon-theme
      zafiro-icons
    ];
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
