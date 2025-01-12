{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1; # start counting a 1 
    mouse = true;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "screen-256color";
    extraConfig = ''
      # Leder Key
      unbind C-Space
      set -g prefic C-Space
      bind C-Space send-prefix

      set -as terminal-features ",xterm-256color:RGB"

      # Keep history
      set-option -g history-limit 5000
      
      # New Split Windows Shortcuts
      bind | split-window -hc "#{pane_current_path}"
      bind - split-window -vc "#{pane_current_path}"

      # Keep current path on new window 
      bind c new-window -c "#{pane_current_path}"

      # Copy Mode (enter copy mode with B)
      setw -g mode-keys vi
      bind v copy-mode
      # Setup 'v' to begin selection sa in VIM
      bind-key -T copt-mode-vi v send -X begin-selection
      bind -T copy-mode-vi 'C-v' send -X begin-selection\; send -X rectangle-toggle
      bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -r -sel clip" 

      # Window stuff 
      set -g window-status-seperator ""
      set -g status-left-lengt 0
    extraConfig = builtins.readFile ../../../.tmux.conf; 
      set -g status-left "#[fg=#{@thm_fg} bold] #S: "
      set -ga status-left "#[?client_prefix,#[fg=#{@thm_red} bold]PREFIX ,#{?#{==:#{pane_mode},copy-mode},#[fg=#{@thm_yellow} bold]COPY ,#[fg=#{@thm_green} bold]NORMAL }}" 
      set -g status-right = ""
    '';
  plugins = with pkgs; [
  # {
  #   plugin = tmuxPlugins.resurrect;
  #   extraConfig = "set -g @resurrect-strategy-nvim 'session'";
  # }
  # {
  #   plugin = tmuxPlugins.continuum;
  #   extraConfig = ''
  # set -g @continuum-restore 'on'
  #   '';
  # }
  ];
  };
}
