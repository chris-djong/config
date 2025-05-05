# NIX OS Config

Just small useful commands I don't want to forget

## Building

```
nixos-rebuild switch --flake ./#<hostname> # or nixos-install --flake ./#<hostname> if you are installing on a fresh system
home-manager switch --flake ./#<hostname>

```

In case you dont have a nixos system, but using debian for example, you just need to install the nix package manager.

Then use the following command to build your home environment

```
nix build ./#homeConfigurations.zit-server.activationPackage
```

This will build the activation environment to a ./result folders. Check that folder if the config is correct and if so run the following to activate the home manager config

```
./result/activate
```
