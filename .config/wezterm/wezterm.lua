local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.color_scheme = 'new-moon'
config.audible_bell = 'Disabled'
config.font_size = 22.0

config.use_fancy_tab_bar = false
config.tab_max_width = 25
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- https://github.com/wez/wezterm/issues/253#issuecomment-672007120
config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
}

return config
