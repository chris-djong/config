{ proxy }: {

  shellAliases = {
    vi = "nvim";
    vim = "nvim";
    cd = "z";
    ll = "ls -al";
    set_env = ". .venv/bin/activate";
    pbox = "boxes -s 74x1 -a c";
    dev = "nix develop --profile ~/flake-profile -c $SHELL";
  };

  sessionVariables = let
    proxyVars = if proxy != null then {
      HTTP_PROXY = proxy;
      HTTPS_PROXY = proxy;
      http_proxy = proxy;
      https_proxy = proxy;
      NO_PROXY = "localhost,127.0.0.1,0.0.0.0";
      no_proxy = "localhost,127.0.0.1,0.0.0.0";
    } else
      { };
  in {

    # Use fd instead of fzf for faster searches
    FZF_DEFAULT_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git";
    FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
    FZF_ALT_C_COMMAND =
      "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
    FZF_CTRL_T_OPTS =
      "--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --coolor=always --line-range :500 {}; fi'";
    FZF_ALT_C_OPTS = "--preview 'eza --tree --color=always {} | head -200'";

  } // proxyVars;

}
