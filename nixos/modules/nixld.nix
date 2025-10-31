{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    dev.enable = false;

    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      icu
      openssl

      libgcc
      glibc
    ];
  };
}
