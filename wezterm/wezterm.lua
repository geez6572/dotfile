-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
local keybinds = require("keybinds")

local ui = require("ui")
ui.apply_to_config(config)
keybinds.apply_to_config(config)

config.term = "wezterm"

return config
