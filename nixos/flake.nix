{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      user = "chris";
      stateVersion = "24.11";
    in {
      nixosConfigurations = {
        chris-laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit user inputs stateVersion;
            hostname = "chris-laptop";
          };
          modules = [
            ./hosts/chris-laptop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
