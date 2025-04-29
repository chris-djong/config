{ user, services, pkgs, ... }: {
  # Printing
  services.printing.enable = true;
  # IPP Everywhere autodiscovery 
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Scanning 
  # NOTE: Command scanimage 
  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  users.users.${user}.extraGroups = [ "scanner" "lp" ];
}
