{ lib, ... }:

{
  options.custom.keyboard.extraXkbOptions = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };
}
