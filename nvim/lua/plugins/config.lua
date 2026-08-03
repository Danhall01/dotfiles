---@type dh.plugins.config
local config = {
	blink_cmp = {
		keybinds = require("keymap.config").navigation.auto_complete,
	},
	overseer = {
		keybinds = require("keymap.config").overseer,
		debug_log = {
			enabled = true,
			path = "bin/",
			log_name = "dap",
		},
		cmake_build_timeout = 3,
		open_on_enter = true,
		close_on_leave = false,
		open_on_debug_exit = true,
		close_on_debug_enter = true,
	},
	oil = {
		keybinds = require("keymap.config").navigation.oil,
		auto_git = {
			add = false,
			mv = false,
			rm = false,
		},
	},
}

return config
