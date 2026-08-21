---@class dh.plugins.tasks.task_manager
local task_manager = {}
local overseer = require("overseer")
local dap = require("dap")

---@param config dh.plugins.config.tasks.overseer
local function open_on_enter(config)
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
		group = "dh.plugins.tasks.autocmd",
		callback = function()
			if not config.open_on_enter then
				return
			end
			if dap.status() ~= "" then
				return
			end
			overseer.open({ enter = false })
		end,
	})
end

---@param config dh.plugins.config.tasks.overseer
local function close_on_leave(config)
	vim.api.nvim_create_autocmd("BufLeave", {
		pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
		group = "dh.plugins.tasks.autocmd",
		callback = function()
			if not config.close_on_leave then
				return
			end
			if dap.status() ~= "" then
				return
			end
			overseer.close()
		end,
	})
end

---@param config dh.plugins.config.tasks.overseer
local function open_on_debug_exit(config)
	dap.listeners.before.event_terminated.overseer_config = function()
		if not config.open_on_debug_exit then
			return
		end
		overseer.open({ enter = false })
	end
	dap.listeners.before.event_exited.overseer_config = function()
		if not config.open_on_debug_exit then
			return
		end
		overseer.open({ enter = false })
	end
end

---@param config dh.plugins.config.tasks.overseer
local function close_on_debug_enter(config)
	dap.listeners.before.attach.overseer_config = function()
		if not config.close_on_debug_enter then
			return
		end
		overseer.close()
	end
	dap.listeners.before.launch.overseer_config = function()
		if not config.close_on_debug_enter then
			return
		end
		overseer.close()
	end
end

---@param config dh.plugins.config.tasks.overseer
local function overseer_setup(config)
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

---@param config dh.plugins.config.tasks
local function toggleterm_setup(config)
	require("toggleterm").setup({
		size = 20,
	})
end

---@param config dh.plugins.config.tasks
function task_manager.setup(config)
	toggleterm_setup(config)
	overseer_setup(config.overseer)

	vim.api.nvim_create_augroup("dh.plugins.tasks.autocmd", { clear = false })
	open_on_enter(config.overseer)
	close_on_leave(config.overseer)
	open_on_debug_exit(config.overseer)
	close_on_debug_enter(config.overseer)
end

return task_manager
