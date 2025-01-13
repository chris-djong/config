{ hostname, proxy, ... }: {
  networking.networkmanager.enable = true;
  networking.hostName = hostname;
  networking.proxy.default = proxy;
}
