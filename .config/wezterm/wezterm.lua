local wezterm = require 'wezterm'

local function split(s, delimiter)
    local result = {}
    for match in (s):gmatch(delimiter) do
    	  wezterm.log_info(match)
    	  for label, id in (match):gmatch('[^\t]+') do
	        table.insert(result, {id=id, label=label})
        end
    end
    return result
end

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
	{ key = ".", mods = "CMD", action = wezterm.action_callback(function(window, pane)
		wezterm.log_info("running...")
		local success, items, error = wezterm.run_child_process { os.getenv('SHELL'), '-l', '-c', 'rbw list --fields name,user' }
		wezterm.log_info("got something")
		if not success then
			wezterm.log_error('error getting items', error)
			return
		end

		local choices = split(items, "[^\r\n]+")
		wezterm.log_info(choices)

		window:perform_action(
			wezterm.action.InputSelector({
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not label then
						wezterm.log_error("Invalid label", label)
						return
					end
					wezterm.log_info("id = " .. id)
					wezterm.log_info("label = " .. label)

					local success, password, error = wezterm.run_child_process { os.getenv 'SHELL', '-l', '-c', 'rbw get ' .. id .. '@' .. label }
					if not success then
						wezterm.log_error('error getting password', error)
						return
					end

					pane:send_text(password)
				end),
				title = "finding a password",
				choices = choices,
				fuzzy = true,
				fuzzy_description = "password for...",
		}),
		pane
	)

	end)},
}



return config
