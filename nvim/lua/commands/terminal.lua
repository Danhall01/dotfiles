---@class commands_terminal
local terminal = {}

---@param config dh.commands.config.terminal
local function quickterm(config)
	local function TerminalExec(cmd)
		vim.cmd("botright new")
		vim.cmd("resize " .. tostring(config.height))

		vim.cmd("terminal " .. cmd)
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.signcolumn = "no"

		vim.cmd("startinsert")
	end
	vim.api.nvim_create_user_command("Term", function(argv)
		TerminalExec((argv.args or ""))
	end, {
		force = true,
		desc = "Attempts to execute the given arguments as a shell command into a termporary terminal.",
		nargs = "*",
	})
end

---@param config dh.commands.config
function terminal.setup(config)
	quickterm(config.terminal)
end

return terminal
