{ proxy }: {
  programs.ssh.matchBlocks = if proxy != null then {
    "*" = { "ProxyCommand" = "nc -X connect -x ${proxy} %h %p"; };
  } else
    { };
}
