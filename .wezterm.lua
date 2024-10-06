-- Initial.
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Fonts.
config.font = wezterm.font("MesloLGS NF")
config.font_size = 12

-- Disable tab bar.
config.enable_tab_bar = false

-- Color
-- config.color_scheme = 'Solarized (dark) (terminal.sexy)'
config.color_scheme = 'Sakura'

return config
