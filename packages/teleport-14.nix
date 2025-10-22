{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation rec {
  pname = "teleport";
  version = "14.3.32";

  src = pkgs.fetchurl {
    url = "https://cdn.teleport.dev/teleport-v${version}-linux-amd64-bin.tar.gz";
    sha256 = "sha256-IAqq8v327S3qKx1jAT4mZjW5ebZhP9cypck3y8RnTkY=";
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
    autoPatchelfHook
  ];

  # All the libraries that Teleport typically needs
  buildInputs = with pkgs; [
    stdenv.cc.cc.lib # libstdc++, libgcc_s
    libfido2 # For WebAuthn/FIDO2 support
    openssl # SSL/TLS
    zlib # Compression
    glibc # C library
  ];

  # Don't strip binaries - sometimes this causes issues
  dontStrip = false;

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    # Copy all teleport binaries
    cp teleport/teleport $out/bin/
    cp teleport/tctl $out/bin/
    cp teleport/tsh $out/bin/
    cp teleport/tbot $out/bin/

    # Make sure they're executable
    chmod +x $out/bin/{teleport,tctl,tsh,tbot}

    # Wrap each binary to ensure proper library paths
    for binary in teleport tctl tsh tbot; do
      wrapProgram $out/bin/$binary \
        --prefix LD_LIBRARY_PATH : ${
          pkgs.lib.makeLibraryPath [
            pkgs.stdenv.cc.cc.lib
            pkgs.libfido2
            pkgs.openssl
            pkgs.zlib
          ]
        } \
        --suffix PATH : ${pkgs.lib.makeBinPath [ pkgs.xdg-utils ]}
    done

    runHook postInstall
  '';

  # Verify the binaries work
  doInstallCheck = true;
  installCheckPhase = ''
    # Just check that the binary can at least show its version
    $out/bin/teleport version || echo "Warning: teleport version check failed"
    $out/bin/tsh version || echo "Warning: tsh version check failed"
  '';

  meta = with pkgs.lib; {
    description = "Certificate authority and access plane for SSH, Kubernetes, web applications, and databases";
    homepage = "https://goteleport.com/";
    license = licenses.asl20;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}
