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
	tasks = {
		overseer = {
			keybinds = keybinds.overseer,
			debug_log = {
				enabled = true,
				display_all_on_enter = true,
				path = "bin/",
				log_name = "dap",
			},
			timeouts = {
				build_events = 3,
				log_events = "exit",
				destroy_on_exit = true,
			},
			open_on_enter = true,
			close_on_leave = false,
			open_on_debug_exit = true,
			close_on_debug_enter = true,
		},
		runners = {
			keybinds = keybinds.tasks,
			runners_by_ft = {
				c = "CMakeRun",
				cpp = "CMakeRun",
			},
			builder_by_ft = {
				c = "CMakeBuild",
				cpp = "CMakeBuild",
			},
			builder_config_by_ft = {
				c = "CMakeSelectBuildType",
				cpp = "CMakeSelectBuildType",
			},
			debugger_by_ft = {
				c = "CMakeDebug",
				cpp = "CMakeDebug",
			},
			debugger_current_by_ft = {
				c = "CMakeDebugCurrentFile",
				cpp = "CMakeDebugCurrentFile",
			},
		},
	},
	cpptools = {
		keybinds = keybinds.cpp,
	},
}

return config
