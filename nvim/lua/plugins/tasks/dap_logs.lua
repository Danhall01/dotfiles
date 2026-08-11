---@class dh.plugins.tasks.dap_logs
local dap_logs = {}
local g_dap_logfile = nil
local g_log_index = 1

local g_components = { "default" }
local g_task_view = {}

---@return string date
local function get_current_date()
	return tostring(os.date("_%y-%m-%d"))
end

---@param file string
---@param session_index number
local function overseer_cat_logfile(file, session_index)
	local overseer = require("overseer")

	local task = overseer.new_task({
		name = "GDB Debug Log#" .. tostring(session_index),
		cmd = 'cat "' .. file .. '"',
		cwd = vim.fn.getcwd(),
		components = g_components,
	})
	table.insert(g_task_view, task)
	return task
end

---@param path string The path to the log files
local function orchestrator_display_all(path)
	local overseer = require("overseer")
	local cwd = vim.fn.getcwd()
	local content = vim.fn.glob(cwd .. "/" .. path .. "*", false, true)
	table.sort(content, function(s1, s2)
		return s1:match("_(%d+)%.log") > s2:match("_(%d+)%.log")
	end)

	local task_list = {}
	local i = g_log_index - 1
	for _, file in pairs(content) do
		local index = i
		local ordering_index = string.format("%03d:", g_log_index - i - 1)
		table.insert(task_list, {
			name = ordering_index .. "GDB Debug Log#" .. tostring(index),
			cmd = 'cat "' .. file .. '"',
			cwd = vim.fn.getcwd(),
		})
		i = i - 1
	end

	local task = overseer.new_task({
		name = "Display old debug records",
		cmd = "",
		components = g_components,
		strategy = {
			"orchestrator",
			tasks = task_list,
		},
	})
	table.insert(g_task_view, task)
	return task
end

---@param config dh.plugins.tasks.config.overseer
local function setup_components(config)
	if not config.timeouts.log_events then
		return
	end
	if type(config.timeouts.log_events) == "number" then
		vim.tbl_extend("keep", g_components, {
			{
				"on_complete_dispose",
				timeout = config.timeouts.log_events,
			},
		})
	end
	if not config.timeouts.destroy_on_exit and not config.timeouts.log_events == "exit" then
		return
	end
	vim.api.nvim_create_autocmd("ExitPre", {
		group = "dh.plugins.tasks.dap_logs",
		callback = function()
			for _, task in ipairs(g_task_view) do
				if not task:is_disposed() then
					task:dispose(true)
				end
			end
		end,
	})
end

---@param config dh.plugins.tasks.config.overseer.debug_log
local function update_counter(config)
	local cwd = vim.fn.getcwd()
	local content = vim.fn.glob(cwd .. "/" .. config.path .. "*", false, true)
	if vim.tbl_isempty(content) then
		return
	end
	g_log_index = #content + 1
end

---@param config dh.plugins.tasks.config.overseer.debug_log
local function attach_log_task(config)
	local function create_logview_task()
		if not g_dap_logfile then
			return
		end
		g_dap_logfile.file:flush()
		g_dap_logfile.file:close()

		-- Dispatch task
		overseer_cat_logfile(g_dap_logfile.name, g_log_index):start()
		g_log_index = g_log_index + 1
		g_dap_logfile = nil
	end

	-- Attach DAP to overseer tasks
	local dap = require("dap")
	local cwd = vim.fn.getcwd()
	dap.listeners.after.event_initialized["overseer-debug-output"] = function()
		vim.fn.mkdir(cwd .. "/" .. config.path, "p") -- Ensure log path exists
		g_dap_logfile = {
			name = cwd .. "/" .. config.path .. config.log_name .. get_current_date() .. string.format(
				"_%03d",
				g_log_index
			) .. ".log",
		}
		g_dap_logfile.file = io.open(g_dap_logfile.name, "w")
		if not g_dap_logfile.file then
			vim.notify(
				"Could not create logfile for DAP session: " .. g_dap_logfile.name,
				vim.diagnostic.severity.ERROR
			)
			return
		end
		vim.notify("Created logfile: " .. g_dap_logfile.name)
	end
	dap.listeners.after.event_output["overseer-debug-output"] = function(_, body)
		if not g_dap_logfile then
			return
		end
		if body.output then
			local write_block = string.gsub(body.output, "\\033", "\27")
			g_dap_logfile.file:write(write_block)
			g_dap_logfile.file:flush()
		end
	end
	dap.listeners.after.event_terminated["overseer-debug-output"] = create_logview_task
	dap.listeners.after.event_exited["overseer-debug-output"] = create_logview_task
end

---@param config dh.plugins.tasks.config.overseer.debug_log
local function register_user_commands(config)
	local cwd = vim.fn.getcwd()
	vim.api.nvim_create_user_command("DisplayLog", function(argv)
		if argv.args == "." or argv.args == "*" then
			orchestrator_display_all(config.path):start()
			return
		end
		local index = tonumber(argv.args)
		index = index or g_log_index - 1
		if index <= 0 then
			index = (g_log_index - 1) + index
		end
		if index > (g_log_index - 1) or index < 1 then
			vim.notify(
				string.format("Only %d log file(s) exist in bin directory", g_log_index - 1),
				vim.log.levels.WARN
			)
			return
		end

		-- Locate file with correct index
		local content = vim.fn.glob(cwd .. "/" .. config.path .. "*", false, true)
		local fname = nil
		for _, file in pairs(content) do
			if string.find(file, string.format("_%03d.log", index)) then
				fname = file
				break
			end
		end
		if not fname then
			return
		end

		overseer_cat_logfile(fname, index):start()
	end, {
		desc = "(ext) Runs a task to open the log file of given index in overseer",
		nargs = "?",
	})
end

---@param config dh.plugins.tasks.config
function dap_logs.setup(config)
	vim.api.nvim_create_augroup("dh.plugins.tasks.dap_logs", {})

	if config.overseer.debug_log.enabled then
		setup_components(config.overseer)
		update_counter(config.overseer.debug_log)
		if config.overseer.debug_log.display_all_on_enter then
			vim.schedule(function()
				orchestrator_display_all(config.overseer.debug_log.path):start()
			end)
		end
		attach_log_task(config.overseer.debug_log)
		register_user_commands(config.overseer.debug_log)
	end
end

return dap_logs
