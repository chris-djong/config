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
        mkShell { buildInputs = [ pkgs.nodejs_22 ]; };
    };
}
