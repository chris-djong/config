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
      homeStateVersion = "24.11";
      hostname = "chris-laptop"; 
    in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit user hostname;
        };
        modules = [
          ./hosts/chris-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.chris = import ./home-manager/home.nix; 
            home-manager.extraSpecialArgs = {
              inherit homeStateVersion user;
            };
          }
        ];
      };
    };
  };
}
