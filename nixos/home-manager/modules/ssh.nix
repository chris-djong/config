{ proxy, lib, ... }:
let
  cleanProxy = if proxy != null then
    builtins.replaceStrings [ "http://" ] [ "" ] proxy
  else
    null;
in {
  programs.ssh.enable = true;
  programs.ssh.matchBlocks."*".proxyCommand =
    lib.mkIf (cleanProxy != null) "nc -X connect -x ${cleanProxy} %h %p";
  # In general FHS environments the SSH config has wrong permissions because of the nixos store 
  # To overcome this, we move it to a config_source file on changes and simply rewrite it with a change in permissions
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange =
      "cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config";
  };
}
