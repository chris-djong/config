{ stateVersion, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos/modules/bluetooth.nix
    ../../nixos/modules/boot.nix
    ../../nixos/modules/net.nix
    ../../nixos/modules/nix.nix
    ../../nixos/modules/timezone.nix
    ../../nixos/modules/user.nix
    ../../nixos/modules/gbc.nix
    ../../nixos/modules/fonts.nix
    ../../nixos/modules/docker.nix
    ../../nixos/modules/printing.nix
    ../../nixos/modules/hyprland.nix
    ../../nixos/modules/home-manager.nix
  ];

  system.stateVersion = stateVersion;
}
