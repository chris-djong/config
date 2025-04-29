{ user, ... }: {
  virtualisation = {
    docker = {
      enable = false;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
