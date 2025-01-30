{
  description = "Python Environment";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; };

  outputs = { self, nixpkgs }:
    let system = "x86_64-linux";
    in {
      devShells.default = with pkgs;
        mkShell { buildInputs = [ python313 uv ]; };
    };
}
