{ inputs, config, pkgs, services, user, ... }: {
  services.printing = true;
  # IPP Everywhere autodiscovery 
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
