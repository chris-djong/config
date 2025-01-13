{ proxy, ... }: {
  imports = [
    ../../nixos/modules/audio.nix
    ../../nixos/modules/bluetooth.nix
    ../../nixos/modules/net.nix
    ../../nixos/modules/nix.nix
    ../../nixos/modules/timezone.nix
    ../../nixos/modules/user.nix
    ../../nixos/modules/gbc.nix
    ../../nixos/modules/fonts.nix
    ../../nixos/modules/docker.nix
  ];
}
