{
  pkgs,
  ...
}:

let

  fhsEnv = pkgs.buildFHSEnv {
    name = "fhs";
    targetPkgs =
      pkgs: with pkgs; [
        nodejs
        bun
        lerna

        zlib
        jdk
      ];
    runScript = "zsh";
  };

in
{

  environment.systemPackages = [
    fhsEnv
  ];
}
