{ pkgs ? import <nixpkgs> { } }:
let
  # Make the library path depending on what packages you need
  pythonldlibpath = pkgs.lib.makeLibraryPath (with pkgs; [
    zlib
    zstd
    stdenv.cc.cc
    curl
    openssl
    attr
    libssh
    bzip2
    libxml2
    acl
    libsodium
    util-linux
    xz
    systemd
  ]);
  # Create the python environment
  patchedpython = pkgs.symlinkJoin {
    name = "python-env";
    paths = [ pkgs.python312 ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/python3.12" --prefix LD_LIBRARY_PATH : "${pythonldlibpath}"
    '';
  };
in pkgs.mkShell {
  buildInputs = [ patchedpython pkgs.python312Packages.pip ];
  packages = [ ];
}

