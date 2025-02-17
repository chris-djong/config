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
            # Languages
            nodejs_22
            python313

            # Python packages
            uv
            postgresql # Required by psycopg, don't forget to install using pip install psycopg[c]

            # Formatters
            nodePackages.prettier
            ruff
            sqlfluff
            shfmt

            # Linters 
            eslint
            basedpyright
            shellcheck
          ];
          shellHook = ''
            export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}

            # Recursively search for .venv and activate it if found
            venv_dir=$(find "$PWD" -type d -name ".venv" -print -quit)
            if [ -n "$venv_dir" ]; then
              . "$venv_dir/bin/activate"
            fi
          '';
        };
    };
}
