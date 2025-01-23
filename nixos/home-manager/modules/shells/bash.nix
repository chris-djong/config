{ proxy, ... }:
let shared = import ./shared.nix { inherit proxy; };
in {
  programs.bash = {
    enable = true;
    sessionVariables = shared.sessionVariables;
    shellAliases = shared.shellAliases;

    initExtra = ''
      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi
      # Setting prompt
      ${builtins.readFile ./prompt.sh}
      export PROMPT_COMMAND="update_ps1"
    '';
  };
}
