{ proxy, lib, ... }: {
  programs.ssh.enable = true;
  programs.ssh.matchBlocks."*".proxyCommand =
    lib.mkIf (proxy != null) "nc -X connect -x ${proxy} %h %p";
}
