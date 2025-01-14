{ pkgs, ... }:
let
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
  patchedpython = pkgs.symlinkJoin {
    name = "python-env";
    paths = [ pkgs.python312 ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/python3.12" --prefix LD_LIBRARY_PATH : "${pythonldlibpath}"
    '';
  };
in pkgs.mkShell {
  buildInputs = [ patchedpython ];
  plugins = [ ];
}

