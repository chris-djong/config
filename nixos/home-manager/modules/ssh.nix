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
}
