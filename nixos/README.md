# NIX OS Config

Just small useful commands I don't want to forget

## Building

    ```

nixos-rebuild switch --flake ./#<hostname> # or nixos-install --flake ./#<hostname> if you are installing on a fresh system
home-manager switch --flake ./#<hostname>

```

## Changing XServer Keys

In order to swap caps with ESC somehow it looks like the gsettings options are built once and don't pick up the changes to the configuration.nix. To overcome this run the following commands and restart

```

ssettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources

```

```
