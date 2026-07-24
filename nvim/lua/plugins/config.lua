---@type dh.plugins.config
local config = {
	blink_cmp = {
		keybinds = require "keymap.config".navigation.auto_complete,
	},
}

return config
