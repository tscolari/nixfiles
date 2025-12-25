{
  pkgs,
  ...
}:
{
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.kernelModules = [ "kvm-intel" ];
  hardware.enableAllFirmware = true;
  console = {
    keyMap = "us";
  };

}
