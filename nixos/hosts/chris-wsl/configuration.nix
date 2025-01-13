# Edit this configuration file to define what should be installed on your system.  # Help is available in the configuration.nix(5) man page and in the NixOS manual
# (accessible by running ‘nixos-help’).

{ inputs, stateVersion, user, hostname, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.home-manager.nixosModules.default
    ./nixos-config.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = user;
  wsl.interop.includePath = true;

  environment.systemPackages = [ inputs.home-manager ];

  system.stateVersion = stateVersion;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs user;
      homeStateVersion = stateVersion;
    };
    users = { "${user}" = import ./home.nix; };
  };
}
