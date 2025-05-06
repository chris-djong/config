{ pkgs, nixos-wsl, nixpkgs, home-manager, system, ... }: {
  # Helper function for generating home-manager configs
  mkHome = { user, proxy, stateVersion, hostname, isGenericLinux }:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit user isGenericLinux;
        proxy = proxy;
        homeStateVersion = stateVersion;
      };
      modules = [ ./${hostname}/home-config.nix ];
    };

  mkNixos = { user, proxy, stateVersion, hostname, isWsl }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit nixos-wsl user stateVersion;
        hostname = hostname;
        proxy = proxy;
      };
      system = system;
      modules = [ ./${hostname}/configuration.nix ];
    };
}
