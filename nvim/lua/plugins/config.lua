---@type dh.plugins.config
local config = {
	blink_cmp = {
		keybinds = require("keymap.config").navigation.auto_complete,
	},
	overseer = {
		keybinds = require("keymap.config").overseer,
		debug_log = {
			enabled = true,
			display_all_on_enter = true,
			path = "bin/",
			log_name = "dap",
		},
		timeouts = {
			build_events = 3,
			log_events = 10,
		},
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
