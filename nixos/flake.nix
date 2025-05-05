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
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      helper =
        import ./hosts/helpers.nix { inherit pkgs nixpkgs home-manager; };
    in {
      homeConfigurations = {
        chris-laptop = helper.mkHome {
          user = user;
          proxy = null;
          stateVersion = stateVersion;
          hostname = "chris-laptop";
          isGenericLinux = false;
        };
        chris-wsl = helper.mkHome {
          user = user;
          proxy = "http://10.56.4.40:8080";
          stateVersion = stateVersion;
          hostname = "chris-wsl";
          isGenericLinux = false;
        };
      };
      nixosConfigurations = {
        chris-laptop = helper.mkNixos {
          user = user;
          proxy = null;
          stateVersion = stateVersion;
          hostname = "chris-laptop";
        };
        chris-wsl = helper.mkNixos {
          user = user;
          proxy = "http://10.56.4.40:8080";
          stateVersion = stateVersion;
          hostname = "chris-wsl";
        };
      };
    };
}
