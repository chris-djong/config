local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('Iosevka NF')
config.font_size = 12

config.enable_tab_bar = false
config.color_scheme = 'tokyonight_night'

config.window_background_opacity = 0.95
return config
