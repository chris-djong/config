{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-wsl, home-manager, ... }:
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
            proxy = null;
          };
          modules = [
            ./hosts/chris-laptop/configuration.nix
            home-manager.nixosModules.default
          ];
        };
        chris-wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit user inputs stateVersion;
            hostname = "chris-wsl";
            proxy = "http://10.56.4.40:8080";
          };
          modules = [
            ./hosts/chris-wsl/configuration.nix
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.default
          ];
        };
      };
    };
}
