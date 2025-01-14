{ pkgs, ... }: {

  programs.tmux = {
    enable = true;
    baseIndex = 1; # start counting a 1
    mouse = true;
    escapeTime = 0;
    prefix = "C-Space";
    keyMode = "vi";
    historyLimit = 5000;
    terminal = "screen-256color";
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10min'
        '';
      }
    ];
    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"

      # New Split Windows Shortcuts
      bind | split-window -hc "#{pane_current_path}"
      bind - split-window -vc "#{pane_current_path}"

      # Keep current path on new window 
      bind c new-window -c "#{pane_current_path}"

      # Bind B to copy mode
      bind b copy-mode
      # V for general copy selection
      bind-key -T copy-mode-vi v send -X begin-selection
      # Ctrl V for column selection
      bind-key -T copy-mode-vi 'C-v' send -X begin-selection\; send -X rectangle-toggle
      # Y to copy to clipboard
      bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -r -sel clip" 

      # Styling for the overal status
      set -g status-style "bg=#191A24 fg=white"
      set -g status-left "#{?client_prefix,#[fg=red bold]PREFIX ,#{?#{==:#{pane_mode},copy-mode},#[fg=yellow bold]COPY ,#[fg=green bold]NORMAL }}"
      set -g status-right ""

      # Styling for the inidividual windows. Note that status means the small tab on the bottom of the window
      # The window style is the full window 
      set -g window-status-style 'bg=#0000ff,fg=#000000'
      set -g window-status-current-style 'bg=#00ff00,fg=#000000'
      set -g window-status-format "#W (#I)"
      set -g window-status-current-format "#W (#I)"
    '';
  };
}
