{ pkgs, ... }:
let theme = import ./theme.nix;
in {

  programs.tmux = {
    enable = true;
    baseIndex = 1; # start counting a 1
    mouse = true;
    escapeTime = 0;
    prefix = "C-Space";
    keyMode = "vi";
    historyLimit = 5000;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [{
      plugin = resurrect;
      extraConfig = ''
        set -g @resurrect-strategy-vim 'session'
        set -g @resurrect-strategy-nvim 'session'
        set -g @resurrect-capture-pane-contents 'on'
      '';
    }];
    extraConfig = ''
      set -g allow-rename off
      set -ag terminal-overrides ",xterm-256color:RGB"

      # New Split Windows Shortcuts
      bind | split-window -hc "#{pane_current_path}"
      bind - split-window -vc "#{pane_current_path}"

      # Keep current path on new window 
      bind c new-window -c "#{pane_current_path}"

      # switch panes using home row keys
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D

      # Bind B to copy mode
      bind b copy-mode
      # V for general copy selection
      bind-key -T copy-mode-vi v send -X begin-selection
      # Ctrl V for column selection
      bind-key -T copy-mode-vi 'C-v' send -X begin-selection\; send -X rectangle-toggle
      # Y to copy to clipboard
      bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -r -sel clip" 

      # Styling for the overal status
      set -g status-style "bg=${theme.bg} fg=${theme.fg}"
      set -g status-left "#{?client_prefix,#[fg=${theme.red} bold] PREFIX ,#{?#{==:#{pane_mode},copy-mode},#[fg=${theme.yellow} bold] COPY ,#[fg=${theme.green} bold] NORMAL }}"
      set -g status-right ""

      # Styling of the individual panes 
      set -g pane-border-style 'fg=${theme.fg}'
      set -g pane-active-border-style 'fg=${theme.green}'

      # Styling for the inidividual windows. Note that status means the small tab on the bottom of the window
      # The window style is the full window 
      set -g window-status-style 'bg=${theme.inactive_bg},fg=${theme.fg}'
      set -g window-status-current-style 'bg=${theme.blue},fg=#000000'
      set -g window-status-format " #I: #W "
      set -g window-status-current-format " #I: #W "
    '';
  };
}
