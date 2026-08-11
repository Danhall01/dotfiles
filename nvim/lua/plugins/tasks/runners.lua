---@class dh.plugins.tasks.runners
local runners = {}

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

---@param config dh.plugins.tasks.config.runners
local function keybinds(config)
	if not config.keybinds.run.disabled then
		vim.keymap.set("n", config.keybinds.run.keybind, function()
			local cmd = get_cmd_func(config.runners_by_ft)
			if cmd then
				cmd()
			end
		end, { desc = "Start runner for selected file" })
	end

	if not config.keybinds.build.disabled then
		vim.keymap.set("n", config.keybinds.build.keybind, function()
			local cmd = get_cmd_func(config.builder_by_ft)
			if cmd then
				cmd()
			end
		end, { desc = "Start builder for selected file" })
	end
	if not config.keybinds.set_build_type.disabled then
		vim.keymap.set("n", config.keybinds.set_build_type.keybind, function()
			local cmd = get_cmd_func(config.builder_config_by_ft)
			if cmd then
				cmd()
			end
		end, { desc = "Configure builder for current file" })
	end

	if not config.keybinds.debug.disabled then
		vim.keymap.set("n", config.keybinds.debug.keybind, function()
			local cmd = get_cmd_func(config.debugger_by_ft)
			if cmd then
				cmd()
			end
		end, { desc = "Start debugger for selected file" })
	end
	if not config.keybinds.debug_current.disabled then
		vim.keymap.set("n", config.keybinds.debug_current.keybind, function()
			local cmd = get_cmd_func(config.debugger_current_by_ft)
			if cmd then
				cmd()
			end
		end, { desc = "Start debugger for current file" })
	end
end

---@param config dh.plugins.tasks.config
function runners.setup(config)
	keybinds(config.runners)
end

return runners
