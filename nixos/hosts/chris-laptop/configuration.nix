# Edit this configuration file to define what should be installed on your system.  # Help is available in the configuration.nix(5) man page and in the NixOS manual
# (accessible by running ‘nixos-help’).

{ inputs, stateVersion, user, hostname, proxy, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nixos-config.nix
    inputs.home-manager.nixosModules.default
  ];

  environment.systemPackages = [ inputs.home-manager ];

  system.stateVersion = stateVersion;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs user proxy;
      homeStateVersion = stateVersion;
    };
    users = { "${user}" = import ./home.nix; };
    backupFileExtension = "old";
  };
}
