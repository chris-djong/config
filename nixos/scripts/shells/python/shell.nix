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
    paths = [ pkgs.python313 ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/python3.13" --prefix LD_LIBRARY_PATH : "${pythonldlibpath}"
    '';
  };
in pkgs.mkShell {
  buildInputs = [
    patchedpython
    pkgs.python313Packages.pip
    pkgs.postgresql # in case you use psycopg. Don't forget to install using pip install psycopg[c]
  ];
  packages = [ ];
  shellHook = ''
    if test ! -d .venv; then
      python -m venv .venv
    fi
    . .venv/bin/activate
  '';

}

