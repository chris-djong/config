{ pkgs, user, proxy, ... }: {
  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  users.users.${user}.extraGroups = [ "docker" ];

  virtualisation.docker.daemon.settings = if proxy != null then {
    proxies = {
      http-proxy = proxy;
      https-proxy = proxy;
      no-proxy = "";
    };
  } else
    { };
}
