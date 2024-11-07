{ config, pkgs, environment, services, hardware, ... }:

{
  environment.systemPackages = with pkgs; [
    webkitgtk_4_1
    gtk3
    libusb1
  ];

  hardware.keyboard.zsa.enable = true;

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "zsa_udev";
      text = ''
# Rules for Oryx web flashing and live training
KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

# Wally Flashing rules for the Ergodox EZ
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
      '';

      destination = "/etc/udev/rules.d/50-zsa.rules";
    })
  ];
}

