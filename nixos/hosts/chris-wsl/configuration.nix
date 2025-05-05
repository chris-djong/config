# Edit this configuration file to define what should be installed on your system.  # Help is available in the configuration.nix(5) man page and in the NixOS manual
# (accessible by running ‘nixos-help’).

{ user, stateVersion, ... }: {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../../nixos/modules/net.nix
    ../../nixos/modules/nix.nix
    ../../nixos/modules/timezone.nix
    ../../nixos/modules/user.nix
    ../../nixos/modules/gbc.nix
    ../../nixos/modules/fonts.nix
    ../../nixos/modules/docker.nix
    ../../nixos/modules/home-manager.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = user;
  wsl.interop.includePath = false;

  system.stateVersion = stateVersion;
}
