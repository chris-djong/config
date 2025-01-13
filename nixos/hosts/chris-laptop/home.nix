{ homeStateVersion, user, ... }: {
  imports = [ ./home-config.nix ];
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };
}
