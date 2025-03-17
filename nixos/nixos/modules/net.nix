{ hostname, proxy, ... }: {
  networking.networkmanager.enable = true;
  networking.hostName = hostname;
  # Set the proxy environmental variables
  networking.proxy.default = proxy;
  networking.proxy.noProxy = "localhost,0.0.0.0,127.0.0.1";
}
