{ pkgs, nixpkgs, home-manager, nixos-wsl, ... }: {
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
        inherit user stateVersion;
        hostname = hostname;
        proxy = proxy;
      };
      modules = if isWsl then [
        nixos-wsl.nixosModules.default
        ./${hostname}/configuration.nix
      ] else [
        nixos-wsl.nixosModules.default
        ./${hostname}/configuration.nix
      ];
    };
}
