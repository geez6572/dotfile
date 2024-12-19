local key_modile = {}
local wezterm = require("wezterm")

local keys = {

	-- switch tab
	{ key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = wezterm.action.ActivateTab(-1) },

	-- move tab
	{ key = "[", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "]", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "{", mods = "ALT|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
	{ key = "}", mods = "ALT|SHIFT", action = wezterm.action.MoveTabRelative(1) },
	{ key = "Return", mods = "ALT", action = wezterm.action.ToggleFullScreen },

	-- resize font
	{ key = "m", mods = "ALT", action = wezterm.action.Hide },
	{ key = "=", mods = "ALT", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "ALT", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "ALT", action = wezterm.action.ResetFontSize },
	-- toggle command
	{ key = ":", mods = "ALT|SHIFT", action = wezterm.action.ActivateCommandPalette },

	-- control tab
	{ key = "n", mods = "ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "N", mods = "ALT|SHIFT", action = wezterm.action.SpawnTab("DefaultDomain") },
	{ key = "q", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },

	-- new panel
	{ key = "F12", mods = "", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "F11", mods = "", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- resize panel
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

	-- switch panel
	{ key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "i", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "o", mods = "ALT", action = wezterm.action.TogglePaneZoomState },
	{ key = "Backspace", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

function key_modile.apply_to_config(config)
	--config.leader = { key = "Space", mods = "ALT", timeout_milliseconds = 1000 }
	config.keys = keys
	config.disable_default_key_bindings = true
end

return key_modile
