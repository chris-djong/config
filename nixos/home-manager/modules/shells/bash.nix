{ proxy, ... }:
let shared = import ./shared.nix { inherit proxy; };
in {
  programs.bash = {
    enable = true;

    sessionVariables = shared.sessionVariables;
    shellAliases = shared.shellAliases;
  };
}
