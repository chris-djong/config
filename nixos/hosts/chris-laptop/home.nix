{ homeStateVersion, user, ... }: {
  imports = [ ../../home-manager/modules ../../home-manager/home-packages.nix ];
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };
}
