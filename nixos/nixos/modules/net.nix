{ hostname, proxy, ... }: {
  networking.networkmanager.enable = true;
  networking.hostName = hostname;
  # Set the proxy environmental variables
  networking.proxy.default = proxy;
}
