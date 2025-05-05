{ pkgs, nixpkgs, home-manager, ... }: {
  # Helper function for generating home-manager configs
  mkHome = { user, proxy, stateVersion, hostname }:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit user;
        proxy = proxy;
        homeStateVersion = stateVersion;
      };
      modules = [ ./${hostname}/home-config.nix ];
    };

  mkNixos = { user, proxy, stateVersion, hostname }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit user stateVersion;
        hostname = hostname;
        proxy = proxy;
      };
      modules = [ ./${hostname}/configuration.nix ];
    };
}
