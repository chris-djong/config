{ config, pkgs, ...}: {
  home = {
    username = "chris";
    homeDirectory = "/home/chris";
    stateVersion = "24.11"; 
  };
  imports = [ ./myHome ];
}
