{ proxy, ... }: {
  programs.git = {
    enable = true;
    userName = "Chris";
    userEmail = "git@dejong.lu";
    aliases = { st = "status"; };
    ignores = [ ];
  };

}
