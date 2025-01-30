{
  description = "Python Environment";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # Make the library path depending on what packages you need
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
        zlib # required by numpy
        stdenv.cc.cc # required by numpy
      ]);
    in {
      devShells.${system}.default = with pkgs;
        mkShell {
          buildInputs = [
            python313
            uv
            # Install some binaries seperately because nix can not handle them otherwise
            ruff
            basedpyright
            # postgresql # Required by psycopg, don't forget to install using pip install psycopg[c]
          ];
          shellHook = ''
            export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
            if test ! -d .venv; then
              python -m venv .venv
            fi
            . .venv/bin/activate
          '';
        };
    };
}
