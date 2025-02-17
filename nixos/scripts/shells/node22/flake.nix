{
  description = "Node Environment";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = with pkgs;
        mkShell { buildInputs = [ pkgs.nodejs_22 ]; };
    };
}
