---@type dh.keymap.config
local keybinds = require("keymap.config")

---@type dh.plugins.config
local config = {
	blink_cmp = {
		keybinds = keybinds.navigation.auto_complete,
	},
	oil = {
		keybinds = keybinds.navigation.oil,
		auto_git = {
			add = false,
			mv = false,
			rm = false,
		},
	},
	session = {
		save_on_exit = true,
		load_on_enter = true,
		auto_save = {
			enabled = false,
			interval = 300,
			notify = true,
		},
	},
}

return config
