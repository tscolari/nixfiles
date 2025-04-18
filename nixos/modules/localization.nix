{ config, pkgs, lib, ... }:

{
  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT    = "en_GB.UTF-8";
    LC_MONETARY       = "en_GB.UTF-8";
    LC_NAME           = "en_GB.UTF-8";
    LC_NUMERIC        = "en_GB.UTF-8";
    LC_PAPER          = "en_GB.UTF-8";
    LC_TELEPHONE      = "en_GB.UTF-8";
    LC_TIME           = "en_GB.UTF-8";
  };

  # Set your time zone.
  services.automatic-timezoned.enable = true;
  services.geoclue2 = {
    enable         = true;
    geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
  };
}
