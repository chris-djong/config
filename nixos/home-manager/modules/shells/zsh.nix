{ config, proxy, ... }:
let shared = import ./shared.nix { inherit proxy; };
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    sessionVariables = shared.sessionVariables;
    shellAliases = shared.shellAliases;

    initExtra = ''
      if [ -n "$\{commands [ fzf-share ]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi
    '';
  };
}
