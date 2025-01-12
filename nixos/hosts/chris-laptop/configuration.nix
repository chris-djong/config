# Edit this configuration file to define what should be installed on your system.  # Help is available in the configuration.nix(5) man page and in the NixOS manual
# (accessible by running ‘nixos-help’).

{ inputs, stateVersion, hostname, ... }:

{
  imports =
    [ ./hardware-configuration.nix ./local-packages.nix ../../nixos/modules ];

  networking.hostName = hostname;

  environment.systemPackages = [ inputs.home-manager ];

  system.stateVersion = stateVersion;
}
