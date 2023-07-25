# In /home/floork/devshell.nix

{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    openssl.dev
    pkgconfig
    rustup
    # Add any other development tools or packages you need for your project
  ];

  # Optional: Set any additional environment variables required for your project
  shellHook = ''
    export OPENSSL_DIR=$(pkg-config --variable=prefix openssl)
    export PKG_CONFIG_PATH=$(pkg-config --variable=prefix openssl)/lib/pkgconfig
  '';
}

