---@class dh.plugins.tasks.runners
local runners = { cmds = {} }

local function get_cmd_func(runner_list)
	local ft = vim.bo.filetype
	local cmd = runner_list[ft]
	if type(cmd) == "string" then
		cmd = function()
			vim.cmd(runner_list[ft])
		end
	elseif type(cmd) == "table" then
		cmd = function()
			vim.cmd(table.concat(runner_list[ft], " "))
		end
	end

	if type(cmd) ~= "function" then
		vim.notify(("Unable to parse runner for ft: %s; Invalid config"):format(ft), vim.log.levels.ERROR)
		return nil
	end
	return cmd
end

local function generate_func(func_by_ft)
	return function()
		local cmd = get_cmd_func(func_by_ft)
		if cmd then
			cmd()
		end
	end
end

---@param config dh.plugins.config.tasks
function runners.register(config)
	local runnables = config.runners
	local bindings = runnables.keybinds

	if not bindings.run.disabled then
		vim.keymap.set(
			"n",
			bindings.run.keybind,
			generate_func(runnables.runners_by_ft),
			{ desc = "Start runner for selected file" }
		)
	end
	vim.api.nvim_create_user_command("Run", generate_func(runnables.runners_by_ft), {})

	if not bindings.build.disabled then
		vim.keymap.set(
			"n",
			bindings.build.keybind,
			generate_func(runnables.builder_by_ft),
			{ desc = "Start builder for selected file" }
		)
	end
	vim.api.nvim_create_user_command("Build", generate_func(runnables.builder_by_ft), {})
	if not bindings.set_build_type.disabled then
		vim.keymap.set(
			"n",
			bindings.set_build_type.keybind,
			generate_func(runnables.builder_config_by_ft),
			{ desc = "Configure builder for current file" }
		)
	end
	vim.api.nvim_create_user_command("BuildConfig", generate_func(runnables.builder_config_by_ft), {})

	if not bindings.debug.disabled then
		vim.keymap.set(
			"n",
			bindings.debug.keybind,
			generate_func(runnables.debugger_by_ft),
			{ desc = "Start debugger for selected file" }
		)
	end
	vim.api.nvim_create_user_command("Debug", generate_func(runnables.debugger_by_ft), {})
	if not bindings.debug_current.disabled then
		vim.keymap.set(
			"n",
			bindings.debug_current.keybind,
			generate_func(runnables.debugger_current_by_ft),
			{ desc = "Start debugger for current file" }
		)
	end
	vim.api.nvim_create_user_command("DebugCurrent", generate_func(runnables.debugger_current_by_ft), {})

	runners.cmds = {
		"Run",
		"Build",
		"BuildConfig",
		"Debug",
		"DebugCurrent",
	}
end

return runners
