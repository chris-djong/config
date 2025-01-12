{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1; # start counting a 1 
    mouse = true;
    escapeTime = 0;
    prefix = "C-Space";
    keyMode = "vi";
    terminal = "screen-256color";
    historyLimit = 5000;
    plugins = with pkgs; [
      # must be before continuum edits right status bar
      {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = '' 
	  set -g @catppuccin_flavor 'mocha' # latte, frappe, macchiato or mocha

          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_current_number_color "#{@thm_green}"
          set -g @catppuccin_window_text ""
          set -g @catppuccin_window_number "#[bold]#I: #{window_name}"
          set -g @catppuccin_window_current_text ""
          set -g @catppuccin_window_current_number "#[bold]#I: #{window_name}"
          set -g @catppuccin_window_status_style "custom"
          set -g @catppuccin_window_right_separator "#[fg=#{@_ctp_status_bg},reverse]#[none]"
         
          set -g @catppuccin_window_left_separator "#[fg=#{@_ctp_status_bg}]#[none]"
          set -g @catppuccin_window_middle_separator "#[bg=#{@catppuccin_window_number_color},fg=#{@catppuccin_window_text_color}]"
          set -g @catppuccin_window_current_middle_separator "#[bg=#{@catppuccin_window_current_number_color},fg=#{@catppuccin_window_current_text_color}]"
          '';
      }
      # {
      #     plugin = tmuxPlugins.resurrect;
      #     extraConfig = ''
      #     set -g @resurrect-strategy-vim 'session'
      #     set -g @resurrect-strategy-nvim 'session'
      #     set -g @resurrect-capture-pane-contents 'on'
      #     '';
      # }
      # {
      #     plugin = tmuxPlugins.continuum;
      #     extraConfig = ''
      #     set -g @continuum-restore 'on'
      #     set -g @continuum-boot 'on'
      #     set -g @continuum-save-interval '10'
      #     '';
      # }
    ];
    extraConfig = ''
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


      set -g status-left-length 0
      set -g status-left "#[fg=#{@thm_fg} bold] #S: "
      set -ga status-left "#{?client_prefix,#[fg=#{@thm_red} bold]PREFIX ,#{?#{==:#{pane_mode},copy-mode},#[fg=#{@thm_yellow} bold]COPY ,#[fg=#{@thm_green} bold]NORMAL }}"
      set -g status-right ""
    '';
  };
}
