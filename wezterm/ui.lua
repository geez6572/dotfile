local ui = {}
local wezterm = require("wezterm")

function ui.apply_to_config(config)
	config.color_scheme_dirs = { "./theme" }
	config.color_scheme = "tokyonight"

	-- tab bar
	config.use_fancy_tab_bar = false
	config.enable_tab_bar = true

	config.window_decorations = "RESIZE"

	-- opacity
	-- background
	config.window_background_opacity = 0.7
	config.text_background_opacity = 1

	--font
	config.font = wezterm.font("Hack", { italic = true })
	config.font_size = 18
	config.cell_width = 1.1
	config.line_height = 1.1

	config.window_padding = {
		left = 8,
		right = 0,
		bottom = 0,
		top = 12,
	}
end
return ui
