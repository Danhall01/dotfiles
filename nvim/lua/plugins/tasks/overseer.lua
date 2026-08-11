---@class dh.plugins.tasks.overseer
local overseer = {}

---@param config dh.plugins.config.overseer
local function overseer_setup(config)
	local overseer = require("overseer")
	overseer.setup({
		dap = true,
		output = {
			use_terminal = true,
			preserve_output = true,
		},

		component_aliases = {
			default = {
				"on_exit_set_status",
				--"on_complete_notify",
				--{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
		},

		-- Configure task list
		task_list = {
			direction = "bottom",
			max_height = 0.3,
			min_height = 0.1,
			keymaps = {
				[config.keybinds.actions.keybind] = "keymap.run_action",
				[config.keybinds.open_float.keybind] = {
					"keymap.open",
					opts = { dir = "float" },
					desc = "Open task output in float",
				},
			},
		},

		-- Configure task floating output window
		task_win = {
			padding = 3,
		},
	})
end

---@param config dh.plugins.config
local function toggleterm_setup(config)
	require("toggleterm").setup({
		size = 20,
	})
end

---@param config dh.plugins.config
function overseer.setup(config)
	toggleterm_setup(config)
	overseer_setup(config.overseer)
end

return overseer
