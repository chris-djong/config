{
  description = "Development Environment";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      fhs = pkgs.buildFHSUserEnv {
        name = "fhs-shell";
        runScript = "zsh";
        profile = ''
          export LIBRARY_PATH=/usr/lib
          export C_INCLUDE_PATH=/usr/include
          export CPLUS_INCLUDE_PATH=/usr/include
          export CMAKE_LIBRARY_PATH=/usr/lib
          export CMAKE_INCLUDE_PATH=/usr/include bash
        '';
        targetPkgs = with pkgs;
          pkgs: [
            nodejs_22
            python312
            gnumake

            zlib # required by numpy
            stdenv.cc.cc # required by numpy
            binutils_nogold # add some libraries that are needed for entourage compilation

            # General formatters/linters that are not project specific 
            sqlfluff
            shfmt
            shellcheck
            clang-tools
            nixfmt-classic
            stylua
          ];
      };
    in { devShells.${system}.default = fhs.env; };
}

